local values = game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales

values.AmbientColor.Changed:Connect(function(cambio)
	script.Parent.Color = cambio
	script.Parent.Parent.Color = cambio
end)
