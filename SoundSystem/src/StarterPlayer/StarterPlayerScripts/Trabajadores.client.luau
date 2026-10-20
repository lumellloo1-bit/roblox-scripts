local remote = game.ReplicatedStorage.Trabajadores.BarmannActtivado
game.Workspace.Trabajadores.bartender.Head.Dialog.DialogChoiceSelected:Connect(function(a,b)
	remote:FireServer(b)
end)

game.Workspace.Trabajadores.Camarera.Head.Dialog.DialogChoiceSelected:Connect(function(a,b)
	remote:FireServer(b)
end)
