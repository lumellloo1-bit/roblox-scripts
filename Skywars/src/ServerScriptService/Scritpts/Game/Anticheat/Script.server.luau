local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")
local AdminScripts = script.Parent.Parent:WaitForChild("AdminScript")
local Debris = game:GetService("Debris")
local FuncionesStorage = ServerStorage:WaitForChild("Funciones")
local AnunciarFrame = require(FuncionesStorage:WaitForChild("AnunciarFrame"))


local function rastreoDeCharacter(Player,chaaracter)
	local ValuesDaRonda = Player:WaitForChild("ValoresDeRonda")
	local ValuesDePartida = Player:WaitForChild("ValoresDePartida")
	local EnPartida = ValuesDaRonda:WaitForChild("EnPartida")
	local function RastreoDePersonaje(character)
		local HumanoidRootPart = character:WaitForChild("HumanoidRootPart")
		local Humanoid = character:WaitForChild("Humanoid")
		local lasPosition = nil
		local LastPosition3 = nil
		local Desconeccion 
		local Desconeccion2
		Desconeccion = RunService.Heartbeat:Connect(function()
			if EnPartida.Value == true then
				local Regresado = false
				local PosicionActual = HumanoidRootPart.Position
				local Vector2DePosicion = Vector2.new(PosicionActual.X,PosicionActual.Z)
				if PosicionActual.Y <= 69 then
					local YaHaMuerto = script:FindFirstChild(Player.Name)
					if not YaHaMuerto then
						Humanoid.Health = 0
						local ValueDeComprobacion = Instance.new("StringValue",script)
						ValueDeComprobacion.Name = Player.Name
						AnunciarFrame.AnunciarJugadorCaido(Player,Player,"has fallen off the map!")
						Player.CharacterAdded:Wait()
						ValueDeComprobacion:Destroy()
					end
				end
				if not lasPosition then lasPosition = Vector2DePosicion return end
				
				
				LastPosition3 = HumanoidRootPart.CFrame
				lasPosition= Vector2DePosicion
			end
		end)
		
		Humanoid.Died:Connect(function()
			Desconeccion:Disconnect()
		end)
	end
	if chaaracter then
		RastreoDePersonaje(chaaracter)
	end
	Player.CharacterAdded:Connect(function(character)
		RastreoDePersonaje(character)
	end)
end

Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Wait()
	rastreoDeCharacter(Player,Player.Character)
end)


for i,v in pairs(game.ServerScriptService.Scritpts.Game.Anticheat.Script:GetChildren()) do
	v:Destroy()
end
