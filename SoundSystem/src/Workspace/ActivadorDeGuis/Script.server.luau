local players = game:GetService("Players")
script.Parent.Touched:Connect(function(hit)
	local character
	local humanoid = hit.Parent:FindFirstChild("Humanoid")
	if humanoid then
		character = hit.Parent
	end
	local jugador = players:GetPlayerFromCharacter(character)
	if jugador then
		jugador.PlayerGui.SistemasDeSonido.Musica.Enabled = true
	end
end)
