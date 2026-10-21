--//Services//--
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--//Instances//--
local RondaStorage = ServerStorage:WaitForChild("Ronda")
local FuncionesDeRondaStorage = RondaStorage:WaitForChild("FuncionesDeRonda")
local FuncionesDeValoresStorage = FuncionesDeRondaStorage:WaitForChild("FuncioesDeValores")
local ValuesRound = require(FuncionesDeValoresStorage)
local ValoresReplicated = ReplicatedStorage:WaitForChild("Valores")
--//ValuesReplicated//--
local ValoresDeCamara = ValoresReplicated:WaitForChild("ValoresDeCamara")
local ListaDeJugadores = ValoresDeCamara:WaitForChild("JugadoresEnPartida")
local ValuesDeStoreRep = ValoresReplicated:WaitForChild("ValoresDeStore")
local ArmasEnRondaDeJugadores = ValuesDeStoreRep:WaitForChild("ArmasDeJugadores")



Players.PlayerAdded:Connect(function(Player)
	local ValoresDeRonda = Instance.new("Folder",Player)ValoresDeRonda.Name = "ValoresDeRonda"
	local ToolValues = Instance.new("Folder",ValoresDeRonda)ToolValues.Name = "ToolValues"
	ValuesRound.EnPartida(ValoresDeRonda)ValuesRound.Tools(ToolValues)local PartidaValues = Instance.new("Folder",Player)
	PartidaValues.Name = "ValoresDePartida"ValuesRound.Contadores(PartidaValues)
	local ValoresDelJugador = Player:WaitForChild("ValoresDeRonda")
	local EnPartida = ValoresDelJugador:FindFirstChild("EnPartida")
	local ENLobby = ValoresDelJugador:FindFirstChild("EnLobby")
	Player.CharacterAdded:Connect(function(Character)
		local Humanoid = Character:WaitForChild("Humanoid")
		Humanoid.Died:Connect(function()
			if ValoresDelJugador then 
				 if EnPartida then
					EnPartida.Value = false
					delay(Players.RespawnTime+.2,function()if ENLobby then ENLobby.Value=true end end)
				end
			end
		end)
		Character.ChildAdded:Connect(function(A)
			if A.ClassName == "Accessory" then
				table.foreach(A:GetDescendants(),function(_,A1)
					if A1.Name == "Handle" then
						A1.CanQuery = false	A1.CanCollide = false A1.CanTouch = false end end)end
		end)
		table.foreach(Character:GetDescendants(),function(_,A2)
			if A2.ClassName == "Accessory" then
				table.foreach(A2:GetDescendants(),function(_,A3)
					if A3.Name == "Handle" then
						A3.CanQuery = false A3.CanCollide = false A3.CanTouch = false end end)end
		end)
	end)
	EnPartida.Changed:Connect(function(CambiodEpd)
		if CambiodEpd == true then
			local Character = Player.Character or Player.CharacterAdded:Wait()
			local Humanoid = Character:FindFirstChildOfClass("Humanoid")
			if Humanoid then
				local Value = Instance.new("ObjectValue",ListaDeJugadores)
				Value.Name = Player.Name
				Value.Value = Humanoid
			end
		else
			local Value = ListaDeJugadores:FindFirstChild(Player.Name)
			if Value then
				Value:Destroy()
			end
		end
	end)
end)



Players.PlayerRemoving:Connect(function(Player)
	local ValueDeJugador = ListaDeJugadores:FindFirstChild(Player.Name)
	if ValueDeJugador then
		ValueDeJugador:Destroy()
	end
	table.foreach(ArmasEnRondaDeJugadores:GetDescendants(),function(_,Arma)
		if Arma.Name == Player.Name then
			Arma:Destroy()
		end
	end)
end)
