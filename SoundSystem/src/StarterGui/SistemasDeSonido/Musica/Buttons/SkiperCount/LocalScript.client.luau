wait(1)
local primero =  game.ReplicatedStorage.SistemasDeSonido.Valores.Skiper.Value
local Players = game.Players:GetChildren()
local NumeroDePlayers = #Players
local Necesario = NumeroDePlayers * 0.51
local segundo = math.ceil(Necesario)
script.Parent.Text = primero.."/"..segundo
game.ReplicatedStorage.SistemasDeSonido.Valores.Skiper.Changed:Connect(function()
	local primero =  game.ReplicatedStorage.SistemasDeSonido.Valores.Skiper.Value
	local Players = game.Players:GetChildren()
	local NumeroDePlayers = #Players
	local Necesario = NumeroDePlayers * 0.51
	local segundo = math.ceil(Necesario)
	script.Parent.Text = primero.."/"..segundo
end)

game.Players.PlayerAdded:Connect(function()
	local primero =  game.ReplicatedStorage.SistemasDeSonido.Valores.Skiper.Value
	local Players = game.Players:GetChildren()
	local NumeroDePlayers = #Players
	local Necesario = NumeroDePlayers * 0.51
	local segundo = math.ceil(Necesario)
	script.Parent.Text = primero.."/"..segundo
end)

game.Players.PlayerRemoving:Connect(function()
	local primero =  game.ReplicatedStorage.SistemasDeSonido.Valores.Skiper.Value
	local Players = game.Players:GetChildren()
	local NumeroDePlayers = #Players
	local Necesario = NumeroDePlayers * 0.51
	local segundo = math.ceil(Necesario)
	script.Parent.Text = primero.."/"..segundo
end)
