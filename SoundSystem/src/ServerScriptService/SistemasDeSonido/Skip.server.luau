local remote = game.ReplicatedStorage.SistemasDeSonido.EventosDeCanciones.Skip
remote.OnServerEvent:Connect(function(Player)
	if Player.Dado.Value == false then
		Player.Dado.Value = true
		local parte = Instance.new("Part",game.ServerStorage.SistemasDeSonido.Vlaue.Skiper)
	end
end)

game.ServerStorage.SistemasDeSonido.Vlaue.Skiper.DescendantAdded:Connect(function()
	game.ReplicatedStorage.SistemasDeSonido.Valores.Skiper.Value = game.ReplicatedStorage.SistemasDeSonido.Valores.Skiper.Value  + 1
end)
game.ServerStorage.SistemasDeSonido.Vlaue.Skiper.DescendantRemoving:Connect(function()
	game.ReplicatedStorage.SistemasDeSonido.Valores.Skiper.Value = game.ReplicatedStorage.SistemasDeSonido.Valores.Skiper.Value  - 1
end)

game.ReplicatedStorage.SistemasDeSonido.Valores.Skiper.Changed:Connect(function()
	local players = game.Players:GetChildren()
	local NumeroDeJugadores = #players
	local JugadoresNecesarios = NumeroDeJugadores/2 
	if game.ReplicatedStorage.SistemasDeSonido.Valores.Skiper.Value > JugadoresNecesarios then
		game.Workspace.SoundGroup.Sonido.TimePosition = game.Workspace.SoundGroup.Sonido.TimeLength - 0.1
	end
end)

game.Workspace.SoundGroup.Sonido.Ended:Connect(function()
	local jugaores = game.Players:GetPlayers()
	local Parte = game.ServerStorage.SistemasDeSonido.Vlaue.Skiper
	
	for i,v in pairs(jugaores) do
			local Valor = v.Dado
			Valor.Value = false
	end
	Parte:ClearAllChildren()
end)

game.Players.PlayerRemoving:Connect(function(player)
	if player.Dado.Value == true then
		game.ServerStorage.SistemasDeSonido.Vlaue.Skiper.Part:Destroy()
	end
end)

game.Players.PlayerAdded:Connect(function(player)
	game.ServerStorage.SistemasDeSonido.Vlaue.Dado:Clone() .Parent = player
	
	
end)
