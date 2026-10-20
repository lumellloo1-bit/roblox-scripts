script.Parent.MouseButton1Down:Connect(function()
	local valores = script.Parent.Parent.Parent.Valores
	valores.ColorPunchLight.Value = script.Parent.Parent.Parent.Color.ColourPreview.BackgroundColor3
	valores.IntencidadPunchLight.Value = script.Parent.Parent.Parent.Intencidad.Numero1dos.Text
	script.Parent.Parent.Parent.LucesAmbientales.Text = "¡Humo!"
	script.Parent.Active = false
	script.Parent.Visible = false
	script.Parent.Parent.ContinuarHumo.Active = true
	script.Parent.Parent.ContinuarHumo.Visible = true
	script.Parent.Parent.Parent.EligeIntensidad.Visible = false
	local intencidad = script.Parent.Parent.Parent.Intencidad:GetChildren()
	script.Parent.Parent.Parent.LucesAmbientales.TextColor3 = Color3.new(0, 0, 0)
	for i,v in pairs(intencidad) do
		v.Active = false
		v.Visible = false
	end
end)
