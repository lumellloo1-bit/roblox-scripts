local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")

local RondaStorage = ServerStorage:WaitForChild("Ronda")
local Valores = RondaStorage:WaitForChild("ValoresDeRonda")
local TeletransportarTorneo = Valores:WaitForChild("TeletransportarTorneo")
local CustomScreen = script:WaitForChild("ScreenGui")
local Connexion 

TeletransportarTorneo.Changed:Connect(function()
	local ok,errorr = pcall(function()
		if TeletransportarTorneo.Value == true then
			table.foreach(Players:GetDescendants(),function(_,Player)
				TeleportService:Teleport(11967443379,Player,nil,CustomScreen)

			end)
			Connexion = Players.PlayerAdded:Connect(function(Player)
				TeleportService:Teleport(11967443379,Player,nil,CustomScreen)
			end)
		else
			Connexion:Disconnect()
		end
	end)

	
end)
