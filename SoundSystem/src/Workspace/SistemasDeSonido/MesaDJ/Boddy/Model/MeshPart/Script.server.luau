local values = game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales
local razon2 = 1/10
values.AmbientColor.Changed:Connect(function(cambio)
	for i,v in pairs(script.Parent.Parent:GetChildren()) do
		if v.ClassName == "Part" then
			v.Color = cambio
		end
		if v.ClassName == "MeshPart" then
			v.Color = cambio
		end
	end

end)
