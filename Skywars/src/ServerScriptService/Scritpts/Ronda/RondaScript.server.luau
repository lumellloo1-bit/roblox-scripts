--//Servicios//--
local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local SoundService = game:GetService("SoundService")
--//Instancers//--
local RondaStorage = ServerStorage:WaitForChild("Ronda")
local ValoresDeRondaStorage = RondaStorage:WaitForChild("ValoresDeRonda")
local RecursosDeRondaStorage = RondaStorage:WaitForChild("RecursosDeRonda")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local Functions = RemoteEvents:WaitForChild("Functions")
local ReFuncionDeTeletransportarJugador = Functions:WaitForChild("TeletrasnportarJugador")

--//DataStore//--
local MonedasData = DataStoreService:GetDataStore("Coins")
local WinsData = DataStoreService:GetDataStore("Wins")
--//ValuesStorage//--
local MinimoDeJugadores = ValoresDeRondaStorage:WaitForChild("MinimoDeJugadores")
local Estatus = ValoresDeRondaStorage:WaitForChild("Estatus")
local EnPartida = ValoresDeRondaStorage:WaitForChild("EnPartida")
local NumeroDeJugadoresEnRonda = ValoresDeRondaStorage:WaitForChild("NumeroDeJugadoresEnRonda")
local TiempoDeRonda = ValoresDeRondaStorage:WaitForChild("TiempoDeRonda")
local SegundosTime = ValoresDeRondaStorage:WaitForChild("SegundosTime")
local TiempoDeIntermicion = ValoresDeRondaStorage:WaitForChild("TiempoDeIntermicion")
local TiempoDeEspera = ValoresDeRondaStorage:WaitForChild("TiempoDeEspera")
local EsperaParaCrear = ValoresDeRondaStorage:WaitForChild("EsperaParaCrear")
local EsperaDeCarga = ValoresDeRondaStorage:WaitForChild("EsperaDeCarga")
local MonedasGanadores = ValoresDeRondaStorage:WaitForChild("MonedasGanadores")
local MonedasGanador = ValoresDeRondaStorage:WaitForChild("MonedasGanador")
local VictoriasGanador = ValoresDeRondaStorage:WaitForChild("VictoriasGanador")
local NumeroDeBloques = ValoresDeRondaStorage:WaitForChild("NumeroDeBloques")
local ValoresDeTools = ValoresDeRondaStorage:WaitForChild("ValoresDeArmas")
local ValoresDeArmor = ValoresDeTools:WaitForChild("ValoresDeArmor")
local MagnitudesArmor = ValoresDeArmor:WaitForChild("Magnitudes")
--//ValuesReplicated//--
local ValoresDeRondaReplicated = ReplicatedStorage:WaitForChild("Valores")
local ValoresDeCamaraReplicated = ValoresDeRondaReplicated:WaitForChild("ValoresDeCamara")
local  CamaraSePuedeReplicated = ValoresDeCamaraReplicated:WaitForChild("SePuedeJugadores")
local ValoresGameReplicated = ValoresDeRondaReplicated:WaitForChild("ValoresGame")
local SegundosTimeReplicated = ValoresGameReplicated:WaitForChild("SegundosTimeValue")
--//InstancesWorkspace//--
local PosicionesDeJugadores = workspace:WaitForChild("RondasFunciones"):WaitForChild("PosicionesJugadores")
local RondasFuncionesWorkspace = workspace:WaitForChild("RondasFunciones")
local IslaLocal = RondasFuncionesWorkspace:WaitForChild("IslaLocal")
local BloquesDeRonda = RondasFuncionesWorkspace:WaitForChild("BloquesDeRonda")
--//InstancesStorage//--
local islas = RecursosDeRondaStorage:WaitForChild("Mapa"):GetChildren()
local ArmasStorage = RecursosDeRondaStorage:WaitForChild("Armas")
--//ValuesInd//--
local PuedeAbrirJugRest = false
--/FuncionesStorage//--
local FuncionesStorage = ServerStorage:WaitForChild("Funciones")
local AnunciarFrame = require(FuncionesStorage:WaitForChild("AnunciarFrame"))

local function CombertirUnidades (Z,Z1)
	local Z2 = math.floor(Z/60)local Z3 = Z - Z2 * 60 local Z4 local Z5
	if Z2<10 then Z4="0"..Z2 else Z4=Z2 end
	if Z3 < 10 then Z5 = "0"..Z3 else Z5 = Z3 end Z1.Value = Z4.." : "..Z5
end
function ChecarJugadores()
	local NumeroDePlayersConCharacter = {}
	table.foreach(Players:GetPlayers(),function(_,Player)
		local Character = Player.Character 
		if not Character then return end
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		if not Humanoid then return end
		if Humanoid.Health <= 0 then return end
		table.insert(NumeroDePlayersConCharacter,Player)	
	end)
	if #NumeroDePlayersConCharacter < MinimoDeJugadores.Value then
		local PuntosValue = "."	
		local PuntosProgresivosFunction = coroutine.wrap(function(H1)
			local H2 = true task.spawn(function()
				while wait() do 
					if H2 == true then 
						PuntosValue = "."wait(H1.Value/3)PuntosValue = ".."wait(H1.Value/3)
						PuntosValue = "..."wait(H1.Value/3)
					else break
					end
				end 
			end)
			coroutine.yield()H2 = false end)
		PuntosProgresivosFunction(SegundosTime)
		while wait() do
			local CondadorDeP = Players:GetPlayers()
			Estatus.Value = "Waiting for more players to start the game"..PuntosValue
			if #CondadorDeP >= MinimoDeJugadores.Value  then
				PuntosProgresivosFunction()
				break
			end
		end
	end
end
function TeletransportarJugadores()
	table.foreach(Players:GetPlayers(),function(count,Player)
		task.spawn(function()
			local character = Player.Character
			if not character then return end
			local EnPartidaLocal = Player:FindFirstChild("EnPartida",true)
			local EnLobby = Player:FindFirstChild("EnLobby",true)
			local LocalHumanoidRoot = character:FindFirstChild("HumanoidRootPart")
			local Vida = character:FindFirstChildOfClass("Humanoid")
			if not Vida then return end
			if EnPartidaLocal and Vida.Health > 0 then
				local PNS = PosicionesDeJugadores:GetChildren()[count].CFrame * CFrame.new(0,8,0)
				character:SetPrimaryPartCFrame(PNS)
				EnLobby.Value = false	
				EnPartidaLocal.Value = true
				local _,_=pcall(function()ReFuncionDeTeletransportarJugador:InvokeClient(Player,PNS)end)
			
			end	

		end)
	end)
	EnPartida.Value = true
end
function GenerarIslas()
	local BloquesDeRondaLocal = BloquesDeRonda:GetChildren()
	if EnPartida.Value == false then
		local IslaSup = IslaLocal:GetChildren()[1]
		if IslaSup then
			IslaSup:Destroy()
		end
		local PosicionDePivotear = PosicionesDeJugadores:GetAttribute("PivotPosition")
		table.foreach(BloquesDeRondaLocal,function(_,Bloque)
			Bloque:Destroy()
		end)
		local NumeroRandom = math.random(1,#islas)
		islas[NumeroRandom]:Clone().Parent = IslaLocal
		local IslaNueva = IslaLocal:GetChildren()[1]
		for _,Bloque in pairs(IslaNueva:GetChildren()) do
			if Bloque:IsA("BasePart") then
				local colorH,ColorS,colorV =Bloque.Color:ToHSV()
				local NumeroRandom = (math.random(-70,0))/1000
				Bloque.Color = Color3.fromHSV(colorH,ColorS  ,colorV+ NumeroRandom)

			end
		end
		IslaNueva:PivotTo(CFrame.new(PosicionDePivotear) * CFrame.new(6,2.5,0))	
	else
		local IslaSup = IslaLocal:GetChildren()[1]if IslaSup then IslaSup:Destroy()end
		table.foreach(BloquesDeRondaLocal,function(_,Bloque)Bloque:Destroy()end)
	end
end
function MatarJugadores()
	PuedeAbrirJugRest = false
	CamaraSePuedeReplicated.Value = false
	table.foreach(Players:GetPlayers(),function(_,Player)
		local EnPartidaLocal = Player:FindFirstChild("EnPartida",true)
		if EnPartidaLocal.Value == true then
			local Character = Player.Character
			if not Character then return end
			local Humanoid = Character:FindFirstChildOfClass("Humanoid")
			if not Humanoid then return end
			Humanoid.Health = 0
		end
		EnPartidaLocal.Value = false
	end)
	EnPartida.Value = false
end
function DarArmas()
	CamaraSePuedeReplicated.Value = true
	table.foreach(Players:GetPlayers(),function(_,Player)
		local NumeroDeBloquesLocal = Player:FindFirstChild("NumberBlocks",true)
		local LocalToolValues = Player:FindFirstChild("ToolValues",true)
		local EnPartidaLocal = Player:FindFirstChild("EnPartida",true)
		if not  NumeroDeBloquesLocal and not LocalToolValues and not EnPartidaLocal then return end
		NumeroDeBloquesLocal.Value = NumeroDeBloques.Value
		local Character = Player.Character
		if not Character then return end
		local HumanoidRoot = Character:FindFirstChild("HumanoidRootPart")
		if not HumanoidRoot then return end
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		if not Humanoid then return end
		if EnPartidaLocal.Value == false then return end
		table.foreach(LocalToolValues:GetChildren(),function(NumeroDeArma,Tool)
			local Mochila = Player.Backpack
			if not Mochila then return end
			local ToolName = Tool.Name
			local ToolsEnStorage = ArmasStorage:FindFirstChild(ToolName)
			if not ToolsEnStorage then return end
			local ListaDeTools = ToolsEnStorage:GetChildren()
			if ToolName == "Potions" then
				table.foreach(Tool:GetChildren(),function(NumeroDeTool,Potenciador)
					table.foreach(ListaDeTools,function(_,CalidadTool)
						if CalidadTool.Name == Potenciador.Name then	
							local Clonacion = CalidadTool:Clone()
							local Configuracion = Clonacion:FindFirstChildOfClass("Configuration")
							if Configuracion then
								Configuracion.LayoutOrder.Value = 4 + NumeroDeTool
							end 
							Clonacion.Name = CalidadTool.Name
							Clonacion.Parent = Mochila
						end
					end)				
				end)
			else
				if Tool.Name == "Armor" then
					table.foreach(ListaDeTools,function(_,CalidadTool)
						if CalidadTool.Name == Tool.Value then	
							local ValorDeTool = MagnitudesArmor:FindFirstChild(CalidadTool.Name)
							if not ValorDeTool then return end
							Humanoid.MaxHealth = 100 + ValorDeTool.Value
							Humanoid.Health = 100 + ValorDeTool.Value
							local AyudaNoEntiendoEsto = CFrame.new(Vector3.new(0,1,0)) 
							local ClonacionDeToolN = CalidadTool:Clone() 
							local Brazo1 = Character:FindFirstChild("Left Arm")
							local Brazo2 = Character:FindFirstChild("Right Arm")
							ClonacionDeToolN:PivotTo(HumanoidRoot.CFrame)
							ClonacionDeToolN.Left:PivotTo(Brazo1.CFrame * AyudaNoEntiendoEsto)
							ClonacionDeToolN.Right:PivotTo(Brazo2.CFrame * AyudaNoEntiendoEsto)  
							ClonacionDeToolN.Name = CalidadTool.Name.."Armor"
							ClonacionDeToolN.Parent = Character				
							ClonacionDeToolN.Delantera.ParteHum.Part1 = HumanoidRoot
							ClonacionDeToolN.Trasera.ParteHum.Part1 = HumanoidRoot
							ClonacionDeToolN.Left.ParteHum.Part1 = Brazo1
							ClonacionDeToolN.Right.ParteHum.Part1 = Brazo2
							
						end 
					end)
				else
					table.foreach(ListaDeTools,function(_,CalidadTool)
						if CalidadTool.Name == Tool.Value then	
							local Clonacion = CalidadTool:Clone()
							local Configuracion = Clonacion:FindFirstChildOfClass("Configuration")
							if Configuracion then
								Configuracion.LayoutOrder.Value = NumeroDeArma
							end 
							Clonacion.Name = ToolName
							Clonacion.Parent = Mochila
						end
					end)
				end
			end
		end)
	end)
end
function ConteoDeJugadores()
	local A = 0
	table.foreach(Players:GetPlayers(),function(_,Player)
		local EnPartidaLocal = Player:FindFirstChild("EnPartida",true)
		if not EnPartidaLocal then return end
		if EnPartidaLocal.Value == false then return end
		A = A + 1
	end)
	NumeroDeJugadoresEnRonda.Value = A
	return A	
end
function Ronda()
	local LocalTiempoDeRondaActual = TiempoDeRonda.Value
	for i = LocalTiempoDeRondaActual,0,-1 do
		CombertirUnidades(i,Estatus)
		if ConteoDeJugadores() < MinimoDeJugadores.Value then
			break
		end
		wait(SegundosTime.Value)
	end
end
function Intermicion()
	local TiempoDeIntermicionActual = TiempoDeIntermicion.Value
	for i = TiempoDeIntermicionActual,0,-1 do
		Estatus.Value = "The next round starts in "..i.." seconds"
		wait(SegundosTime.Value)
	end
end
function AdornarRonda()
	local TiempoDeEsperaActual = TiempoDeEspera.Value
	for count =  TiempoDeEsperaActual,0,-1 do
		if count == 0 then
			Estatus.Value = "START!"

		else
			Estatus.Value = count
		end
		
		wait(SegundosTime.Value)
	end
	
	table.foreach(Players:GetPlayers(),function(_,Player)
		task.spawn(function()
			local Chracter = Player.Character
			if not Chracter then return end
			table.foreach(Chracter:GetDescendants(),function(_,p)
				if p:IsA("BasePart") then
					p.Anchored = false
				end

			end)
		end)
	end)
	PuedeAbrirJugRest = true
end
function EsperaParaCrearF()
	local PuntosValue = "."
	local ValueDeBreack = false
	local PuntosProgresivos = coroutine.wrap(function(H1)
		local H2 = true
		task.spawn(function()
			while wait() do
				if H2 == true then
					local Variable2 = "."
					PuntosValue = "."
					wait(H1.Value/3)
					PuntosValue = ".."
					wait(H1.Value/3)
					PuntosValue = "..."
					wait(H1.Value/3)
				else
					break
				end
			end
		end)
		coroutine.yield()
		H2 = false
	end)
	PuntosProgresivos(SegundosTime)
	local EsperaParaCrearActual = EsperaParaCrear.Value
	for i = EsperaParaCrearActual,0,-1 do
		task.spawn(function()
			while wait() do
				if ValueDeBreack == true then
					break
				end
				Estatus.Value =  "Starting round"..PuntosValue
			end
		end)
		wait(SegundosTime.Value)
	end
	PuntosProgresivos()
	ValueDeBreack = true
	
	local EsperaDeCargaActual = EsperaDeCarga.Value
	for o = EsperaDeCargaActual,0,-1 do
		Estatus.Value = " "
		wait(SegundosTime.Value)
	end
	table.foreach(Players:GetPlayers(),function(_,Player)
		task.spawn(function()
			local Chracter = Player.Character
			if not Chracter then return end
			local HumanoidRootPart = Chracter:FindFirstChild("HumanoidRootPart")
			if not HumanoidRootPart then return end
			table.foreach(Chracter:GetDescendants(),function(_,p)
				if p:IsA("BasePart") then
					p.Anchored = true
				end

			end)
		end)
	end)
end
function DeclararGanador()
	local JugadoresQueGanaron = {}
	table.foreach(Players:GetPlayers(),function(_,Player)
		local EnPartidaLocal = Player:FindFirstChild("EnPartida",true)
		if not EnPartidaLocal then return end
		if EnPartidaLocal.Value == false then return end
		table.insert(JugadoresQueGanaron,Player)	
	end)
	if #JugadoresQueGanaron > 1 then
		Estatus.Value =  MonedasGanadores.Value.." coins awarded to each player"
		table.foreach(JugadoresQueGanaron,function(_,Jugador)
			local LeaderstatsLocal = Jugador:FindFirstChild("leaderstats")
			local Monedas = LeaderstatsLocal:FindFirstChild("Coins")
			if not Monedas then return end
			Monedas.Value = Monedas.Value + MonedasGanadores.Value
		end)
	elseif #JugadoresQueGanaron == 1 then
		Estatus.Value = JugadoresQueGanaron[1].DisplayName.." won the game! + "..MonedasGanador.Value.." Coins"
		local LeaderstatsLocal = JugadoresQueGanaron[1]:FindFirstChild("leaderstats")
		if not LeaderstatsLocal then return end
		local Wins = LeaderstatsLocal:FindFirstChild("Wins")
		local Monedas = LeaderstatsLocal:FindFirstChild("Coins")
		if not Wins or not Monedas then return end
		Wins.Value = Wins.Value + VictoriasGanador.Value
		if Wins.Value == 1 or Wins.Value == 10 or Wins.Value == 100 or Wins.Value == 1000 or Wins.Value == 10000 or Wins.Value == 500  then
			local a,b = pcall(function()
				local Agregacion = ValoresDeRondaStorage:FindFirstChild(Wins.Value.."Win")
				if Agregacion then
					Monedas.Value = Monedas.Value + Agregacion.Value
				end

				AnunciarFrame.AnuncioGeneral(JugadoresQueGanaron[1],"reached",Wins.Value," Wins! ".."+ "..Agregacion.Value.." Coins")

			end)
			if b then
				print(b)
			end
		end
		Monedas.Value = Monedas.Value + MonedasGanador.Value
	elseif #JugadoresQueGanaron <1 then
		Estatus.Value = "No one has won the game"
	end
	wait(game.Players.RespawnTime + 3)
end
task.spawn(function()
	while true do
		ChecarJugadores()
		GenerarIslas()
		EsperaParaCrearF()
		TeletransportarJugadores()
		AdornarRonda()
		DarArmas()
		Ronda()
		DeclararGanador()
		GenerarIslas()
		MatarJugadores()
		Intermicion()
	end
end)
task.spawn(function()
	Estatus.Changed:Connect(function()
		table.foreach(Players:GetPlayers(),function(_,Player)	
			local TextoDeJugadoresRestantes = Player.PlayerGui:FindFirstChild("JugadoresRestantes", true)
			local LocalEstatusGeneral = Player.PlayerGui:FindFirstChild("EstatusGeneral", true)
			if not TextoDeJugadoresRestantes or not LocalEstatusGeneral then return end;
			LocalEstatusGeneral.Text = Estatus.Value
			if PuedeAbrirJugRest  then
				TextoDeJugadoresRestantes.Visible = true
			else
				TextoDeJugadoresRestantes.Visible = false
			end
		end)
	end)
	NumeroDeJugadoresEnRonda.Changed:Connect(function()
		table.foreach(Players:GetPlayers(),function(_,Player)
			local TextoDeJugadoresRestantes = Player.PlayerGui:FindFirstChild("JugadoresRestantes",true)			
			if not TextoDeJugadoresRestantes  then return end
			TextoDeJugadoresRestantes.Text = "Remaining players = "..NumeroDeJugadoresEnRonda.Value
		end)
	end)
end)


--//Code//--
SegundosTimeReplicated.Value = SegundosTime.Value
SegundosTime.Changed:Connect(function()
	SegundosTimeReplicated.Value = SegundosTime.Value
end)
