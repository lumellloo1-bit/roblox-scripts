--Servicios--
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--Local Instances --
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
--LocalGuiInstances--
local Screen = Player.PlayerGui:WaitForChild("SistemaDeSpectear")
local BotonDerecha = Screen:WaitForChild("Derecha")
local BotonIzquierda = Screen:WaitForChild("Izquierda")
local BotonCamara = Screen:WaitForChild("SpectMode")
--Instances--
local Camera = workspace:WaitForChild("Camera")
local ValoresDeCamara = ReplicatedStorage:WaitForChild("Valores"):WaitForChild("ValoresDeCamara")
--Values--
local EnPartida = Player:WaitForChild("ValoresDeRonda"):WaitForChild("EnPartida")
local EnLobby = Player:WaitForChild("ValoresDeRonda"):WaitForChild("EnLobby")
local SePuedeValue = ValoresDeCamara:WaitForChild("SePuedeJugadores")
local JugadoresEnPartida = ValoresDeCamara:WaitForChild("JugadoresEnPartida")

--ValoresBindables--
local Presionado = false
local CDPC = 0
--Tablas--
local ListaDeJugadoresEnPartida = {}
--Funciones--
for i,v in pairs(JugadoresEnPartida:GetChildren()) do
	table.insert(ListaDeJugadoresEnPartida,v)
end
Humanoid.Died:Connect(function()
	Player.CharacterAdded:Connect(function(CharacterAgregado)
		Humanoid = CharacterAgregado:WaitForChild("Humanoid")
	end)
end)
JugadoresEnPartida.ChildRemoved:Connect(function(Child)
	for i,v in pairs(ListaDeJugadoresEnPartida) do
		if v.Name == Child.Name then
			table.remove(ListaDeJugadoresEnPartida,i)
		end
	end
end)
JugadoresEnPartida.ChildAdded:Connect(function(Child)
	table.insert(ListaDeJugadoresEnPartida,Child)
end)
if EnPartida.Value == false and EnLobby.Value == true and SePuedeValue.Value == true then
	BotonCamara.Visible = true
end
EnLobby.Changed:Connect(function(Cambio)
	if Cambio == true then
		if EnPartida.Value == false and SePuedeValue.Value == true then
			BotonCamara.Visible = true
		end
	else
		Camera.CameraType = Enum.CameraType.Custom
		Camera.CameraSubject = Humanoid
		Presionado = false
		BotonCamara.Visible = false
		BotonDerecha.Visible = false
		BotonIzquierda.Visible = false
	end
end)
SePuedeValue.Changed:Connect(function(Cambio)
	if Cambio == true then
		if EnPartida.Value == false and EnLobby.Value == true  then
			BotonCamara.Visible = true
		end
	else
		Camera.CameraType = Enum.CameraType.Custom
		Camera.CameraSubject = Humanoid
		Presionado = false
		BotonCamara.Visible = false
		BotonDerecha.Visible = false
		BotonIzquierda.Visible = false
	end
end)
BotonCamara.MouseButton1Up:Connect(function()
	if Presionado == false then
		Presionado = true
		BotonDerecha.Visible = true
		BotonIzquierda.Visible = true
		CDPC = CDPC + 1
		if CDPC > #ListaDeJugadoresEnPartida then
			CDPC = 1
		end
		local FijacionDeLaCamara 
		local Ok,Error = pcall(function()
			FijacionDeLaCamara= ListaDeJugadoresEnPartida[CDPC].Value
		end)
		if FijacionDeLaCamara then
			Camera.CameraSubject = FijacionDeLaCamara
		end
	else
		Camera.CameraType = Enum.CameraType.Custom
		Camera.CameraSubject = Humanoid
		Presionado = false
		BotonDerecha.Visible = false
		BotonIzquierda.Visible = false
	end
end)

BotonDerecha.MouseButton1Up:Connect(function()
	CDPC = CDPC + 1
	if CDPC > #ListaDeJugadoresEnPartida then
		CDPC = 1
	end
	local FijacionDeLaCamara 
	local Ok,Error = pcall(function()
		FijacionDeLaCamara= ListaDeJugadoresEnPartida[CDPC].Value
	end)
	if FijacionDeLaCamara then
		Camera.CameraSubject = FijacionDeLaCamara
	end
end)
BotonIzquierda.MouseButton1Up:Connect(function()
	CDPC = CDPC - 1
	if CDPC < 1 then
		CDPC = #ListaDeJugadoresEnPartida
	end
	local FijacionDeLaCamara 
	local Ok,Error = pcall(function()
		FijacionDeLaCamara= ListaDeJugadoresEnPartida[CDPC].Value
	end)
	if FijacionDeLaCamara then
		Camera.CameraSubject = FijacionDeLaCamara
	end
end)
