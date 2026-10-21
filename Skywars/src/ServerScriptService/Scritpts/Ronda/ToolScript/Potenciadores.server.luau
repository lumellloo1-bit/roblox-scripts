local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local remoteEvent = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RemotesPotenciadores"):WaitForChild("RemoteEscudo")
local ValoresDeEscudo = ServerStorage:WaitForChild("Ronda"):WaitForChild("ValoresDeRonda"):WaitForChild("ValoresDeArmas"):WaitForChild("ValoresDeEscudo")
local ReloadTime = ValoresDeEscudo:WaitForChild("TiempoDeReload")
local DuracionTime = ValoresDeEscudo:WaitForChild("TiempoDeEscudo")
local remoteEventQuitar = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RemotesPotenciadores"):WaitForChild("RemoteQuitarEscudo")
local ListaDeJugadores = ReplicatedStorage:WaitForChild("Valores"):WaitForChild("ValoresPotenciadores"):WaitForChild("ValoresEscudo"):WaitForChild("Jugadores")

remoteEvent.OnServerEvent:Connect(function(Player)
	local Character = Player.Character
	if not Character then return end
	local Humanod = Character:FindFirstChildOfClass("Humanoid")
	if not Humanod then return end
	if Humanod.Health <= 0 then return end
	
	local Tool = Player.Character:FindFirstChild("Shield")
	if not Tool then
		Tool = Player.Backpack:FindFirstChild("Shield")
	end
	local Persona = ListaDeJugadores:FindFirstChild(Player.Name)
	local Reloadingss = ListaDeJugadores:FindFirstChild("Reloading"..Player.Name)
	if not Persona then
		if not Reloadingss then
			if Tool then
				local Handle = Tool:FindFirstChild("Handle")
				Handle.CanQuery = true
			end
			local Reloading1 = Instance.new("BoolValue")
			Reloading1.Name = Player.Name
			Reloading1.Parent =ListaDeJugadores
			wait(DuracionTime.Value)
			Reloading1:Destroy()
			local Handle = Tool:FindFirstChild("Handle")
			if Handle then
				Handle.CanQuery = false
			end
			local Reloading = Instance.new("BoolValue")
			Reloading.Name = "Reloading"..Player.Name
			Reloading.Parent =ListaDeJugadores
			wait(ReloadTime.Value)
			Reloading:Destroy()
		end
	end
end)


remoteEventQuitar.OnServerEvent:Connect(function(Player)
	local Tool = Player.Character:FindFirstChild("Shield")
	if not Tool then
		Tool = Player.Backpack:FindFirstChild("Shield")
	end
	if Tool then
		local Handle = Tool:FindFirstChild("Handle")
		Handle.CanQuery = false
	end
	local Persona = ListaDeJugadores:FindFirstChild(Player.Name)
	local Reloading = ListaDeJugadores:FindFirstChild("Reloading"..Player.Name)
	if  Persona then
		Persona:Destroy()
	end
end)
