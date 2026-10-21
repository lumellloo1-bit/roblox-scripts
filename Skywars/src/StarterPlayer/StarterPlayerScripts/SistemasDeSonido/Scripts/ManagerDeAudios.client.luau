--//Services//--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
--//InstancesSonido//--
local SistemasSonidoReplicated = ReplicatedStorage:WaitForChild("SistemasDeSonido")
local SistemasSonidoSoundService = SoundService:WaitForChild("SistemasDeSonido")
--//Instances//--
local GrupoDeSonido = SistemasSonidoSoundService:WaitForChild("SonidoConcierto")
local Sounido = GrupoDeSonido:WaitForChild("SonidoPedido")
local Remotes = SistemasSonidoReplicated:WaitForChild("Remotes")
local RemoteDeCambiarCancion = Remotes:WaitForChild("CambiarCancion")

RemoteDeCambiarCancion.OnClientEvent:Connect(function(ID)
	Sounido.TimePosition = 0
	Sounido.SoundId = ID
	Sounido:Play()
end)
