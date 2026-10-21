local CollectionServices = game:GetService("CollectionService")


local killParts = CollectionServices:GetTagged("Killpart")



for _,killPart in pairs(killParts) do
	killPart.Touched:Connect(function(Part)
		local Character = Part.Parent
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		if Humanoid then
			Humanoid.Health = 0
		end
	end)
end
