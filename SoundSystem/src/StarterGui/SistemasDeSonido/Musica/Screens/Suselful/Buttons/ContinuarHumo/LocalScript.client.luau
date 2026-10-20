
script.Parent.MouseButton1Down:Connect(function()
	local valores = script.Parent.Parent.Parent.Valores
	valores.ColorSmoke.Value = script.Parent.Parent.Parent.Color.ColourPreview.BackgroundColor3
	script.Parent.Active = false
	script.Parent.Visible = false
	script.Parent.Parent.Parent.LucesAmbientales.Text = "¡Fuego!"
	script.Parent.Parent.ContinuarFuego.Active = true
	script.Parent.Parent.ContinuarFuego.Visible = true
	script.Parent.Parent.Parent.LucesAmbientales.TextColor3 = Color3.new(1, 1, 1)

end)
