
local Remote = game.ReplicatedStorage.SistemasDeSonido.EventosDeCanciones.Skip
script.Parent.MouseButton1Down:Connect(function()
	Remote:FireServer()
end)
