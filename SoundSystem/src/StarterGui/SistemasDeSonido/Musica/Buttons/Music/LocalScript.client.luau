
script.Parent.MouseButton1Down:Connect(function()
	local Musica = script.Parent.Parent.Parent.Screens.Music.Visible
	local Suselful = script.Parent.Parent.Parent.Screens.Suselful.Visible
	if Musica == false and Suselful == true then
		Suselful = false
		script.Parent.Parent.Parent.Screens:Destroy()
		game.Workspace.SistemasDeSonido.GameStorage.Screens:Clone() .Parent = script.Parent.Parent.Parent
	elseif Musica == true and Suselful == false then
		Musica = false
		script.Parent.Parent.Parent.Screens.Music.Visible = false
		script.Parent.Parent.Parent.Screens:Destroy()
		game.Workspace.SistemasDeSonido.GameStorage.Screens:Clone() .Parent = script.Parent.Parent.Parent
	elseif Musica == false and Suselful == false then
		Musica = true
		script.Parent.Parent.Parent.Screens.Music.Visible = true
	end

end)
