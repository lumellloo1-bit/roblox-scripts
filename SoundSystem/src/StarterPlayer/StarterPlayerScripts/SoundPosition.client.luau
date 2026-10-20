
game.ReplicatedStorage.SistemasDeSonido.Valores.Cambio.Changed:Connect(function()
	game.Workspace.SoundGroup.Sonido.TimePosition = 0
	game.Workspace.SoundGroup.Sonido.Playing = true
	
end)
game.ReplicatedStorage.SistemasDeSonido.Valores.Cmbio2.Changed:Connect(function()
	game.Workspace.SoundGroup.Sonido.Playing = false
end)
