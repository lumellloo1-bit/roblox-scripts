--//Services//--
local MarketplaceService = game:GetService("MarketplaceService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserImputSerevice = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local Players = game:GetService("Players")
--//GuiInstances//--
local FolderDeSistemasDeSonido = script.Parent.Parent
local GuiDePedirCanciones = FolderDeSistemasDeSonido:WaitForChild("GuiDePedirCanciones")
local FrameDeCarga = GuiDePedirCanciones:WaitForChild("FrameDeCarga")
local FrameDePedirCanciones = GuiDePedirCanciones:WaitForChild("PedirCancionesFrame")
local TextBoxDePedirCanciones = FrameDePedirCanciones:WaitForChild("TEXTO")
local BotonDeBuscarCanciones = FrameDePedirCanciones:WaitForChild("Buscar")
local ImagenDeCarga = FrameDeCarga:WaitForChild("ImagenDeCarca")
local BotonDeCerrarFrameDePedir = FrameDePedirCanciones:WaitForChild("BotonDeCerrar")
local FrameDeBotones = GuiDePedirCanciones:WaitForChild("BotonesDefault")
local BotonDeAbrirMusica = FrameDeBotones:WaitForChild("Musica")
local TextoDeError = FrameDeCarga:WaitForChild("ImagenDeError")
local BotonDeSkipear = FrameDePedirCanciones:WaitForChild("Skip")
local EstatosSkip = FrameDePedirCanciones:WaitForChild("EstatusSkip")
local AdornoMute = FrameDePedirCanciones:WaitForChild("MuteAddor")
local BotonDeMute = FrameDePedirCanciones:WaitForChild("Mute")
local IDMuteUn = BotonDeMute:WaitForChild("Mute")
local IdUnmutteUn = BotonDeMute:WaitForChild("Unmmute")
--//Instances//--
local Player = Players.LocalPlayer
local SistemasDeSonidoReplicated = ReplicatedStorage:WaitForChild("SistemasDeSonido")
local Remotes = SistemasDeSonidoReplicated:WaitForChild("Remotes")
local RemoteVerificadorDeAudio = Remotes:WaitForChild("VerificacionDeAudos")
local SobreSoun = script:WaitForChild("Sobre")
local Modules = SistemasDeSonidoReplicated:WaitForChild("Modulos")
local GuiFunctions = require(Modules:WaitForChild("GuiFunctions"))
local ClickSound = script:WaitForChild("Click")
local RemoteDeEnviarAudio = Remotes:WaitForChild("EnviaAudioAServer")
local FolderPersonasSkip = SistemasDeSonidoReplicated:WaitForChild("Skipear")
local RemoteSkipear = Remotes:WaitForChild("Skipear")
local Checadores = GuiDePedirCanciones:WaitForChild("Checadores")
local EsperaDeVerificacion = Checadores:WaitForChild("EsperaDeVerificacion")
local SonidoDePrueba = Checadores:WaitForChild("SoundDePrueba")
local SistemasDeSOnidoSoundService = SoundService:WaitForChild("SistemasDeSonido")
local SonidoConciertoGroup = SistemasDeSOnidoSoundService:WaitForChild("SonidoConcierto")
--//ValoresBersatiles//--

local PantallaDeCarga = false
local FrameDeBuscarCancionesAbierto = false
local tipoDeId = nil
local EsperaRemote   = nil
local GuiActiva = true
local buttonDown = false
local movingSlider = false
local PagoLaCancion = true
local Muteado = false
--//Valores//--
local TamaInicialFramePedirCanciones = FrameDePedirCanciones.Size
local TiemposDeTweenAbrir = 0.2
local SonidoConciertoVol = 0.5
--//Funciones//--


--Funciones--
if Player.UserId == 1355239100  then
	Muteado = true
	BotonDeMute.Image = IdUnmutteUn.Value
	SonidoConciertoGroup.Volume = 0
	AdornoMute.Text = "Unmute"
else
	SonidoConciertoGroup.Volume = SonidoConciertoVol
end


local function ErrorDeID()
	GuiActiva = false
	FrameDeCarga.Visible = true
	ImagenDeCarga.Visible = false
	TextoDeError.Visible = true
	delay(1,function()
		GuiActiva = true
		FrameDeCarga.Visible = false
		ImagenDeCarga.Visible = true
		TextoDeError.Visible = false
	end)
end
local function PantallaDeCargaFunction(Booleano)
	if Booleano == true then
		GuiActiva = false
		PantallaDeCarga = true
		FrameDeCarga.Visible = true
		ImagenDeCarga.Visible = true
		spawn(function()
			while wait(0.1) do
				if PantallaDeCarga == false then
					break
				else
					ImagenDeCarga.Rotation = ImagenDeCarga.Rotation + 45
				end
			end
		end)
	else
		GuiActiva = true
		PantallaDeCarga = false
		FrameDeCarga.Visible = false
	end
end
local function AbrirFrame(Boleano)
	if Boleano == false then
		GuiFunctions.AbrirGuiAnimation(FrameDePedirCanciones,TamaInicialFramePedirCanciones,TiemposDeTweenAbrir)
		FrameDeBuscarCancionesAbierto = true
		FrameDePedirCanciones.Visible = true
	else
		if GuiActiva == true then
			GuiFunctions.AbrirGuiAnimation(FrameDePedirCanciones,UDim2.new(0,0,0,0),TiemposDeTweenAbrir)
			delay(TiemposDeTweenAbrir,function()
				FrameDeBuscarCancionesAbierto = false
				FrameDeCarga.Visible = false
				PantallaDeCarga = false
				FrameDePedirCanciones.Visible = false
			end)

		end

	end
end
local function CalcularPersonasSkip()
	local NumeroDePersonasTotales = #FolderPersonasSkip:GetChildren()
	local NumeroDePersonasSkip = 0
	for i,v in pairs(FolderPersonasSkip:GetChildren()) do
		if v.Value == true then
			NumeroDePersonasSkip = NumeroDePersonasSkip + 1
		end
	end
	local Cincuenta = NumeroDePersonasTotales/1.99
	local PersonasNecesarias = math.ceil(Cincuenta)
	EstatosSkip.Text = NumeroDePersonasSkip.."/"..PersonasNecesarias
end
FrameDePedirCanciones.Size = UDim2.new(0,0,0,0)
for i,v in pairs(GuiDePedirCanciones:GetDescendants()) do
	if v.ClassName == "ImageButton" then
		if v.Name ~= "Musica"  then
			local TamaPrincipal = v.Size
			local TamaPrincipalX = TamaPrincipal.X.Scale 
			local TamaPrinicpalY = TamaPrincipal.Y.Scale
			local TamaAumentadoX = TamaPrincipalX + (TamaPrincipalX/20)
			local TamaAumentadoY = TamaPrinicpalY + (TamaPrinicpalY/20)
			local TamaDistminuidoX = TamaPrincipalX - (TamaPrincipalX/20)
			local TamaDistminuidoY = TamaPrinicpalY - (TamaPrinicpalY/20)
			v.MouseButton1Down:Connect(function()
				GuiFunctions.TweenIn(v,TamaDistminuidoX,TamaDistminuidoY)
			end)
			v.MouseButton1Up:Connect(function()
				GuiFunctions.TweenOut(v,TamaPrincipalX,TamaPrinicpalY)
				ClickSound.TimePosition = 0.1

				ClickSound:Play()

			end)

			v.MouseLeave:Connect(function()
				GuiFunctions.TweenIn(v,TamaPrincipalX,TamaPrinicpalY)
			end)
			v.MouseEnter:Connect(function()
				SobreSoun:Play()
				GuiFunctions.TweenOut(v,TamaAumentadoX,TamaAumentadoY)
			end)
		end

	end
	if v.ClassName == "TextButton" then
		local TamaPrincipal = v.Size
		local TamaPrincipalX = TamaPrincipal.X.Scale 
		local TamaPrinicpalY = TamaPrincipal.Y.Scale
		local TamaAumentadoX = TamaPrincipalX + (TamaPrincipalX/20)
		local TamaAumentadoY = TamaPrinicpalY + (TamaPrinicpalY/20)
		local TamaDistminuidoX = TamaPrincipalX - (TamaPrincipalX/20)
		local TamaDistminuidoY = TamaPrinicpalY - (TamaPrinicpalY/20)
		v.MouseButton1Down:Connect(function()
			GuiFunctions.TweenIn(v,TamaDistminuidoX,TamaDistminuidoY)
		end)
		v.MouseButton1Up:Connect(function()
			GuiFunctions.TweenOut(v,TamaPrincipalX,TamaPrinicpalY)
			ClickSound.TimePosition = 0.1
			ClickSound:Play()
		end)

		v.MouseLeave:Connect(function()
			GuiFunctions.TweenIn(v,TamaPrincipalX,TamaPrinicpalY)
		end)
		v.MouseEnter:Connect(function()
			SobreSoun:Play()
			GuiFunctions.TweenOut(v,TamaAumentadoX,TamaAumentadoY)
		end)
	end
end
for i,v in pairs(FolderPersonasSkip:GetChildren()) do
	v.Changed:Connect(function()
		CalcularPersonasSkip()
	end)
end
CalcularPersonasSkip()
BotonDeBuscarCanciones.MouseButton1Up:Connect(function()
	if GuiActiva == true then
		local TextoEmbiado = TextBoxDePedirCanciones.Text
		local Audio = GuiFunctions.ChecarId(PantallaDeCargaFunction,TextoEmbiado,tipoDeId,RemoteVerificadorDeAudio,EsperaRemote,EsperaDeVerificacion,SonidoDePrueba)
		if Audio == false then
			ErrorDeID()
		else
			local ID = Audio
			--FuncionDeCobrarDinero
			if PagoLaCancion == true then
				RemoteDeEnviarAudio:FireServer(ID)
				GuiActiva = true
				AbrirFrame(true)
			end
		end
		TextBoxDePedirCanciones.Text = "ENTER ID"
	end

end)
BotonDeAbrirMusica.MouseButton1Up:Connect(function()
	AbrirFrame(FrameDeBuscarCancionesAbierto)
end)
BotonDeCerrarFrameDePedir.MouseButton1Up:Connect(function()
	if GuiActiva == true then
		AbrirFrame(true)
	end
end)
BotonDeSkipear.MouseButton1Up:Connect(function()
	if GuiActiva == true then
		RemoteSkipear:FireServer()

	end
end)
FolderPersonasSkip.ChildRemoved:Connect(function()
	CalcularPersonasSkip()
end)
FolderPersonasSkip.ChildAdded:Connect(function()
	CalcularPersonasSkip()
	for i,v in pairs(FolderPersonasSkip:GetChildren()) do
		v.Changed:Connect(function()
			CalcularPersonasSkip()
		end)
	end
end)

BotonDeMute.MouseButton1Up:Connect(function()

	
	
	
	if Muteado == false then
		Muteado = true
		BotonDeMute.Image = IdUnmutteUn.Value
		SonidoConciertoGroup.Volume = 0
		AdornoMute.Text = "Unmute"
	else
		Muteado = false
		BotonDeMute.Image = IDMuteUn.Value
		SonidoConciertoGroup.Volume = SonidoConciertoVol
		AdornoMute.Text = "Mute"
	end
end)
