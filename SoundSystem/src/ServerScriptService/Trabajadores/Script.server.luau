local remote = game.ReplicatedStorage.Trabajadores.BarmannActtivado

remote.OnServerEvent:Connect(function(a,b)
	if b.Name == "Pastel" then
		script.Pastel:Clone().Parent = a.Backpack
	end
	if b.Name == "Soda" then
		script.Soda:Clone().Parent = a.Backpack
	end
	if b.Name == "Bebida" then
		script.Bebida:Clone().Parent = a.Backpack
	end
end)
