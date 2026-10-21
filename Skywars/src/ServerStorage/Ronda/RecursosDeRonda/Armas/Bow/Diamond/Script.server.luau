local ServerStorage = game:GetService("ServerStorage")


script.Parent.Equipped:Wait()
local Character = script.Parent.Parent
local Humanoid = Character:FindFirstChild("Humanoid")
local Player = game.Players:GetPlayerFromCharacter(Character)
local Value = Player:WaitForChild("ValoresDeRonda"):WaitForChild("ToolValues"):WaitForChild("Bow")
local Accesorios = ServerStorage:WaitForChild("Ronda"):WaitForChild("RecursosDeRonda"):WaitForChild("StorageArmas"):WaitForChild("StorageArco"):WaitForChild("Accesorios")
local Valor = Value.Value
local Accesorio = Accesorios:WaitForChild(Valor)
if Humanoid then
	script.Parent.Equipped:Connect(function()
		local Cloancion = Accesorio:Clone()
		Cloancion.Parent = Character
	end)
	script.Parent.Unequipped:Connect(function()
		local Accesorio = Character:FindFirstChild(Valor)
		if Accesorio then
			Accesorio:Destroy()
		end
	end)
end
