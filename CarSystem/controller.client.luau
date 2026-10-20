local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local CarSystemFolder = ReplicatedStorage:WaitForChild("CarSystem")
local VehicleModule = require(CarSystemFolder:WaitForChild("VehicleModule"))
local CarControl = ReplicatedStorage:WaitForChild("CarControl")

local localPlayer = Players.LocalPlayer
local currentCar = nil
local startToken = 0

local function stopCurrent()
	startToken += 1
	if currentCar then
		VehicleModule.StopClientControl(currentCar)
		currentCar = nil
	end
end

local function waitForOurOccupant(seat, timeout)
	local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
	if not (seat and humanoid) then return false end
	if seat.Occupant == humanoid then return true end
	local startTime = os.clock()
	while os.clock() - startTime < timeout do
		if seat.Occupant == humanoid then return true end
		if seat.Occupant ~= nil and seat.Occupant ~= humanoid then return false end
		task.wait()
	end
	return seat.Occupant == humanoid
end

CarControl.OnClientEvent:Connect(function(action, car)
	if action == "start" then
		if not car then return end
		local seat = car:FindFirstChildOfClass("VehicleSeat")
		if not seat then return end
		stopCurrent()
		startToken += 1
		local myToken = startToken
		task.spawn(function()
			if waitForOurOccupant(seat, 3) and myToken == startToken then
				currentCar = car
				VehicleModule.StartClientControl(car)
			end
		end)
	elseif action == "stop" then
		if currentCar == car or car == nil then
			stopCurrent()
		else
			startToken += 1
		end
	end
end)

local function monitorSeat()
	local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	humanoid.Seated:Connect(function(active)
		if not active then stopCurrent() end
	end)
end
monitorSeat()
localPlayer.CharacterAdded:Connect(monitorSeat)
