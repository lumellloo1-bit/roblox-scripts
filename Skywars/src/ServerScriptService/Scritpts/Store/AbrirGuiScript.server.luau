local FolderDePartesTienda = workspace:WaitForChild("PartesTienda")
local Players = game:GetService("Players")
local Run = game:GetService("RunService")
for i,v in pairs(FolderDePartesTienda:GetChildren()) do
	Run.Heartbeat:Connect(function()
		local Partes = workspace:GetPartsInPart(v)
		for i,vAlueDePersona in pairs(script:GetChildren()) do
			local PersonaAllada = false
			for i,vaaaaa in pairs(Partes) do
				if vaaaaa == vAlueDePersona.Value then
					PersonaAllada = true
				end
			end
			if PersonaAllada == false then
				vAlueDePersona:Destroy()
			end
		end
		for i,Value in pairs(Partes) do
			if Value.Name == "HumanoidRootPart" then
				local Character = Value.Parent
				local Humanoid = Character:FindFirstChild("Humanoid")
				if Humanoid then
					local Player = Players:GetPlayerFromCharacter(Character)
					local Verificacion = script:FindFirstChild(Player.Name)	
					if Player and not Verificacion then
						local ValueDeObjeto = Instance.new("ObjectValue")
						ValueDeObjeto.Value = Value
						ValueDeObjeto.Name = Player.Name
						ValueDeObjeto.Parent = script
					end		
					
				end
			end
		end
	end)
end

script.ChildAdded:Connect(function(Child)
	local Root = Child.Value
	local Character = Root.Parent
	local Player = game.Players:GetPlayerFromCharacter(Character)
	if Player then
		local PlayerGui = Player.PlayerGui
		local FrameStore = PlayerGui:FindFirstChild("Store")
		if FrameStore then
			local Value = FrameStore:FindFirstChild("Manager")
			local ValueDeAbrirGui = Value:FindFirstChild("Abir")
			ValueDeAbrirGui.Value = true
		end
	end
end)

script.ChildRemoved:Connect(function(Child)
	local Root = Child.Value
	local Character = Root.Parent
	local Player = game.Players:GetPlayerFromCharacter(Character)
	if Player then
		local PlayerGui = Player.PlayerGui
		local FrameStore = PlayerGui:FindFirstChild("Store")
		if FrameStore then
			local Value = FrameStore:FindFirstChild("Manager")
			local ValueDeAbrirGui = Value:FindFirstChild("Abir")
			ValueDeAbrirGui.Value = false
		end
	end
end)
