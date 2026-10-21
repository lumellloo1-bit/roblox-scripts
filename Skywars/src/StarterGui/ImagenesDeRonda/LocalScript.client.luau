--//Servicios//--
local Players = game:GetService("Players")
local ReplictadesStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

--//Instances//--
local Player = Players.LocalPlayer
local Leaderstats = Player:WaitForChild("leaderstats")
local Conis = Leaderstats:WaitForChild("Coins")
local ValoresDeRonda = Player:WaitForChild("ValoresDeRonda")
local EnPardia = ValoresDeRonda:WaitForChild("EnPartida")
local ImagenesDeRonda = script.Parent
local RemoteEvents = ReplictadesStorage:WaitForChild("RemoteEvents")
local RemoteFunctions = RemoteEvents:WaitForChild("Functions")
local ValuesReplicated = ReplictadesStorage:WaitForChild("Valores")
local ValuesGameReplicated = ValuesReplicated:WaitForChild("ValoresGame")
local SegundosTimeReplicated = ValuesGameReplicated:WaitForChild("SegundosTimeValue")
local AnunciosKillLader = ImagenesDeRonda:WaitForChild("AnunciosKillLeader")
local ScrollingKillLader = AnunciosKillLader:WaitForChild("ScrollingKillLeader")
--//Modificable//--
local VidaDelJugadorgui = ImagenesDeRonda:WaitForChild("VidaDelJugador")
local TextoVida = VidaDelJugadorgui:WaitForChild("PorcentajeDeVidaDelJugador")
local MonedasGui = ImagenesDeRonda:WaitForChild("MonedasDelJugaor")
local TextMonedasGui = MonedasGui:WaitForChild("NumeroDeMonedas")
local ArmarduraDelJugador = ImagenesDeRonda:WaitForChild("Folder")
local ImageArmaduraDelJugador = ArmarduraDelJugador:WaitForChild("ArmaduraDelJugador")
local Gradiente = ImageArmaduraDelJugador:WaitForChild("Gradiente")
local GradienteUI = Gradiente:WaitForChild("UIGradient")
local PorcentajeDeAmradura = ImageArmaduraDelJugador:WaitForChild("PorcentajeDeArmaduraDeJugador")
--//TweenInstances//--
local InfoQuitarAnuncios = TweenInfo.new(4,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0)
local TiempoDeTween = 0.1
local TamaInicialCorazonGui = VidaDelJugadorgui.Size
local TamaInicialCoinsGui = MonedasGui.Size
--//fuinciones//--

local function TweenOut(CualquierGui,GrandeX,GrandeY)
	CualquierGui:TweenSize(UDim2.fromScale(GrandeX,GrandeY),Enum.EasingDirection.Out,Enum.EasingStyle.Linear,TiempoDeTween)
end
local function TweenIn(CualquierGui,GrandeX,GrandeY)
	CualquierGui:TweenSize(UDim2.fromScale(GrandeX,GrandeY),Enum.EasingDirection.In,Enum.EasingStyle.Linear,TiempoDeTween)
end
local function CalcularVidaYc(Hum)
	local MaxHealth = Hum.MaxHealth
	local Health = Hum.Health	
	if MaxHealth > 100 then
		ImageArmaduraDelJugador.Visible = true
		local cienArmor = MaxHealth - 100
		local ArmorQueTiene = Health - 100
		local Porcentaje = (ArmorQueTiene * 100)/cienArmor
		if Porcentaje < 0 then
			Porcentaje = 0
			ImageArmaduraDelJugador.Visible = false
		else
			ImageArmaduraDelJugador.Visible = true

		end
		local NumeroDeOffset = 1 - (Porcentaje * .01)
		GradienteUI.Offset = Vector2.new(0,NumeroDeOffset)
		ImageArmaduraDelJugador.ImageColor3 = Color3.fromHSV(0,NumeroDeOffset, 1)
		local textoAPoner = math.floor(Porcentaje)
		PorcentajeDeAmradura.Text = textoAPoner.."%"
	else
		ImageArmaduraDelJugador.Visible = false
	end
	if Health > 100 then
		Health = 100
	end
	local Porcentaje = (Health * 100)/100
	local NumeroPuesto = math.floor(Porcentaje)
	TextoVida.Text = NumeroPuesto.."%"
	VidaDelJugadorgui.ImageColor3 = Color3.fromRGB(Porcentaje * (255/100),Porcentaje * (255/100),Porcentaje * (255/100))
	TextoVida.TextColor3 = Color3.fromRGB(255,Porcentaje*(255/100),Porcentaje*(255/100))
end

local character = Player.Character 
if character then
	local Huma = character:WaitForChild("Humanoid")
	
	CalcularVidaYc(Huma)
	Huma:GetPropertyChangedSignal("Health"):Connect(function()
		if Huma.Health < 100 then
			local TamaScaleXMax = (TamaInicialCorazonGui.X.Scale/5) + TamaInicialCorazonGui.X.Scale
			local TamaScaleYMax = (TamaInicialCorazonGui.Y.Scale/5) + TamaInicialCorazonGui.Y.Scale
			TweenOut(VidaDelJugadorgui,TamaScaleXMax,TamaScaleYMax)
			delay(TiempoDeTween,function()
				TweenIn(VidaDelJugadorgui,TamaInicialCorazonGui.X.Scale,TamaInicialCorazonGui.Y.Scale)
			end)
		end
		CalcularVidaYc(Huma)

	end)
	Huma:GetPropertyChangedSignal("MaxHealth"):Connect(function()
		if Huma.Health < 100 then
			local TamaScaleXMax = (TamaInicialCorazonGui.X.Scale/5) + TamaInicialCorazonGui.X.Scale
			local TamaScaleYMax = (TamaInicialCorazonGui.Y.Scale/5) + TamaInicialCorazonGui.Y.Scale
			TweenOut(VidaDelJugadorgui,TamaScaleXMax,TamaScaleYMax)
			delay(TiempoDeTween,function()
				TweenIn(VidaDelJugadorgui,TamaInicialCorazonGui.X.Scale,TamaInicialCorazonGui.Y.Scale)
			end)
		end
		CalcularVidaYc(Huma)
	end)
end

Player.CharacterAdded:Connect(function(Char)
	local Huma = Char:WaitForChild("Humanoid")
	CalcularVidaYc(Huma)
	Huma:GetPropertyChangedSignal("Health"):Connect(function()
		if Huma.Health < 100 then
			local TamaScaleXMax = (TamaInicialCorazonGui.X.Scale/5) + TamaInicialCorazonGui.X.Scale
			local TamaScaleYMax = (TamaInicialCorazonGui.Y.Scale/5) + TamaInicialCorazonGui.Y.Scale
			TweenOut(VidaDelJugadorgui,TamaScaleXMax,TamaScaleYMax)
			delay(TiempoDeTween,function()
				TweenIn(VidaDelJugadorgui,TamaInicialCorazonGui.X.Scale,TamaInicialCorazonGui.Y.Scale)
			end)
		end
		CalcularVidaYc(Huma)
	end)
	Huma:GetPropertyChangedSignal("MaxHealth"):Connect(function()
		if Huma.Health < 100 then
			local TamaScaleXMax = (TamaInicialCorazonGui.X.Scale/5) + TamaInicialCorazonGui.X.Scale
			local TamaScaleYMax = (TamaInicialCorazonGui.Y.Scale/5) + TamaInicialCorazonGui.Y.Scale
			TweenOut(VidaDelJugadorgui,TamaScaleXMax,TamaScaleYMax)
			delay(TiempoDeTween,function()
				TweenIn(VidaDelJugadorgui,TamaInicialCorazonGui.X.Scale,TamaInicialCorazonGui.Y.Scale)
			end)
		end
		CalcularVidaYc(Huma)
	end)

end)

Conis:GetPropertyChangedSignal("Value"):Connect(function()
	local TamaScaleXMax = (TamaInicialCoinsGui.X.Scale/5) + TamaInicialCoinsGui.X.Scale
	local TamaScaleYMax = (TamaInicialCoinsGui.Y.Scale/5) + TamaInicialCoinsGui.Y.Scale
	TweenOut(MonedasGui,TamaScaleXMax,TamaScaleYMax)
	delay(TiempoDeTween,function()
		TweenIn(MonedasGui,TamaInicialCoinsGui.X.Scale,TamaInicialCoinsGui.Y.Scale)
	end)
	local Monedas = Conis.Value
	TextMonedasGui.Text = Monedas
end)

EnPardia.Changed:Connect(function(Cambio)
	if Cambio == true then
		VidaDelJugadorgui.Visible = true
		TextoVida.Text = "99%"
		wait(0.01)
		TextoVida.Text = "100%"
	else
		VidaDelJugadorgui.Visible = false
		ImageArmaduraDelJugador.Visible = false
	end
end)

ScrollingKillLader.ChildAdded:Connect(function(Clonacion)
	table.foreach(Clonacion:GetDescendants(),function(_,ChildTweened)
		if ChildTweened:IsA("TextLabel") then
			local Track = TweenService:Create(ChildTweened,InfoQuitarAnuncios,{TextTransparency = 1,TextStrokeTransparency = 1})
			delay(1,function()
				Track:Play()
			end)
		end
	end)
end)
--//Codigo//--
local Monedas = Conis.Value
TextMonedasGui.Text = Monedas
