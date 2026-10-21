--//Services//--
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")


--//Instances//--
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local FunctionEvents = RemoteEvents:WaitForChild("Functions")
local RemoteAdmon = FunctionEvents:WaitForChild("AdminEvent")
local RondaStorage = ServerStorage:WaitForChild("Ronda")
local ValuesDeRonda = RondaStorage:WaitForChild("ValoresDeRonda")
local AdminScreen = script:WaitForChild("Admin")
local ValoresDeArmas = ValuesDeRonda:WaitForChild("ValoresDeArmas")


--//ValoresNecesarios//--




local JugadoresConAdmin = {
	724581388,
	1355239100,
	631370876,
	295979675,
	441745120,
	859271520,
	608245901
}


RemoteAdmon.OnServerEvent:Connect(function(Player,Change,Valor,Bool)
	if Bool == false then
		local ID = Player.UserId
		local Paso = false
		table.foreach(JugadoresConAdmin,function(_,Jugador)
			if ID == Jugador then
				Paso = true
			end
		end)
		if not Paso then return end
		local ValorModificado = ValuesDeRonda:FindFirstChild(Valor,true)
		if ValorModificado then
			local ok,Error = pcall(function()
				ValorModificado.Value = Change
			end)
		end
	else
		if Valor == "SwordDamage" then
			local ValorMod = script:FindFirstChild(Player.Name.."SwordDamage")
			if not ValorMod then return end
			local Ok,eRRor = pcall(function()
				ValorMod.Value = Change

			end)
		elseif Valor == "BowDamage" then
			local ValorMod = script:FindFirstChild(Player.Name.."BowDamage")
			if not ValorMod then return end
			local Ok,eRRor = pcall(function()
				ValorMod.Value = Change

			end)
		elseif Valor == "ReloadTimeBow" then
			local ValorMod = script:FindFirstChild(Player.Name.."BowReload")
			if not ValorMod then return end
			local Ok,eRRor = pcall(function()
				ValorMod.Value = Change

			end)
		elseif Valor == "TeleportPlayer" then
			local CharacterAdmin = Player.Character
			if not CharacterAdmin then return end
			local PlayerDeseado = Players:FindFirstChild(Change)
			if not PlayerDeseado then return end
			local CharacterDeseado = PlayerDeseado.Character
			if not CharacterDeseado then return end
			local ok,Error = pcall(function()
				CharacterAdmin.HumanoidRootPart.Position = CharacterDeseado.HumanoidRootPart.Position
			end)
		elseif Valor == "KillPalyer" then
			local PlayerDeseado = Players:FindFirstChild(Change)
			if not PlayerDeseado then return end
			local CharacterDeseado = PlayerDeseado.Character
			if not CharacterDeseado then return end
			local ok,Error = pcall(function()
				CharacterDeseado.Humanoid.Health = 0
			end)
		elseif Valor == "KillAllPlayers" then
			table.foreach(Players:GetChildren(),function(_,Player)
				local ok,Error = pcall(function()
					Player.Character.Humanoid.Health = 0
				end)
			end)
		elseif Valor == "KickPlayer" then
			local Player = Players:FindFirstChild(Change)
			if not Player then return end
			Player:Kick("Admin kick u")
		elseif Valor == "KickAllPlayers" then
			table.foreach(Players:GetChildren(),function(_,Player)
				local ok,Error = pcall(function()
					Player:Kick("Admin close the server")
				end)
			end)
			
		end
		
	end
	
end)

game.Players.PlayerAdded:Connect(function(Player)
	local Id = Player.UserId
	table.foreach(JugadoresConAdmin,function(_,IDPRE)
		if Id == IDPRE then
			local Clonacion = AdminScreen:Clone()
			Clonacion.Parent = Player.PlayerGui
			local BowDamage = Instance.new("NumberValue",script)
			local ReloadTimeBow = Instance.new("NumberValue",script)
			local SwordDamage = Instance.new("NumberValue",script)
			BowDamage.Name = Player.Name.."BowDamage"
			ReloadTimeBow.Name = Player.Name.."BowReload"
			SwordDamage.Name = Player.Name.."SwordDamage"
			BowDamage.Value = 125315813
			ReloadTimeBow.Value = 125315813
			SwordDamage.Value = 125315813 
			
		end
	end)
end)


game.Players.PlayerRemoving:Connect(function(Player)
	local Value1 = script:FindFirstChild(Player.Name.."BowDamage")
	local Value2 = script:FindFirstChild(Player.Name.."BowReload")
	local Value3 = script:FindFirstChild(Player.Name.."SwordDamage")
	local ok,Error = pcall(function()
		Value1:Destroy()
	end)
	local ok,Error = pcall(function()
		Value2:Destroy()
	end)
	local ok,Error = pcall(function()
		Value3:Destroy()
	end)
end)
