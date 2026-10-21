local ServerStorage = game:GetService("ServerStorage")
--//Instances//--
local RondaStorage = ServerStorage:WaitForChild("Ronda")
local ValoresDeRonda = RondaStorage:WaitForChild("ValoresDeRonda")
--Values//--
local KillsValue = ValoresDeRonda:WaitForChild("KillsMatador")
local COinsValue = ValoresDeRonda:WaitForChild("CoinsMatador")
--//Modules//--
local AnunciarFrameModule = require(script.Parent:WaitForChild("AnunciarFrame"))
local module = {}
function module.LeaderDataKillCount(KillerPlayer,DeathPlayer,Tool)
	local a,b = pcall(function()
		local LeaderStats = KillerPlayer.leaderstats
		local Kills = LeaderStats.Kills
		local Coins = LeaderStats.Coins
		Kills.Value = Kills.Value + KillsValue.Value
		Coins.Value = Coins.Value + COinsValue.Value
		if Kills.Value == 1 or Kills.Value == 10 or Kills.Value == 100 or Kills.Value == 1000 or Kills.Value == 10000 or Kills.Value == 500  then
			local AgregacionDeMonedas = ValoresDeRonda:FindFirstChild(KillsValue.Value.."Kill")
			Coins.Value = Coins.Value + AgregacionDeMonedas.Value
			AnunciarFrameModule.AnuncioGeneral(KillerPlayer,"reached",Kills.Value," kills ".."+".." "..AgregacionDeMonedas.Value.." Coins")
		end
		AnunciarFrameModule.AnunciarJugadorCaido(KillerPlayer,DeathPlayer,"with "..Tool.." +"..COinsValue.Value.." Coins")

	end)
	if b then 
		print(b)
	end
end

return module
