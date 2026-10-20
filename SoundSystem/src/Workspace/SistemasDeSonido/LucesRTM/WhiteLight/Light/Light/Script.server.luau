local Brillo = script.Parent.Brightness
local transpa = script.Parent.Parent.Transparency
local razon = Brillo/10
local razon2 = transpa/10
local ValoresActuales = game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales
ValoresActuales.ColorPunch.Changed:Connect(function(cambio)
	script.Parent.Color = cambio
	script.Parent.Parent.Color = cambio
	
end)
ValoresActuales.IntencidadDelPunch.Changed:Connect(function(cambio)
	script.Parent.Brightness = razon * cambio
	script.Parent.Parent.Transparency = razon2 * cambio
	if cambio == 1 then
		script.Parent.Brightness = 0
		script.Parent.Parent.Transparency = 0
	end
	
end)
