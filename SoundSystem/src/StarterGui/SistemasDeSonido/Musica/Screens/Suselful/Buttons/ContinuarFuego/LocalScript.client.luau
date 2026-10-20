
function comprar()
	local valores = script.Parent.Parent.Parent.Valores
	local remote = game.ReplicatedStorage.SistemasDeSonido.EventosDeCanciones.EnvioDeDatos
	local Cancion = valores.IDCANCION
	remote:FireServer(valores.ColorPunchLight.Value,valores.ColorAmbientLight.Value,valores.IntensidadAmbientLight.Value,valores.IntencidadPunchLight.Value,valores.ColorSmoke.Value,Cancion.Value,valores.ColorFuego.Value,valores.Promedio.Value,valores.MaximoV.Value)
end
script.Parent.MouseButton1Down:Connect(function()
	local valores = script.Parent.Parent.Parent.Valores
	valores.ColorFuego.Value = script.Parent.Parent.Parent.Color.ColourPreview.BackgroundColor3
	script.Parent.Parent.Parent.Parent.Suselful.Visible = false
	comprar()
	script.Parent.Parent.Parent.Parent.Suselful.Visible = false
	script.Parent.Parent.Parent.Parent.Parent.Screens.Name = "Scrins"
	game.Workspace.SistemasDeSonido.GameStorage.Screens:Clone() .Parent = script.Parent.Parent.Parent.Parent.Parent
	script.Parent.Parent.Parent.Parent.Parent.Scrins:Destroy()
	
end)
