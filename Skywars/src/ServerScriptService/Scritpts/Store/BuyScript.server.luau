--//Services//--

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage") 
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
--//Instances//--
local RondaStorage = ServerStorage:WaitForChild("Ronda")
local Remotes = ReplicatedStorage:WaitForChild("RemoteEvents")
local StoreRemotes = Remotes:WaitForChild("RemoteStore")
local RemoteDeBuy = StoreRemotes:WaitForChild("Buy")

--//ValuesStorage//--

local ValoresDeRonda = RondaStorage:WaitForChild("ValoresDeRonda")
local ValoresDeArmas = ValoresDeRonda:WaitForChild("ValoresDeArmas")
local ValoresDeArmor = ValoresDeArmas:WaitForChild("ValoresDeArmor")
local CostosDeArmor = ValoresDeArmor:WaitForChild("Costos")
--//ValoresReplicated//
local ValoresReplicated = ReplicatedStorage:WaitForChild("Valores")
local ValoresDeStore = ValoresReplicated:WaitForChild("ValoresDeStore")
local ArmasEnRondaDeJugadores = ValoresDeStore:WaitForChild("ArmasDeJugadores")
local ArmorEnRondaDeJugadores = ArmasEnRondaDeJugadores:WaitForChild("Armor")
local GamePases = {
	{"Iron",110360600},
	{"Gold",110360826},
	{"Stone",110360987},
	{"Diamond",110361065},
	{"Ruby",110361172},
	{"Emerald",110361267},
	{"Obsidian",110361358}
}
local ArmorPases = {
	{"Ruby",113120361},
	{"Emerald",113121081},
	{"Obsidian",113121476}
}

local function PasesComprado(Player,Id)
	local PackQueCompro 
	table.foreach(GamePases,function(_,Pass)
		if Id == Pass[2] then
			PackQueCompro = Pass[1]
		end
	end)
	
	local GuiDelJugador = Player.PlayerGui
	local Store = GuiDelJugador:WaitForChild("Store")
	table.foreach(Store:GetDescendants(),function(_,Boton)
		if  Boton.Name == "Robux" then
			if Boton.Parent.Parent.Name == PackQueCompro then
				local TipoDeArma = Boton.Parent.Parent.Parent.Parent.Name
				if TipoDeArma ~= "Armor" then
					local Coins = Boton.Parent:FindFirstChild("Coins")
					if Coins then
						Coins.Text = "Equip"
						Boton.Visible = false

					else
						Boton.Text = "Equip"	
					end
					local ValorDeClonacion = Instance.new("StringValue")
					ValorDeClonacion.Name = Player.Name
					ValorDeClonacion.Value = PackQueCompro
					local Folder = ArmasEnRondaDeJugadores:FindFirstChild(TipoDeArma)
					if Folder then
						ValorDeClonacion.Parent = Folder
					end
				end

			end
		end
	end)

end
local function ArmorComprado(Player,Id)
	local PackQueCompro 
	table.foreach(ArmorPases,function(_,Pass)
		if Id == Pass[2] then
			PackQueCompro = Pass[1]
		end
	end)

	local GuiDelJugador = Player.PlayerGui
	local Store = GuiDelJugador:WaitForChild("Store")
	table.foreach(Store:GetDescendants(),function(_,Boton)
		if  Boton.Name == "Robux" then
			if Boton.Parent.Parent.Name == PackQueCompro then
				local TipoDeArma = Boton.Parent.Parent.Parent.Parent.Name
				if TipoDeArma == "Armor" then
					local Coins = Boton.Parent:FindFirstChild("Coins")
					if Coins then
						Coins.Text = "Equip"
						Boton.Visible = false

					else
						Boton.Text = "Equip"	
					end
					local ValorDeClonacion = Instance.new("StringValue")
					ValorDeClonacion.Name = Player.Name
					ValorDeClonacion.Value = PackQueCompro
					local Folder = ArmasEnRondaDeJugadores:FindFirstChild(TipoDeArma)
					if Folder then
						ValorDeClonacion.Parent = Folder
					end
				end

			end
		end
	end)

end
local function ChecarArmaduras(Player)
	local LeaderstatsLocal = Player:WaitForChild("leaderstats")
	local WinsLocal = LeaderstatsLocal:WaitForChild("Wins")
	local NumeroDeWins = WinsLocal.Value
	local GuiDelJugador = Player.PlayerGui
	local Store = GuiDelJugador:WaitForChild("Store")
	table.foreach(CostosDeArmor:GetChildren(),function(_,ClidadDeArmor)
		if NumeroDeWins >= ClidadDeArmor.Value then
			local ValorDeEspadaComprada = Instance.new("StringValue",ArmorEnRondaDeJugadores)
			ValorDeEspadaComprada.Name = Player.Name
			ValorDeEspadaComprada.Value = ClidadDeArmor.Name
			table.foreach(Store:GetDescendants(),function(_,Boton)
				if Boton.Name == "Wins" then
					local ArmaduraQueTiene = Boton.Parent.Parent.Name
					if ArmaduraQueTiene == ClidadDeArmor.Name then
						Boton.Text = "Equip"
					end
				end
			end)
		end

	end)
end
RemoteDeBuy.OnServerEvent:Connect(function(Player,TipoDePago,ArmaDeseada,TipoDeArma)
	local ArmaDeseada = ArmaDeseada
	local YaLaTiene = false
	local ArmasDeJugadoresNecesarias = ArmasEnRondaDeJugadores:FindFirstChild(TipoDeArma)
	for i,v in pairs(ArmasDeJugadoresNecesarias:GetChildren()) do
		if v.Name == Player.Name  then
			if v.Value == ArmaDeseada then
				YaLaTiene = true
			end
		end
	end
	if YaLaTiene == false then
		local NombreDeBusquedaPrecio = "ValoresDe"..TipoDeArma
		local CostosDeArma = ValoresDeArmas:FindFirstChild(NombreDeBusquedaPrecio):FindFirstChild("Costos")
		if TipoDePago == "Coins" then
			local Precio 
			table.foreach(CostosDeArma:GetChildren(),function(_,ValueCostoG)

				if ValueCostoG.Name == ArmaDeseada then
					Precio = ValueCostoG.Value
				end
			end)
			if Precio then
				local Leaderstats
				local Coins
				local Ok,Error = pcall(function()
					Leaderstats = Player:FindFirstChild("leaderstats")
					Coins = Leaderstats:FindFirstChild("Coins")
				end)
				if Ok then
					if Coins.Value >= Precio then
						local Gui = Player.PlayerGui
						local Tienda = Gui:WaitForChild("Store")
						local NombreDeFrame = TipoDeArma.."Frame"
						local NombreDeScrolling = "ScrollingBuy"..TipoDeArma
						local Espadas = Tienda:WaitForChild(NombreDeFrame):WaitForChild(TipoDeArma):WaitForChild(NombreDeScrolling)
						if Espadas then
							local EspadaQueCompro = Espadas:FindFirstChild(ArmaDeseada)
							if EspadaQueCompro then
								local CoinsDeTexto = EspadaQueCompro:FindFirstChild("UI"):FindFirstChild("Coins") or EspadaQueCompro:FindFirstChild("UI"):FindFirstChild("Robux")
								if CoinsDeTexto then
									if TipoDeArma ~= "Potions" then
										table.foreach(Espadas:GetDescendants(),function(_,ValorDeEquipado)
											if ValorDeEquipado.Name == "Coins" or ValorDeEquipado.Name == "Robux"  then
												if ValorDeEquipado.Text == "Equipped" then
													ValorDeEquipado.Text = "Equip"
												end
											end
										end)
									end
									local ValorDeEspadaComprada = Instance.new("StringValue",ArmasDeJugadoresNecesarias)
									ValorDeEspadaComprada.Name = Player.Name
									ValorDeEspadaComprada.Value = ArmaDeseada
									CoinsDeTexto.Text = "Equipped"
									local ValoresDeRONDA = Player:FindFirstChild("ValoresDeRonda")
									if ValoresDeRONDA then
										local ToolValuesPlayer = ValoresDeRONDA:FindFirstChild("ToolValues")
										if ToolValuesPlayer then
											local Sword = ToolValuesPlayer:FindFirstChild(TipoDeArma)
											if Sword then
												Coins.Value = Coins.Value - Precio
												if TipoDeArma == "Potions" then
													local ValorSecundarioNuevo = Instance.new("NumberValue",Sword)
													ValorSecundarioNuevo.Value = #Sword:GetChildren()
													ValorSecundarioNuevo.Name = ArmaDeseada
												else
													Sword.Value = ArmaDeseada
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		elseif TipoDePago == "Robux" then
			if TipoDeArma ~= "Armor" then
				table.foreach(GamePases,function(_,Pase)
					if Pase[1] == ArmaDeseada then
						MarketplaceService:PromptGamePassPurchase(Player,Pase[2])

					end
				end)
			elseif TipoDeArma == "Armor" then
				
				table.foreach(ArmorPases,function(_,Pase)
					if Pase[1] == ArmaDeseada then
						MarketplaceService:PromptGamePassPurchase(Player,Pase[2])
					end
				end)
			end
			
		end
	else
		local equiparD = false
		local Gui = Player.PlayerGui
		local Tienda = Gui:WaitForChild("Store")
		local NombreDeFrame = TipoDeArma.."Frame"
		local NombreDeScrolling = "ScrollingBuy"..TipoDeArma
		local Espadas = Tienda:WaitForChild(NombreDeFrame):WaitForChild(TipoDeArma):WaitForChild(NombreDeScrolling)
		if Espadas then
			local EspadaQueCompro = Espadas:FindFirstChild(ArmaDeseada)
			if EspadaQueCompro then
				local CoinsDeTexto = EspadaQueCompro:FindFirstChild("UI"):FindFirstChild("Coins") or EspadaQueCompro:FindFirstChild("UI"):FindFirstChild("Robux") or EspadaQueCompro:FindFirstChild("UI"):FindFirstChild("Wins")
				if CoinsDeTexto then
					if TipoDeArma ~= "Potions" then
						table.foreach(Espadas:GetDescendants(),function(_,ValorDeEquipado)
							if ValorDeEquipado.Name == "Coins" or  ValorDeEquipado.Name == "Robux"or ValorDeEquipado.Name == "Wins" then 
								if TipoDeArma ~= "Armor" then
									if ValorDeEquipado.Text == "Equipped" then
										ValorDeEquipado.Text = "Equip"
									end
								else
									if ValorDeEquipado.Text == "Equipped" then
										ValorDeEquipado.Text = "Equip"
									end
								end
								
							end
						end)

					end
					local ValoresDeRONDA = Player:FindFirstChild("ValoresDeRonda")
					if ValoresDeRONDA then
						local ToolValuesPlayer = ValoresDeRONDA:FindFirstChild("ToolValues")
						if ToolValuesPlayer then
							local Sword = ToolValuesPlayer:FindFirstChild(TipoDeArma)
							if Sword then
								if TipoDeArma ~= "Potions" and TipoDeArma~="Armor" then
									Sword.Value = ArmaDeseada
								elseif TipoDeArma == "Potions" then
									local ValorSecundario = Sword:FindFirstChild(ArmaDeseada)
									if ValorSecundario then
										ValorSecundario:Destroy()
									else
										equiparD = true
										local ValorSecundarioNuevo = Instance.new("NumberValue",Sword)
										ValorSecundarioNuevo.Value = #Sword:GetChildren()
										ValorSecundarioNuevo.Name = ArmaDeseada
									end
								elseif TipoDeArma == "Armor" then
									local ValueEnPlayer = ToolValuesPlayer:FindFirstChild("Armor")
									if not ValueEnPlayer then return end
									if ValueEnPlayer.Value == ArmaDeseada then
										Sword.Value = " "
										CoinsDeTexto.Text = "Equip"

									else
										Sword.Value = ArmaDeseada
										CoinsDeTexto.Text = "Equipped"
									end
								end
							end
						end
					end
					if TipoDeArma ~= "Potions" and TipoDeArma ~= "Armor" then
						CoinsDeTexto.Text = "Equipped"
					elseif TipoDeArma == "Potions" then
						if equiparD == false then
							CoinsDeTexto.Text = "Equip"
						else
							CoinsDeTexto.Text = "Equipped"
						end
					
					end
				end
			end
		end
	end
end)

MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(Player,Id,Bol)
	if Bol == true then
		PasesComprado(Player,Id)
		ArmorComprado(Player,Id)
	end
end)

Players.PlayerAdded:Connect(function(Player)
	for _,Pase in pairs(GamePases) do
		local TieneElPase = MarketplaceService:UserOwnsGamePassAsync(Player.UserId,Pase[2])
		if TieneElPase == true then
			PasesComprado(Player,Pase[2])
		end
	end
	for _,Armor in pairs(ArmorPases) do
		local TieneElPase = MarketplaceService:UserOwnsGamePassAsync(Player.UserId,Armor[2])
		if TieneElPase == true then
			ArmorComprado(Player,Armor[2])
		end
	end
	ChecarArmaduras(Player)
	local Leader = Player:WaitForChild("leaderstats")
	local Wins = Leader:WaitForChild("Wins")
	Wins.Changed:Connect(function()
		ChecarArmaduras(Player)
	end)
end)
