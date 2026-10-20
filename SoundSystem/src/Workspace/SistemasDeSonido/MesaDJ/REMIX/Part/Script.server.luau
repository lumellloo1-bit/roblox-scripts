local values =game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales

values.ColorPunch.Changed:Connect(function(cambio)
	for i,v in pairs(script.Parent.Parent:GetChildren()) do
		v.Color = cambio
	end
end)
