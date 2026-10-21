--//Services//--
local uis = game:GetService("UserInputService")
local ContextAction = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local Tween = game:GetService("TweenService")

--//Variables//--

local Button = script.Parent:WaitForChild("TextButton")
local UIStro = Button:WaitForChild("UIStroke")
local Player = Players.LocalPlayer
local ValoresDeRonda = Player:WaitForChild("ValoresDeRonda")
local EnPartida = ValoresDeRonda:WaitForChild("EnPartida")


local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

Player.CharacterAdded:Connect(function(CharacterAdded)
	Character = CharacterAdded
	Humanoid = CharacterAdded:WaitForChild("Humanoid")
end)

local Camera = workspace.CurrentCamera

local DefaultWalkSpeed = 16
local GoalWalkSpeed = DefaultWalkSpeed * 2
local DefaultFov = 70
local GoalFov = 75

local IsRunning = false
local CanRun = true
local Info = TweenInfo.new(.5, Enum.EasingStyle.Linear)
local MainCamTween = Tween:Create(Camera, Info, {FieldOfView = GoalFov})
local AltCamTween = Tween:Create(Camera, Info, {FieldOfView = DefaultFov})

--//Coding//--
ismobile = uis.KeyboardEnabled
if ismobile then
	script.Parent.Enabled = false
else
	script.Parent.Enabled = true

end


local function Run(Active)
	IsRunning = Active

	if Active then 
		MainCamTween:Play()
		UIStro.Thickness = 8
		Humanoid.WalkSpeed = GoalWalkSpeed

	else
		UIStro.Thickness = 0

		AltCamTween:Play()
		Humanoid.WalkSpeed = DefaultWalkSpeed
	end
end

ContextAction:BindAction("Run", function(ActionName, InputState, InputObject) 
	if CanRun == true then
		if not (ActionName == "Run") then return end;

		if InputState == Enum.UserInputState.Begin then 
			Run(true)
		else
			Run(false)
		end
	end

end, false, Enum.KeyCode.LeftControl)

Button.MouseButton1Down:Connect(function()
	Run(not IsRunning)
end)

EnPartida.Changed:Connect(function(Cmabio)
	if Cmabio == true  then	
		CanRun = false
		Button.Visible = false
		UIStro.Thickness = 0
		AltCamTween:Play()
		Humanoid.WalkSpeed = DefaultWalkSpeed
	else 
		CanRun = true 
		delay(Players.RespawnTime,function()
			Button.Visible = true

		end)
		
	end
end)
