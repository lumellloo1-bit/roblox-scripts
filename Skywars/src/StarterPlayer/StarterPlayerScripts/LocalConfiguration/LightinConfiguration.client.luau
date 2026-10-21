local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

--//Isntaces//--
local RondasFunciones = workspace:WaitForChild("RondasFunciones")
local IslaLocal = RondasFunciones:WaitForChild("IslaLocal")
local Player = Players.LocalPlayer
local ValoresDeRonda = Player:WaitForChild("ValoresDeRonda")
local EnPardia = ValoresDeRonda:WaitForChild("EnPartida")
local StorageReplicated = ReplicatedStorage:WaitForChild("Storage")
local LothrinReplictade = StorageReplicated:WaitForChild("Lightin")
local moduleLith = require(LothrinReplictade:WaitForChild("ModuleScript"))
local EnLobby = ValoresDeRonda:WaitForChild("EnLobby")
--//Values//--
local ChangeTime = 10
local InformacionCambioTween = TweenInfo.new(ChangeTime,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false,0)

EnPardia.Changed:Connect(function(Cambio)
	if Cambio == true then
		local Mapa 
		table.foreach(IslaLocal:GetChildren(),function(_,Isla)
			Mapa = Isla.Name
		end)
		table.foreach(Lighting:GetChildren(),function(_,Child)
			if Child.Name ~= "Sky" then
				table.foreach(moduleLith[Mapa][Child.Name],function(Propety,Value)
					local FinalDeTween = {}
					FinalDeTween[Propety] = Value
					local track = TweenService:Create(Child,
						InformacionCambioTween,FinalDeTween)
					track:Play()
				end)
			else
				table.foreach(moduleLith[Mapa]["Sky"],function(Propety,Value)
					Child[Propety] = Value
				end)

			end
			
		end)

		table.foreach(moduleLith[Mapa]["Lighting"],function(Propety,Value)
			local FinalDeTween = {}
			FinalDeTween[Propety] = Value

			local track = TweenService:Create(Lighting,
				InformacionCambioTween,
				FinalDeTween
			)
			track:Play()
		end)
	end
end)

EnLobby.Changed:Connect(function(cambio)
	if cambio == true then
		table.foreach(Lighting:GetChildren(),function(_,Child)
			if Child.Name ~= "Sky" then
				table.foreach(moduleLith["Lobby"][Child.Name],function(Propety,Value)
					local FinalDeTween = {}
					FinalDeTween[Propety] = Value
					local track = TweenService:Create(Child,
						InformacionCambioTween,FinalDeTween)
					track:Play()
				end)
			else
				table.foreach(moduleLith["Lobby"]["Sky"],function(Propety,Value)
					Child[Propety] = Value
				end)

			end

		end)

		table.foreach(moduleLith["Lobby"]["Lighting"],function(Propety,Value)
			local FinalDeTween = {}
			FinalDeTween[Propety] = Value

			local track = TweenService:Create(Lighting,
				InformacionCambioTween,
				FinalDeTween
			)
			track:Play()
		end)
	end
end)
