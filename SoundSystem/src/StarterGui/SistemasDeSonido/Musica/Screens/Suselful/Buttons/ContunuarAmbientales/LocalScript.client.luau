local Values = script.Parent.Parent.Parent.Valores
local correccion = false
script.Parent.MouseButton1Down:Connect(function()
	Values.ColorAmbientLight.Value = script.Parent.Parent.Parent.Color.ColourPreview.BackgroundColor3
	if  script.Parent.Parent.Parent.Intencidad.Numero1dos.Text == "Numero del 1 al 10"  then
		correccion = true
		script.Parent.Parent.Parent.Intencidad.Numero1dos.Text = "¡INTRODUCE UN VALOR DEL 1 AL 10!"
		script.Parent.Parent.Parent.Intencidad.Numero1dos.TextColor3 = Color3.new(255, 0, 0)
		wait(3)
		script.Parent.Parent.Parent.Intencidad.Numero1dos.Text = "Numero del 1 al 10"
		script.Parent.Parent.Parent.Intencidad.Numero1dos.TextColor3 = Color3.new(1, 1, 1)
	else
		correccion = false
	end
	if correccion == false then
		Values.IntensidadAmbientLight.Value = script.Parent.Parent.Parent.Intencidad.Numero1dos.Text
		script.Parent.Active = false
		script.Parent.Visible = false
		script.Parent.Parent.ContinuarLucesRitmo.Visible = true
		script.Parent.Parent.ContinuarLucesRitmo.Active = true
		script.Parent.Parent.Parent.LucesAmbientales.Text = "Luces al ritmo de la musica"
		script.Parent.Parent.Parent.LucesAmbientales.TextColor3 = Color3.new(1, 1, 1)
		script.Parent.Parent.Parent.EligeColor.TextColor3 = Color3.new(1, 1, 1)
		script.Parent.Parent.Parent.EligeIntensidad.TextColor3 = Color3.new(1, 1, 1)
	end
end)
