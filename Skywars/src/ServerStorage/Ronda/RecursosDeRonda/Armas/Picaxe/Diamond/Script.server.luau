local Tool = script.Parent
local HoldAnimation = script:WaitForChild("Statmen")
local ActionAnimation = script:WaitForChild("Hit")
Tool.Equipped:Wait()

local Character = script:FindFirstAncestorOfClass("Model")
local Humanoid = Character:WaitForChild("Humanoid")
local Animator = Humanoid:WaitForChild("Animator")

local HoldTrack = Animator:LoadAnimation(HoldAnimation)
local ActionTrack = Animator:LoadAnimation(ActionAnimation)

local Debounce = false
local Cooldown = ActionTrack.Length

HoldTrack:Play()
Tool.Equipped:Connect(function()
	HoldTrack:Play()
end)

Tool.Unequipped:Connect(function()
	HoldTrack:Stop()
end)

Tool.Activated:Connect(function()
	if Debounce then return end;
	Debounce = true
	ActionTrack:Play(0,0.8,1.8)
	ActionTrack.Stopped:Wait()
	Debounce = false
end)
