local VehicleModule = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CarLib = require(ReplicatedStorage:WaitForChild("CarSystem"):WaitForChild("CarLibrary"))

local MIN_DT = 1 / 240

local WHEEL_C0 = 1
local WHEEL_OFFSET = 2
local WHEEL_TOUCHING = 3
local WHEEL_LOAD = 4
local FRAME_TIME = 5
local WHEEL_CFRAME = 6
local WHEEL_NORMAL = 7
local WHEEL_HIT_DISTANCE = 8

local FRONT_WHEELS = { RDD = true, RDI = true }

local clientConnections = setmetatable({}, { __mode = "k" })
local steeringStates = setmetatable({}, { __mode = "k" })
local wheelGeometry = setmetatable({}, { __mode = "k" })
local wheelSpinAngles = setmetatable({}, { __mode = "k" })
local drivetrainStates = setmetatable({}, { __mode = "k" })
local soundStates = setmetatable({}, { __mode = "k" })

local function sign(value)
	if value > 0 then return 1 elseif value < 0 then return -1 else return 0 end
end

local function clamp(value, minValue, maxValue)
	return math.max(minValue, math.min(maxValue, value))
end

local function lerp(from, to, alpha)
	return from + (to - from) * math.clamp(alpha, 0, 1)
end

local function projectOnPlane(axis, normal)
	if normal.Magnitude < 1e-6 then return axis.Unit end
	local projected = axis - axis:Dot(normal) * normal
	if projected.Magnitude < 1e-6 then
		local fallback = math.abs(normal.X) < 0.9 and Vector3.new(1, 0, 0) or Vector3.new(0, 0, 1)
		projected = fallback - fallback:Dot(normal) * normal
	end
	return projected.Unit
end

local function trianglePulse(elapsed, duration)
	if not duration or duration <= 1e-6 or elapsed <= 0 or elapsed >= duration then return 0 end
	local half = 0.5 * duration
	if elapsed <= half then return elapsed / half else return (duration - elapsed) / half end
end

local function getCarValues(car)
	return CarLib.CarValues[car:GetAttribute("CarType")] or CarLib.CarValues.DefaultValues
end

local function getFrameDt(currentFrame, previousFrame)
	if currentFrame and previousFrame and currentFrame[FRAME_TIME] and previousFrame[FRAME_TIME] then
		return math.max(MIN_DT, currentFrame[FRAME_TIME] - previousFrame[FRAME_TIME])
	end
	return MIN_DT
end

local function placeAtFrontAxle(basicParts, chassis, attachment)
	if not (attachment and basicParts and chassis) then return end
	local frontRight = basicParts:FindFirstChild("RDD")
	local frontLeft = basicParts:FindFirstChild("RDI")
	if not (frontRight and frontLeft) then return end
	local frontAxleCenter = (frontRight.Position + frontLeft.Position) * 0.5
	local up = chassis.CFrame.UpVector
	local forward = projectOnPlane(chassis.CFrame.LookVector, up)
	local right = forward:Cross(up).Unit
	attachment.WorldCFrame = CFrame.fromMatrix(frontAxleCenter, right, up)
end

local function storeRelativeOffsets(car, parts, root)
	if not (car and parts and root) then return end
	local offsets = {}
	for _, part in ipairs(parts) do
		if part ~= root then
			offsets[part] = root.CFrame:Inverse() * part.CFrame
		end
	end
	CarLib.CarsCFMrelatyve[car] = offsets
end

local function createWheelWelds(car, parts, root)
	if not (car and parts and root) then return end
	local offsets = CarLib.CarsCFMrelatyve[car] or {}
	for _, part in ipairs(parts) do
		if part ~= root and not part:FindFirstChild("CFPS") then
			local weld = Instance.new("Weld")
			weld.Name = "CFPS"
			weld.Part0 = root
			weld.Part1 = part
			weld.C0 = offsets[part] or CFrame.new()
			weld.Parent = part
		end
	end
end

local function getForceAttachmentCFrames(car, basicParts, chassis)
	local attachmentCFrames = {}
	local offsets = CarLib.CarsCFMrelatyve[car] or {}
	for _, wheel in ipairs(basicParts:GetChildren()) do
		if wheel ~= chassis then
			local offset = offsets[wheel]
			if offset then
				attachmentCFrames[wheel] = chassis.CFrame * offset * CFrame.new(0, -offset.Position.Y, 0)
					* CFrame.new(0, -chassis.Size.Y / 2, 0) * CFrame.Angles(-math.pi / 2, 0, 0)
			end
		end
	end
	return attachmentCFrames
end

local function createForceInstances(car, basicParts, chassis)
	if not (car and basicParts and chassis) then return end
	local attachmentCFrames = getForceAttachmentCFrames(car, basicParts, chassis)

	for _, wheel in ipairs(basicParts:GetChildren()) do
		if wheel ~= chassis then
			local attachmentName = "ATCH" .. wheel.Name
			if not chassis:FindFirstChild(attachmentName) then
				local attachment = Instance.new("Attachment", chassis)
				attachment.WorldCFrame = (attachmentCFrames[wheel] or wheel.CFrame) * CFrame.Angles(math.pi / 2, 0, 0)
				attachment.Name = attachmentName
				local wheelForce = Instance.new("VectorForce", attachment)
				wheelForce.Attachment0 = attachment
				wheelForce.Name = wheel.Name
				wheelForce.Visible = false
				wheelForce.Force = Vector3.zero
				wheelForce.RelativeTo = Enum.ActuatorRelativeTo.World
			end
			if not wheel:FindFirstChild(attachmentName) then
				local wheelAttachment = Instance.new("Attachment", wheel)
				wheelAttachment.Name = attachmentName
			end
		end
	end

	if not chassis:FindFirstChild("ATT_Drive") then
		local driveAttachment = Instance.new("Attachment", chassis)
		driveAttachment.Name = "ATT_Drive"
		local driveForce = Instance.new("VectorForce", driveAttachment)
		driveForce.Name = "VF_Drive"
		driveForce.Attachment0 = driveAttachment
		driveForce.RelativeTo = Enum.ActuatorRelativeTo.World
		driveForce.Force = Vector3.zero
	end

	local function ensureChassisForce(name)
		local attachment = chassis:FindFirstChild(name)
		if not attachment then
			attachment = Instance.new("Attachment", chassis)
			attachment.Name = name
			local force = Instance.new("VectorForce", attachment)
			force.RelativeTo = Enum.ActuatorRelativeTo.World
			force.Force = Vector3.zero
			force.ApplyAtCenterOfMass = false
		else
			local force = attachment:FindFirstChildOfClass("VectorForce")
			if force then force.ApplyAtCenterOfMass = false end
		end
	end
	ensureChassisForce("Aerodinamica")
	ensureChassisForce("Freno")
end

function VehicleModule.ServerSetup(car)
	if not car then return end
	local basicParts = car:WaitForChild("BasicParts")
	local chassis = basicParts:WaitForChild("Chasis")
	local parts = basicParts:GetChildren()
	storeRelativeOffsets(car, parts, chassis)
	createWheelWelds(car, parts, chassis)
	createForceInstances(car, basicParts, chassis)

	local seat = car:FindFirstChildOfClass("VehicleSeat")
	if seat then
		seat.MaxSpeed = 0
		seat.Torque = 0
		seat.TurnSpeed = 0
	end
end

local function castSuspensionRays(car, basicParts, chassis, values)
	if not (car and basicParts and chassis) then return end
	local frameData = {}
	local offsets = CarLib.CarsCFMrelatyve[car]

	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	rayParams.FilterDescendantsInstances = { car }
	rayParams.IgnoreWater = false
	rayParams.CollisionGroup = "Default"

	for _, wheel in ipairs(basicParts:GetChildren()) do
		if wheel == chassis then continue end
		local offset = offsets and offsets[wheel]
		if not offset then continue end

		local wheelConfig = (values.Wheels and values.Wheels[wheel.Name]) or {}
		local radius = wheelConfig.Radius or (wheel.Size.Y * 0.5)
		local restLength = math.max(wheelConfig.RestLen or values.SuspencionWeit or 1.8, 0.05)
		local droop = (wheelConfig.Droop ~= nil) and wheelConfig.Droop
			or (values.SuspensionDroop ~= nil) and values.SuspensionDroop
			or 0

		local mountCFrame = chassis.CFrame * offset
		local rayStart = (mountCFrame * CFrame.new(0, restLength / 2 + radius, 0)).Position
		local rayEnd = (mountCFrame * CFrame.new(0, -(restLength / 2 + radius + droop), 0)).Position
		local rayVector = rayEnd - rayStart
		local rayLength = rayVector.Magnitude

		if rayLength < 1e-6 then
			local wheelData = { chassis.CFrame:ToObjectSpace(mountCFrame), 0, false }
			wheelData[WHEEL_CFRAME] = wheel.CFrame
			wheelData[WHEEL_NORMAL] = Vector3.yAxis
			wheelData[WHEEL_HIT_DISTANCE] = math.huge
			frameData[wheel] = wheelData
			continue
		end

		local rayDirection = rayVector / rayLength
		local rayResult = workspace:Raycast(rayStart, rayVector, rayParams)

		local maxCompression = -restLength * 0.5
		local maxExtension = restLength * 0.5 + droop

		local wheelOffset, touching, groundNormal, hitDistance
		if rayResult then
			hitDistance = (rayResult.Position - rayStart):Dot(rayDirection)
			local wheelCenterAtHit = rayResult.Position - rayDirection * radius
			wheelOffset = math.clamp((wheelCenterAtHit - mountCFrame.Position):Dot(rayDirection), maxCompression, maxExtension)
			touching = true
			groundNormal = rayResult.Normal.Unit
		else
			wheelOffset = maxExtension
			touching = false
			groundNormal = Vector3.yAxis
			hitDistance = math.huge
		end

		local wheelCenter = mountCFrame.Position + rayDirection * wheelOffset

		local upAxis = -rayDirection
		local rightBase = (chassis.CFrame * offset.Rotation).RightVector
		local rightAxis = rightBase - rightBase:Dot(upAxis) * upAxis
		if rightAxis.Magnitude < 1e-6 then
			local fallback = chassis.CFrame.RightVector
			rightAxis = fallback - fallback:Dot(upAxis) * upAxis
		end
		rightAxis = rightAxis.Unit
		local backAxis = rightAxis:Cross(upAxis)
		local wheelCFrame = CFrame.fromMatrix(wheelCenter, rightAxis, upAxis, backAxis)

		local wheelData = { chassis.CFrame:ToObjectSpace(wheelCFrame), wheelOffset, touching }
		wheelData[WHEEL_CFRAME] = wheel.CFrame
		wheelData[WHEEL_NORMAL] = groundNormal
		wheelData[WHEEL_HIT_DISTANCE] = hitDistance
		frameData[wheel] = wheelData
	end

	frameData[FRAME_TIME] = time()
	CarLib.CarLastFrameRedner[car] = CarLib.CarRelativeChangsCFrams[car]
	CarLib.CarRelativeChangsCFrams[car] = frameData
end

local function getContactStats(car, basicParts, chassis)
	local frameData = CarLib.CarRelativeChangsCFrams[car]
	if not frameData then return false, 0 end
	local anyTouching, totalLoad = false, 0
	for _, wheel in ipairs(basicParts:GetChildren()) do
		local wheelData = wheel ~= chassis and frameData[wheel]
		if wheelData then
			if wheelData[WHEEL_TOUCHING] then anyTouching = true end
			totalLoad += wheelData[WHEEL_LOAD] or 0
		end
	end
	return anyTouching, totalLoad
end

local function applySuspensionForces(car, basicParts, chassis, values)
	local frameData = CarLib.CarRelativeChangsCFrams[car]
	local previousFrame = CarLib.CarLastFrameRedner[car]
	if not (frameData and basicParts and chassis) then return end

	local dt = getFrameDt(frameData, previousFrame)
	local anyTouching = getContactStats(car, basicParts, chassis)
	local massPerWheel = math.max((chassis.AssemblyMass or 1) / 4, 1)
	local maxForce = (values.SuspensionForceMaxMult or 3.5) * massPerWheel * workspace.Gravity

	for _, wheel in ipairs(basicParts:GetChildren()) do
		if wheel == chassis then continue end
		local wheelData = frameData[wheel]
		local wheelForce = chassis:FindFirstChild(wheel.Name, true)
		if not (wheelData and wheelForce and wheelForce:IsA("VectorForce")) then continue end

		local wheelConfig = (values.Wheels and values.Wheels[wheel.Name]) or {}
		local restLength = wheelConfig.RestLen or values.SuspencionWeit or 1.8
		local springStiffness = wheelConfig.SpringK or values.FuerzaDeResorte or 1200
		local dampingRatio = (wheelConfig.DampingRatio ~= nil) and wheelConfig.DampingRatio or (values.DampingRatio or 0.7)
		local damperCoefficient = wheelConfig.DamperC or values.FuerzaAmortiguacion
			or (2 * dampingRatio * math.sqrt(springStiffness * massPerWheel))

		local wheelOffset = wheelData[WHEEL_OFFSET] or restLength
		local previousWheelData = previousFrame and previousFrame[wheel]
		local previousOffset = (previousWheelData and previousWheelData[WHEEL_OFFSET]) or wheelOffset
		local compression = math.max(restLength - wheelOffset, 0)
		local previousCompression = math.max(restLength - previousOffset, 0)
		local compressionSpeed = anyTouching and (compression - previousCompression) / dt or 0

		local suspensionForce = 0
		if (wheelData[WHEEL_TOUCHING] or compression > 0) and anyTouching then
			suspensionForce = math.max(springStiffness * compression + damperCoefficient * compressionSpeed, 0)
		end
		suspensionForce = math.min(suspensionForce, maxForce)

		local forceDirection = (wheelData[WHEEL_NORMAL] and wheelData[WHEEL_NORMAL].Unit) or Vector3.yAxis
		wheelForce.RelativeTo = Enum.ActuatorRelativeTo.World
		wheelForce.Force = forceDirection * suspensionForce
		wheelData[WHEEL_LOAD] = suspensionForce
	end
end

local function getWheelGeometry(car, basicParts)
	if wheelGeometry[car] then return wheelGeometry[car] end
	local frontRight = basicParts:FindFirstChild("RDD")
	local frontLeft = basicParts:FindFirstChild("RDI")
	local rearRight = basicParts:FindFirstChild("RTD")
	local rearLeft = basicParts:FindFirstChild("RTI")
	if not (frontRight and frontLeft and rearRight and rearLeft) then return nil end

	local frontAxleCenter = (frontRight.Position + frontLeft.Position) / 2
	local rearAxleCenter = (rearRight.Position + rearLeft.Position) / 2
	local geometry = {
		wheelbase = (frontAxleCenter - rearAxleCenter).Magnitude,
		trackWidth = (frontRight.Position - frontLeft.Position).Magnitude,
	}
	wheelGeometry[car] = geometry
	return geometry
end

local function getMaxSteerDegrees(speed, steering)
	local lowSpeedMax = steering.MaxSteerDegLow
	local highSpeedMax = steering.MaxSteerDegHigh
	local referenceSpeed = steering.SpeedForMaxReduction or 80
	local alpha = clamp(speed / math.max(referenceSpeed, 1e-3), 0, 1)
	return lowSpeedMax + (highSpeedMax - lowSpeedMax) * alpha
end

local function updateSteering(car, basicParts, chassis)
	local frameData = CarLib.CarRelativeChangsCFrams[car]
	local previousFrame = CarLib.CarLastFrameRedner[car]
	if not (frameData and previousFrame) then return chassis.CFrame.LookVector, 0, 0 end

	local geometry = getWheelGeometry(car, basicParts)
	if not geometry then return chassis.CFrame.LookVector, 0, 0 end

	local dt = getFrameDt(frameData, previousFrame)
	local steering = getCarValues(car).Steering

	local seat = car:FindFirstChildOfClass("VehicleSeat")
	local steerInput = seat and clamp(-seat.Steer or 0, -1, 1) or 0
	if steering.InvertSteer then steerInput = -steerInput end

	local up = chassis.CFrame.UpVector
	local forward = projectOnPlane(chassis.CFrame.LookVector, up)
	local forwardSpeed = math.abs(chassis.AssemblyLinearVelocity:Dot(forward))
	local steerAngle = math.rad(getMaxSteerDegrees(forwardSpeed, steering)) * steerInput

	local targetRight, targetLeft = steerAngle, steerAngle
	if steering.Ackermann ~= false and math.abs(steerAngle) > 1e-5 then
		local wheelbase, trackWidth = geometry.wheelbase, geometry.trackWidth
		local turnRadius = wheelbase / math.max(math.tan(math.abs(steerAngle)), 1e-4)
		local innerAngle = math.atan(wheelbase / math.max(turnRadius - trackWidth * 0.5, 0.05))
		local outerAngle = math.atan(wheelbase / (turnRadius + trackWidth * 0.5))
		if steerAngle >= 0 then
			targetRight, targetLeft = innerAngle, outerAngle
		else
			targetRight, targetLeft = -outerAngle, -innerAngle
		end
	end

	local state = steeringStates[car]
	if not state then
		state = { right = 0, left = 0 }
		steeringStates[car] = state
	end

	local steerRate = math.rad(steering.SteerRateDegPerSec)
	local returnRate = math.rad(steering.ReturnRateDegPerSec)
	local function stepTowards(current, target)
		local returning = math.abs(target) < math.abs(current) and (current * target >= 0 or target == 0)
		local maxStep = (returning and returnRate or steerRate) * dt
		return current + clamp(target - current, -maxStep, maxStep)
	end
	state.right = stepTowards(state.right, targetRight)
	state.left = stepTowards(state.left, targetLeft)

	local averageAngle = 0.5 * (state.right + state.left)
	return (CFrame.fromAxisAngle(up, averageAngle) * forward).Unit, state.right, state.left
end

local function updateWheelSpin(car, basicParts, chassis, values, steerForward)
	local frameData = CarLib.CarRelativeChangsCFrams[car]
	local previousFrame = CarLib.CarLastFrameRedner[car]
	if not frameData then return end

	local dt = getFrameDt(frameData, previousFrame)
	local spinAngles = wheelSpinAngles[car]
	if not spinAngles then
		spinAngles = {}
		wheelSpinAngles[car] = spinAngles
	end
	local drivetrain = drivetrainStates[car]
	local anyTouching = getContactStats(car, basicParts, chassis)

	local up = chassis.CFrame.UpVector
	local forward = projectOnPlane(steerForward or chassis.CFrame.LookVector, up)

	for _, wheel in ipairs(basicParts:GetChildren()) do
		if wheel == chassis then continue end
		local wheelConfig = (values.Wheels and values.Wheels[wheel.Name]) or {}
		local radius = math.max(wheelConfig.Radius or (values.Tire and values.Tire.Radius) or (wheel.Size.Y * 0.5), 0.05)

		local angleStep = 0
		if anyTouching then
			if frameData[wheel] then
				angleStep = wheel.AssemblyLinearVelocity:Dot(forward) / radius * dt
			end
		else
			angleStep = ((drivetrain and drivetrain.airWheelSpeed) or 0) * dt
		end
		spinAngles[wheel] = (spinAngles[wheel] or 0) + angleStep
	end
end

local function applyWheelTransforms(car, basicParts, chassis, steerRight, steerLeft)
	local frameData = CarLib.CarRelativeChangsCFrams[car]
	if not frameData then return end
	local spinAngles = wheelSpinAngles[car] or {}
	local frontRight = basicParts:FindFirstChild("RDD")
	local frontLeft = basicParts:FindFirstChild("RDI")

	for _, wheel in ipairs(basicParts:GetChildren()) do
		if wheel == chassis then continue end
		local baseC0 = frameData[wheel] and frameData[wheel][WHEEL_C0]
		if not baseC0 then continue end
		local weld = wheel:FindFirstChild("CFPS")
		if not weld then continue end

		local spin = CFrame.Angles(spinAngles[wheel] or 0, 0, 0)
		if wheel == frontRight and steerRight then
			weld.C0 = baseC0 * CFrame.Angles(0, steerRight, 0) * spin
		elseif wheel == frontLeft and steerLeft then
			weld.C0 = baseC0 * CFrame.Angles(0, steerLeft, 0) * spin
		else
			weld.C0 = baseC0 * spin
		end
	end
end

local function applyLateralTireForces(car, basicParts, chassis, steerRight, steerLeft)
	local frameData = CarLib.CarRelativeChangsCFrams[car]
	if not frameData then return end
	local offsets = CarLib.CarsCFMrelatyve[car]
	if not offsets then return end

	local tire = getCarValues(car).Tire or {}
	local lateralFriction = tire.MuLat or 1.0
	local stiffnessFactor = tire.PacejkaB or 8.0
	local shapeFactor = tire.PacejkaC or 1.6

	local chassisCFrame = chassis.CFrame
	local up = chassisCFrame.UpVector
	local forward = projectOnPlane(chassisCFrame.LookVector, up)
	local centerOfMass = chassis.AssemblyCenterOfMass
	local linearVelocity = chassis.AssemblyLinearVelocity
	local angularVelocity = chassis.AssemblyAngularVelocity

	for _, wheel in ipairs(basicParts:GetChildren()) do
		if wheel == chassis then continue end
		local wheelData = frameData[wheel]
		if not (wheelData and wheelData[WHEEL_TOUCHING]) then continue end
		local normalLoad = wheelData[WHEEL_LOAD] or 0
		if normalLoad <= 0 then continue end
		local offset = offsets[wheel]
		if not offset then continue end
		local wheelForce = chassis:FindFirstChild(wheel.Name, true)
		if not (wheelForce and wheelForce:IsA("VectorForce")) then continue end

		local steerAngle = 0
		if FRONT_WHEELS[wheel.Name] then
			steerAngle = (wheel.Name == "RDD") and (steerRight or 0) or (steerLeft or 0)
		end
		local wheelForward = projectOnPlane(CFrame.fromAxisAngle(up, steerAngle) * forward, up)
		local wheelSide = up:Cross(wheelForward).Unit

		local wheelPosition = (chassisCFrame * offset).Position
		local pointVelocity = linearVelocity + angularVelocity:Cross(wheelPosition - centerOfMass)
		local lateralSpeed = pointVelocity:Dot(wheelSide)
		local longitudinalSpeed = pointVelocity:Dot(wheelForward)

		local slipAngle = math.atan2(lateralSpeed, math.abs(longitudinalSpeed) + 0.5)
		local grip = math.sin(shapeFactor * math.atan(stiffnessFactor * slipAngle))
		local maxLateralForce = lateralFriction * normalLoad
		local lateralForce = clamp(-grip * maxLateralForce, -maxLateralForce, maxLateralForce)

		wheelForce.Force = wheelForce.Force + wheelSide * lateralForce
	end
end

local function getWheelRadius(values, wheel)
	local radius = (values.Tire and values.Tire.Radius) or (wheel and wheel.Size.Y * 0.5) or 2
	return math.max(radius, 0.05)
end

local function buildGearRatios(values)
	local transmission = values.Transmission or {}
	local gearCount = math.max(transmission.Gears or 6, 1)
	local ratios = {}
	if transmission.AutoRatios ~= false then
		local firstRatio = transmission.FirstGearRatio or 3.2
		local topRatio = transmission.TopGearRatio or 0.78
		if gearCount == 1 then
			ratios[1] = firstRatio
		else
			local step = (topRatio / firstRatio) ^ (1 / (gearCount - 1))
			for gear = 1, gearCount do
				ratios[gear] = firstRatio * step ^ (gear - 1)
			end
		end
	else
		ratios = transmission.Ratios or { 3.2 }
	end
	return ratios, transmission.FinalDrive or 3.9
end

local function createDrivetrainState(values, engine)
	local ratios, finalDrive = buildGearRatios(values)
	return {
		mode = "FWD",
		gear = 1,
		clutch = 1.0,
		rpm = engine.RpmMin or 800,
		ratios = ratios,
		finalDrive = finalDrive,
		reverseRatio = 2.9,
		airWheelSpeed = 0,

		filteredSpeedKmh = 0,
		upshiftTimer = 0,
		downshiftTimer = 0,
		topGearTimer = 0,
		gearDwellTimer = 0,

		isShifting = false,
		targetGear = nil,
		shiftClock = 0,
		shiftPhase = "idle",
		shiftDirection = "up",

		joltElapsed = 0,
		joltDuration = 0,
		joltG = 0,
	}
end

local function updateDrivetrain(car, basicParts, chassis, steerForward)
	local frameData = CarLib.CarRelativeChangsCFrams[car]
	local previousFrame = CarLib.CarLastFrameRedner[car]
	if not (frameData and previousFrame) then return end

	local driveAttachment = chassis:FindFirstChild("ATT_Drive")
	if not driveAttachment then return end
	local driveForce = driveAttachment:FindFirstChild("VF_Drive")
	if not (driveForce and driveForce:IsA("VectorForce")) then return end
	driveForce.RelativeTo = Enum.ActuatorRelativeTo.World

	local aeroAttachment = chassis:FindFirstChild("Aerodinamica")
	local aeroForce = aeroAttachment and aeroAttachment:FindFirstChildOfClass("VectorForce") or nil
	if aeroForce then aeroForce.ApplyAtCenterOfMass = false end

	local brakeAttachment = chassis:FindFirstChild("Freno")
	local brakeForce = brakeAttachment and brakeAttachment:FindFirstChildOfClass("VectorForce") or nil
	if brakeForce then
		brakeForce.ApplyAtCenterOfMass = false
		placeAtFrontAxle(basicParts, chassis, brakeAttachment)
	end

	local seat = car:FindFirstChildOfClass("VehicleSeat")
	local throttle = seat and clamp(seat.Throttle or 0, -1, 1) or 0
	local hasDriver = seat and seat.Occupant ~= nil
	if not hasDriver or math.abs(throttle) < 0.03 then throttle = 0 end

	local values = getCarValues(car)
	local engine = values.Engine or {}
	local transmission = values.Transmission or {}
	local tire = values.Tire or {}
	local brakes = values.Brakes or {}
	local longitudinalFriction = tire.MuLong or 1.0
	local rollingResistance = tire.RollingResist or 0.012
	local forwardSign = values.ForwardSign or 1
	local minRpm = engine.RpmMin or 800
	local maxRpm = engine.RpmMax or 7000

	local dt = getFrameDt(frameData, previousFrame)
	local up = chassis.CFrame.UpVector
	local forward = projectOnPlane(steerForward or chassis.CFrame.LookVector, up)
	local forwardSpeed = chassis.AssemblyLinearVelocity:Dot(forward)
	local mass = math.max(chassis.AssemblyMass, 1)
	local gravity = workspace.Gravity

	local state = drivetrainStates[car]
	if not state then
		state = createDrivetrainState(values, engine)
		drivetrainStates[car] = state
	end
	state.reverseRatio = math.abs(transmission.ReverseRatio or 2.9)

	local function getGearRatio(gear)
		if state.mode == "REV" then return state.reverseRatio end
		return state.ratios[gear] or state.ratios[#state.ratios]
	end

	local anyTouching, totalLoad = getContactStats(car, basicParts, chassis)
	if not anyTouching or totalLoad <= 1 then
		driveForce.Force = Vector3.zero
		if aeroForce then aeroForce.Force = Vector3.zero end
		if brakeForce then brakeForce.Force = Vector3.zero end

		local revUpRate = engine.FreeRevUpRate or 8000
		local revDownRate = engine.FreeRevDownRate or 4000
		local targetRpm = minRpm + math.abs(throttle) * (maxRpm - minRpm)

		local rpm = state.rpm or minRpm
		local revRate = (targetRpm > rpm) and revUpRate or revDownRate
		rpm = rpm + clamp(targetRpm - rpm, -revRate * dt, revRate * dt)
		if rpm > maxRpm then rpm = maxRpm - (rpm - maxRpm) * (engine.SoftLimiterK or 0.15) end
		if rpm < minRpm then rpm = minRpm end
		state.rpm = rpm

		local gearRatio = math.max(getGearRatio(state.gear), 0.05)
		state.airWheelSpeed = rpm / (gearRatio * state.finalDrive) * (2 * math.pi / 60)
		return
	end

	local dragArea = values.CdA or 0.65
	local airDensity = values.AirDensity or 1.2
	local aeroDecel = 0.5 * airDensity * dragArea / mass * forwardSpeed * math.abs(forwardSpeed)
	local rollingDecel = rollingResistance * gravity
	local dragForce
	if math.abs(forwardSpeed) > 0.05 then
		dragForce = (aeroDecel + rollingDecel) * mass * sign(forwardSpeed)
	else
		dragForce = rollingDecel * mass * sign(forwardSpeed)
	end
	local slopeForce = Vector3.new(0, gravity, 0):Dot(forward) * mass

	local studsToMeters = (transmission.StudsToMeters ~= nil) and transmission.StudsToMeters or 0.28
	local reverseEnableSpeed = brakes.ReverseEnableSpeed or 2.0
	local speedKmh = forwardSpeed * studsToMeters * 3.6
	local wheelRadius = getWheelRadius(values, basicParts:FindFirstChild("RDD"))

	local function getCoupledRpm(gearRatio)
		local wheelRpm = forwardSpeed / wheelRadius * 60 / (2 * math.pi)
		return math.max(minRpm, math.abs(wheelRpm) * gearRatio * state.finalDrive)
	end

	local function getDownforce()
		local speedMs = math.abs(forwardSpeed) * studsToMeters
		local extraG = math.clamp((transmission.AeroGPerV2 or 1.6e-4) * speedMs * speedMs, 0, transmission.AeroGMax or 1.5)
		return Vector3.new(0, -extraG * mass * gravity, 0)
	end

	local function updateFilteredSpeed()
		local filterTime = transmission.BandFilterTime or 0.20
		local alpha = 1 - math.exp(-dt / math.max(filterTime, 1e-6))
		state.filteredSpeedKmh += (speedKmh - state.filteredSpeedKmh) * math.clamp(alpha, 0, 1)
	end

	if not state.isShifting then
		if throttle < -0.03 then
			if forwardSpeed <= reverseEnableSpeed then state.mode = "REV" end
		elseif throttle > 0.03 then
			if forwardSpeed >= -reverseEnableSpeed then state.mode = "FWD" end
		end
	end

	local function requestShift(targetGear)
		if targetGear == state.gear or state.isShifting then return end
		state.isShifting = true
		state.targetGear = targetGear
		state.shiftClock = 0
		state.shiftPhase = "cut"
		state.shiftDirection = (targetGear < state.gear) and "down" or "up"
		if state.shiftDirection == "down" then
			state.joltDuration = math.max(0, transmission.DownshiftNoseJoltTime or 0)
			state.joltG = math.max(0, transmission.DownshiftNoseJoltG or 0)
		else
			state.joltDuration = math.max(0, transmission.ShiftJoltTime or 0)
			state.joltG = math.max(0, transmission.ShiftJoltG or 0)
		end
		state.joltElapsed = 0
	end

	local function checkDownshift(bands, currentGear)
		local lowerLimit = bands[currentGear][1] or 0
		local margin = (transmission.BandDownMarginKmh ~= nil) and transmission.BandDownMarginKmh
			or (transmission.BandMarginKmh or 5)
		if currentGear > 1 and state.filteredSpeedKmh < lowerLimit - margin then
			state.downshiftTimer += dt
			if state.downshiftTimer >= (transmission.BandHoldTimeDown or 0.25) then
				requestShift(currentGear - 1)
				state.gearDwellTimer = transmission.GearDwell or 0.35
				state.downshiftTimer = 0
			end
		else
			state.downshiftTimer = 0
		end
	end

	local isOpposingMotion = throttle * forwardSpeed < 0
	if isOpposingMotion and math.abs(forwardSpeed) > reverseEnableSpeed and not state.isShifting then
		local maxTraction = longitudinalFriction * totalLoad
		local brakingForce = clamp(mass * (brakes.BrakeAcc or 28.0), 0, maxTraction)
		driveForce.Force = forward * ((-sign(forwardSpeed) * brakingForce) - dragForce - slopeForce) * forwardSign

		local bands = transmission.SpeedBandsKmh
		if state.mode == "FWD" and bands and #bands > 0 then
			updateFilteredSpeed()
			checkDownshift(bands, math.clamp(state.gear, 1, #bands))
		end

		if brakeForce then
			local noseDiveG = (transmission.BrakeNoseMaxG or 0.6) * math.min(1, math.abs(throttle))
			brakeForce.Force = Vector3.new(0, -noseDiveG * mass * gravity, 0)
		end
		if aeroForce then aeroForce.Force = getDownforce() end

		state.clutch = math.min(1.0, state.clutch + 10 * dt)
		local rpmBlend = clamp((engine.Inertia or 0.2) * 12 * dt, 0, 1)
		state.rpm += (getCoupledRpm(getGearRatio(state.gear)) - state.rpm) * rpmBlend
		return
	end

	state.gearDwellTimer = math.max(0, state.gearDwellTimer - dt)
	state.topGearTimer = math.max(0, state.topGearTimer - dt)

	local gearRatio
	if state.mode == "REV" then
		gearRatio = state.reverseRatio
	else
		local bands = transmission.SpeedBandsKmh
		if bands and #bands > 0 and state.gearDwellTimer <= 0 and not state.isShifting then
			updateFilteredSpeed()
			local currentGear = math.clamp(state.gear, 1, #bands)
			local upperLimit = bands[currentGear][2] or math.huge
			local upMargin = (transmission.BandUpMarginKmh ~= nil) and transmission.BandUpMarginKmh
				or (transmission.BandMarginKmh or 5)

			if currentGear < #bands and state.filteredSpeedKmh > upperLimit + upMargin then
				state.upshiftTimer += dt
				if state.upshiftTimer >= (transmission.BandHoldTimeUp or 0.25) then
					local nextGear = currentGear + 1
					local nextRatio = state.ratios[nextGear] or state.ratios[#state.ratios]
					if getCoupledRpm(nextRatio) > minRpm * 1.1 then
						requestShift(nextGear)
						local gearDwell = transmission.GearDwell or 0.35
						if nextGear == #bands then
							state.gearDwellTimer = transmission.GearDwellTop or gearDwell * 1.5
							state.topGearTimer = transmission.TopGearStick or 0.8
						else
							state.gearDwellTimer = gearDwell
						end
					end
					state.upshiftTimer = 0
				end
			else
				state.upshiftTimer = 0
			end

			checkDownshift(bands, currentGear)
		end
		gearRatio = state.ratios[state.gear] or state.ratios[#state.ratios]
	end

	local shiftLatency = transmission.ShiftLatency or 0.55
	if state.isShifting then
		state.shiftClock += dt

		local shiftDrag = -mass * (transmission.ShiftDragAcc or 3.4) * sign(forwardSpeed)
		driveForce.Force = forward * (shiftDrag - dragForce - slopeForce) * forwardSign

		local targetRpm = getCoupledRpm(getGearRatio(state.targetGear or state.gear))
		state.rpm = lerp(state.rpm, targetRpm, (transmission.ShiftRpmBlendK or 16.0) * dt)

		if state.shiftClock >= shiftLatency * 0.33 and state.shiftPhase == "cut" then
			state.gear = state.targetGear or state.gear
			state.shiftPhase = "swap"
		end

		if brakeForce and state.joltDuration > 0 and state.joltElapsed < state.joltDuration and state.joltG > 0 then
			state.joltElapsed = math.min(state.joltElapsed + dt, state.joltDuration)
			local joltForce = state.joltG * mass * gravity * trianglePulse(state.joltElapsed, state.joltDuration)
			if joltForce > 0 then brakeForce.Force = Vector3.new(0, -joltForce, 0) end
		elseif brakeForce then
			brakeForce.Force = Vector3.zero
		end

		if aeroForce then aeroForce.Force = getDownforce() end

		if state.shiftClock >= shiftLatency then
			state.isShifting = false
			state.targetGear = nil
			state.shiftClock = 0
			state.shiftPhase = "idle"
			state.shiftDirection = "up"
			state.joltElapsed = 0
			state.joltDuration = 0
			state.joltG = 0
		end
		return
	end

	local throttleDeadzone = transmission.HillHoldThrottleDead or 0.05
	local holdSpeed = transmission.HillHoldSpeed or 0.60
	local stopSpeed = transmission.HillHoldStopSpeed or 0.12
	if math.abs(throttle) <= throttleDeadzone then
		throttle = 0
		if math.abs(forwardSpeed) <= stopSpeed then
			driveForce.Force = Vector3.zero
			chassis.AssemblyLinearVelocity = chassis.AssemblyLinearVelocity - forward * forwardSpeed
			if brakeForce then brakeForce.Force = Vector3.zero end
			if aeroForce then aeroForce.Force = Vector3.zero end
			return
		elseif math.abs(forwardSpeed) < holdSpeed then
			local resistance = slopeForce
			if math.abs(forwardSpeed) > 0.05 then resistance += dragForce end
			local holdForce = -sign(forwardSpeed) * math.min(math.abs(resistance), mass * (transmission.HillHoldMaxAcc or 20.0))
			driveForce.Force = forward * holdForce * forwardSign
			if brakeForce then brakeForce.Force = Vector3.zero end
			if aeroForce then aeroForce.Force = getDownforce() end
			return
		end
	end

	local maxTorque = engine.MaxTorqueNm or engine.TorqueMaxNm or 400
	local peakTorqueRpm = engine.TorquePeakRpm or math.floor(maxRpm * 0.6)
	local torqueSpread = math.max(engine.TorqueSigmaRpm or 1500, 200)

	state.clutch += (1.0 - state.clutch) * clamp(10 * dt, 0, 1)
	local rpmBlend = clamp((engine.Inertia or 0.3) * 10 * dt, 0, 1)
	state.rpm += (getCoupledRpm(gearRatio) - state.rpm) * rpmBlend
	local rpm = state.rpm

	local engineTorque = 0
	if rpm >= minRpm and rpm <= maxRpm then
		local exponent = -((rpm - peakTorqueRpm) ^ 2) / (2 * torqueSpread * torqueSpread)
		engineTorque = math.max(engine.TorqueMinNm or 100, maxTorque * math.exp(exponent))
	end

	local isReverse = state.mode == "REV"
	local driveDirection = isReverse and -1 or 1
	local throttleAmount = isReverse and math.max(0, -throttle) or math.max(0, throttle)
	engineTorque *= throttleAmount

	local wheelTorque = engineTorque * gearRatio * state.finalDrive * clamp(state.clutch, 0, 1)
	local maxTraction = longitudinalFriction * totalLoad
	local tractionForce = clamp(wheelTorque / wheelRadius, -maxTraction, maxTraction)

	local reverseMaxKmh = transmission.ReverseMaxKmh or 40
	if isReverse and math.abs(speedKmh) > math.max(0, reverseMaxKmh) then
		local overspeed = math.min(math.abs(speedKmh) - reverseMaxKmh, 10)
		local holdDecel = clamp(2.0 + 0.8 * overspeed, 0, 8)
		driveForce.Force = forward * (-sign(forwardSpeed) * mass * holdDecel - dragForce - slopeForce) * forwardSign
	else
		driveForce.Force = forward * (driveDirection * tractionForce - dragForce - slopeForce) * forwardSign
	end

	if aeroForce then aeroForce.Force = getDownforce() end
	if brakeForce then brakeForce.Force = Vector3.zero end
end

local function updateEngineSound(car, chassis, values)
	local soundConfig = values.EngineSound or {}
	local sound = chassis:FindFirstChild(soundConfig.SoundName or "Car Engine")
	if not (sound and sound:IsA("Sound")) then return end
	local drivetrain = drivetrainStates[car]
	if not drivetrain then return end

	local minRpm = (values.Engine and values.Engine.RpmMin) or 800
	local maxRpm = (values.Engine and values.Engine.RpmMax) or 7000
	local referenceRpm = soundConfig.RpmRef or 2000
	local basePitch = soundConfig.BasePlaybackSpeed or 1.0
	local pitchPer1000Rpm = (soundConfig.PitchSlopePer1000 ~= nil) and soundConfig.PitchSlopePer1000 or 0.35
	local minPitch = soundConfig.MinPlaybackSpeed or 0.8
	local maxPitch = soundConfig.MaxPlaybackSpeed or 2.4
	if maxPitch <= minPitch then maxPitch = minPitch + 0.01 end
	local riseTime = math.max(soundConfig.SmoothTimeUp or 0.10, MIN_DT)
	local fallTime = math.max(soundConfig.SmoothTimeDown or 0.18, MIN_DT)
	local shiftPitchDip = (soundConfig.ShiftPitchDip ~= nil) and soundConfig.ShiftPitchDip or 0.10

	local seat = car:FindFirstChildOfClass("VehicleSeat")
	local throttle = math.clamp(math.abs(seat and seat.Throttle or 0), 0, 1)

	local rpm = math.clamp(drivetrain.rpm or minRpm, minRpm, maxRpm)
	local rpmFraction = (rpm - minRpm) / math.max(maxRpm - minRpm, 1)

	local targetPitch = math.clamp(basePitch + pitchPer1000Rpm * ((rpm - referenceRpm) / 1000), minPitch, maxPitch)
	if drivetrain.isShifting then targetPitch *= (1.0 - shiftPitchDip) end

	local targetVolume = math.clamp(
		(soundConfig.BaseVolume or 0.35)
			+ (soundConfig.VolByThrottle or 0.55) * throttle
			+ (soundConfig.VolByRpm or 0.25) * rpmFraction,
		soundConfig.MinVolume or 0.05,
		soundConfig.MaxVolume or 1.0
	)

	local soundState = soundStates[car]
	if not soundState then
		soundState = { pitch = sound.PlaybackSpeed, volume = sound.Volume }
		soundStates[car] = soundState
	end

	local dt = getFrameDt(CarLib.CarRelativeChangsCFrams[car], CarLib.CarLastFrameRedner[car])
	local function smoothTowards(current, target, smoothTime)
		local alpha = 1 - math.exp(-dt / math.max(smoothTime, 1e-6))
		return current + (target - current) * math.clamp(alpha, 0, 1)
	end

	soundState.pitch = smoothTowards(soundState.pitch, targetPitch, (targetPitch > soundState.pitch) and riseTime or fallTime)
	soundState.volume = smoothTowards(soundState.volume, targetVolume, (targetVolume > soundState.volume) and riseTime or fallTime)

	sound.PlaybackSpeed = soundState.pitch
	sound.Volume = soundState.volume
	if not sound.IsPlaying then
		sound.Looped = true
		sound:Play()
	end
end

local function clientStep(car)
	if not car then return end
	local basicParts = car:FindFirstChild("BasicParts")
	if not basicParts then return end
	local chassis = basicParts:FindFirstChild("Chasis")
	if not chassis then return end
	local values = getCarValues(car)

	castSuspensionRays(car, basicParts, chassis, values)
	applySuspensionForces(car, basicParts, chassis, values)

	local steerForward, steerRight, steerLeft = updateSteering(car, basicParts, chassis)
	applyLateralTireForces(car, basicParts, chassis, steerRight, steerLeft)

	updateWheelSpin(car, basicParts, chassis, values, steerForward)
	applyWheelTransforms(car, basicParts, chassis, steerRight, steerLeft)

	updateDrivetrain(car, basicParts, chassis, steerForward)
	updateEngineSound(car, chassis, values)
end

function VehicleModule.StartClientControl(car)
	if clientConnections[car] then return end
	local basicParts = car:WaitForChild("BasicParts")
	local chassis = basicParts:WaitForChild("Chasis")
	storeRelativeOffsets(car, basicParts:GetChildren(), chassis)
	clientConnections[car] = RunService.Heartbeat:Connect(function()
		clientStep(car)
	end)
end

function VehicleModule.StopClientControl(car)
	local connection = clientConnections[car]
	if connection then connection:Disconnect() end
	clientConnections[car] = nil
end

return VehicleModule
