local ValoresActuales = game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales
ValoresActuales.ColorFuego.Changed:Connect(function(cambio)
	local bolas = script.Parent.Parent.FireBalls:GetChildren()
	for i,v in pairs(bolas) do
		v.Fire.Color = cambio
	end
end)
