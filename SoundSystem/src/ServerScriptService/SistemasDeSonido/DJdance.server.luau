

game.Workspace.SistemasDeSonido.Momentario.ChildAdded:Connect(function(desendiente)
	game.ServerStorage.SistemasDeSonido.GameStorage.Scripts.Dance:Clone() .Parent = desendiente
	desendiente.Dance.Disabled = false
end)
