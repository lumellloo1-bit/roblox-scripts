local Humanoid = script.Parent
local Animation = Humanoid:WaitForChild("Animation")
local Track = Humanoid:LoadAnimation(Animation)

Track:Play()
