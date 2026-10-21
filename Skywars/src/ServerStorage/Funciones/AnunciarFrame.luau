local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local ServerStorage = game:GetService("ServerStorage")
local RondaStorage = ServerStorage:WaitForChild("Ronda")
local StorageStorage = RondaStorage:WaitForChild("RecursosDeRonda")
local GuisStorage = StorageStorage:WaitForChild("Guis")
local BaseKillPlayerClone = GuisStorage:WaitForChild("BaseKillLeaderClone")
local BaseAnuncioEnRonda = GuisStorage:WaitForChild("BaseAnunts")
local module = {}


function module.AnunciarJugadorCaido(KillerPlayer,DeadPlayer,Razon)
	local Clonacion = BaseKillPlayerClone:Clone()
	Clonacion.Parent = nil
	Clonacion.Names.Killer.Text = KillerPlayer.Name
	Clonacion.Names.death.Text = DeadPlayer.Name
	Clonacion.Info.Text = Razon
	module.AnunciarGui(Clonacion)
end 
function module.AnuncioGeneral(Player,logro,String2,String3)
	local ClonacionParaAnunciar = BaseAnuncioEnRonda:Clone()
	ClonacionParaAnunciar.Names.Killer.Text = Player.Name
	ClonacionParaAnunciar.Info.Text = logro.." "..String2.." "..String3
	ClonacionParaAnunciar.Parent = nil
	module.AnunciarGui(ClonacionParaAnunciar)

end


function module.AnunciarGui(Gui)
	table.foreach(Players:GetPlayers(),function(_,Player)
		local PlayerGui = Player.PlayerGui
		if not PlayerGui then return end
		local AnunciosKillLeader = PlayerGui:FindFirstChild("AnunciosKillLeader",true)
		if not AnunciosKillLeader then return end
		local ScrollingKillleader = AnunciosKillLeader:FindFirstChild("ScrollingKillLeader")
		if not ScrollingKillleader then return end
		local Clonacion = Gui:Clone()
		Clonacion.Parent = ScrollingKillleader
		Debris:AddItem(Clonacion,5)
		Debris:AddItem(Gui,5)
	end)
end



return module
