local values = game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales
local brillo = script.Parent.Brightness
local transparencya = script.Parent.Parent.Transparency
local razon = brillo/10
local razon2 = transparencya/10
values.AmbientColor.Changed:Connect(function(cambio)
	script.Parent.Color = cambio
	script.Parent.Parent.Color = cambio
end)
values.IntencidadDeluzAmbien.ChildAdded:Connect(function(cambio)	
	script.Parent.Brightness = razon * cambio
	script.Parent.Parent.Transparency = razon2 * cambio
	if cambio == 1 then
		script.Parent.Brightness = 0
		script.Parent.Parent.Transparency = 0
	end
end)
