local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
--//Instances//--
local FuncionesStorage = ServerStorage:WaitForChild("Funciones")
local RondaStorage = ServerStorage:WaitForChild("Ronda")
local ValoresDeRonda = RondaStorage:WaitForChild("ValoresDeRonda")
local ValoresDeArmas = ValoresDeRonda:WaitForChild("ValoresDeArmas")
local ValoresDeSwords = ValoresDeArmas:WaitForChild("ValoresDeSword")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local RemoteAmras = RemoteEvents:WaitForChild("RemotesArmas")
local RemotesEspada = RemoteAmras:WaitForChild("RemotesEspada")
local RemoteDano = RemotesEspada:WaitForChild("DanoEspada")
local FunccionesLeader = require(FuncionesStorage:WaitForChild("FuncionesLeader"))
local Magnitudes = ValoresDeSwords:WaitForChild("Magnitudes")
local ValoresReplicated = ReplicatedStorage:WaitForChild("Valores")
local ValoresArmasReplicated = ValoresReplicated:WaitForChild("ValoresPotenciadores")
local ValoresEscudoReplicated = ValoresArmasReplicated:WaitForChild("ValoresEscudo")
local JugadoresEscudados = ValoresEscudoReplicated:WaitForChild("Jugadores")
local GameScripts = script.Parent.Parent.Parent:WaitForChild("Game")
local AdminScript = GameScripts:WaitForChild("AdminScript")
--//ValuesEspada//--
local ReloadTime = ValoresDeSwords:WaitForChild("ReloadTime")



RemoteDano.OnServerEvent:Connect(function(Player)
	local ValueDeRetorno = script:FindFirstChild(Player.Name)if ValueDeRetorno then return  end
	RemoteDano:FireClient(Player)
	local ValueAgregado = Instance.new("BoolValue",script)
	ValueAgregado.Name = Player.Name
	Debris:AddItem(ValueAgregado,ReloadTime.Value)
	local Character = Player.Character if not Character then return end
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")if not Humanoid then return end
	if Humanoid.Health <= 0 then return end
	local Tool = Character:FindFirstChildOfClass("Tool")if not Tool  then return end
	if Tool.Name ~= "Sword" then return end
	local Handle = Tool:FindFirstChild("Handle")if not Handle or  not Handle:IsA("BasePart") then return end
	local ConexionDeFuncion
	local _,_ = pcall(function()delay(ReloadTime.Value,function()ConexionDeFuncion:Disconnect()end)	end) 
	ConexionDeFuncion = RunService.Heartbeat:Connect(function()
		local partesDentro = workspace:GetPartsInPart(Handle)
		local YaHaPegado = false
		if #partesDentro > 0 then
			table.foreach(partesDentro,function(Num,PosibleParteHit)
				if  YaHaPegado then return end
				local CharacterAtacado = partesDentro[Num].Parent
				local HumanoidAtacado = CharacterAtacado:FindFirstChildOfClass("Humanoid")if not HumanoidAtacado then return end
				if CharacterAtacado.Name == Player.Name then return end
				YaHaPegado = true
				ConexionDeFuncion:Disconnect()
				local ValoresDeRondaJugador = Player:FindFirstChild("ValoresDeRonda")if not ValoresDeRondaJugador then return end
				local ToolValuesJugador = ValoresDeRondaJugador:WaitForChild("ToolValues")if not ToolValuesJugador then return end
				local ValueSwordLocal = ToolValuesJugador:FindFirstChild("Sword")if not ValueSwordLocal then return end
				local ArmaDelJugador = ValueSwordLocal.Value
				local Dano = Magnitudes:FindFirstChild(ArmaDelJugador)if not Dano then return end
				local Escudado = JugadoresEscudados:FindFirstChild(CharacterAtacado.Name)if Escudado then return end
				if HumanoidAtacado.Health <= 0 then return end
				local DanoCambiado = AdminScript:FindFirstChild(Player.Name.."SwordDamage")
				if DanoCambiado then
					local DanoAdm = DanoCambiado.Value
					if DanoAdm~= 125315813 then
						HumanoidAtacado.Health = HumanoidAtacado.Health - DanoAdm
					else
						HumanoidAtacado.Health = HumanoidAtacado.Health - Dano.Value
					end
				else
					HumanoidAtacado.Health = HumanoidAtacado.Health - Dano.Value
				end
				if HumanoidAtacado.Health > 0 then return end
				local KilledPlayer = Players:GetPlayerFromCharacter(CharacterAtacado)if not KilledPlayer then return end
				FunccionesLeader.LeaderDataKillCount(Player,KilledPlayer,"Sworld")
			end)
			
		end
		
	end)
	 
end)
