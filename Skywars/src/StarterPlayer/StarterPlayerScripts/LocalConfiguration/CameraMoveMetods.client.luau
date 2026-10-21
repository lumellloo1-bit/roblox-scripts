local HorizontalRotation = 45
local VerticalRotation = 15
local MaxVertical = 80

local HorizontalKeys = {
	[Enum.KeyCode.Comma] = 1,
	[Enum.KeyCode.Period] = -1
}

local VerticalKeys = {
	[Enum.KeyCode.PageUp] = -1,
	[Enum.KeyCode.PageDown] = 1
}

local function GetPosition(Subject)
	local Success, Pos = pcall(
		function() 
			return Subject.Position 
		end
	)
	if not Success then
		Success, Pos = pcall(
			function()
				return Subject.Parent:FindFirstChild("Head").Position
			end
		)
	end
	if Success then
		return Pos
	end
end

local RoomForError = 0.1

game:GetService("UserInputService").InputBegan:Connect(function(InputObject, GPE)
	local SubjectPos = GetPosition(workspace.CurrentCamera.CameraSubject)
	if SubjectPos and not GPE then
		local Direction = HorizontalKeys[InputObject.KeyCode] or VerticalKeys[InputObject.KeyCode]
		if Direction then
			local CameraCFrame = workspace.CurrentCamera.CFrame
			local ZoomVector = SubjectPos - CameraCFrame.Position

			if HorizontalKeys[InputObject.KeyCode] then
				local SamplePositions = {}
				for i = 1, 8 do
					local Rotation_CF = CFrame.new(SubjectPos) * CFrame.Angles(0, math.rad(HorizontalRotation * i), 0)
					Rotation_CF += (-Rotation_CF.LookVector * Vector3.new(ZoomVector.X, 0, ZoomVector.Z).Magnitude) + Vector3.new(0, -ZoomVector.Y, 0)
					table.insert(SamplePositions, Rotation_CF.Position)
				end

				local TestingCFrame = (CameraCFrame - CameraCFrame.Position) + SubjectPos
				TestingCFrame = (CFrame.Angles(0, math.rad(((HorizontalRotation / 2) + RoomForError) * Direction), 0) * (TestingCFrame - TestingCFrame.Position)) + TestingCFrame.Position
				-- ^^ Tyzone's idea
				-- RoomForError is used here so that if you spam , or . then it doesn't get stuck on one rotation
				TestingCFrame += -TestingCFrame.LookVector * ZoomVector.Magnitude

				local Closest = SamplePositions[1]
				for _,Position in pairs(SamplePositions) do
					if (TestingCFrame.Position - Closest).Magnitude > (TestingCFrame.Position - Position).Magnitude then
						Closest = Position
					end
				end
				CameraCFrame = CFrame.lookAt(Closest, SubjectPos)
			elseif VerticalKeys[InputObject.KeyCode] then
				CameraCFrame -= CameraCFrame.Position
				CameraCFrame += SubjectPos

				local OldX, OldY, OldZ = CameraCFrame:ToOrientation()
				CameraCFrame *= CFrame.Angles(math.rad(VerticalRotation * Direction), 0, 0)
				CameraCFrame += -CameraCFrame.LookVector * ZoomVector.Magnitude

				local NewX, NewY, NewZ = CameraCFrame:ToOrientation() -- We aren't converting old and new ToOrientation parameters to degrees, but it works anyway
				if math.abs(math.abs(NewY) - math.abs(OldY)) > RoomForError or math.abs(NewY - OldY) > RoomForError then -- Only occurs if math.abs(OldX) > 75 (in degrees)
					-- Latter evaluation ("or math.abs(NewY - OldY) etc...") solves for edge case of flipping from -90 to 90 and vice versa
					NewX, NewY, NewZ = MaxVertical * Direction, OldY, OldZ
				end
				CameraCFrame = CFrame.fromOrientation(math.rad(math.clamp(math.deg(NewX), -MaxVertical, MaxVertical)), NewY, NewZ)
			end

			workspace.CurrentCamera.CFrame = CameraCFrame
		end
	end
end
)
