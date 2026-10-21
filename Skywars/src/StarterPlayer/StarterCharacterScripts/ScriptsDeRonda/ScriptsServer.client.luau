--//Services//--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")

--//Instances//--
local RondaSoundService = SoundService:WaitForChild("Ronda")
local efectosDeSOnidoSoundService = RondaSoundService:WaitForChild("SonidosDeRonda")
local StartSound = efectosDeSOnidoSoundService:WaitForChild("StartSound")


local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local RemoteFunctions = RemoteEvents:WaitForChild("Functions")
local FuncionDeTeletransportarJugadores = RemoteFunctions:WaitForChild("TeletrasnportarJugador")


FuncionDeTeletransportarJugadores.OnClientInvoke = function(PosicionDeseada)
	local Character = script.Parent.Parent
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	if Humanoid  then
		StartSound:Play()
		Character:SetPrimaryPartCFrame(PosicionDeseada)		
	end
end
