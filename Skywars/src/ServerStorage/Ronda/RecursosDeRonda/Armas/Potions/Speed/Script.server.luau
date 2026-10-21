script.Parent.Equipped:Wait()
local Tomada = false
local Character = script.Parent.Parent
local Humanoid = Character:WaitForChild("Humanoid")
script.Parent.Activated:Connect(function()
	if Tomada == false then
		Tomada = true
		Humanoid.WalkSpeed = 24
	end
end)
