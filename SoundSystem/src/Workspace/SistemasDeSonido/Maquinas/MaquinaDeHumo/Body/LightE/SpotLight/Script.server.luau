local valor = game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales.ColorDelHumo

valor.Changed:Connect(function(cambio)
		local colorKeypoints = {
			ColorSequenceKeypoint.new( 0, cambio),  
			ColorSequenceKeypoint.new(.5,cambio), 
			ColorSequenceKeypoint.new( 1, Color3.new(1, 1, 1))   
		}

	script.Parent.Color = cambio
	script.Parent.Parent.Color = cambio
	script.Parent.Parent.ParticleEmitter.Color = ColorSequence.new(colorKeypoints)
end)
