--//Services//--
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")


--//Instances//--
local SistemasDeSonidoReplicated = ReplicatedStorage:WaitForChild("SistemasDeSonido")
local Remotes = SistemasDeSonidoReplicated:WaitForChild("Remotes")
local EnviarAudioAserver = Remotes:WaitForChild("EnviaAudioAServer")
local AudiosEnFila = SistemasDeSonidoReplicated:WaitForChild("SonidosEnFila")





EnviarAudioAserver.OnServerEvent:Connect(function(Player,ID)
	local FolderDeGuardado = Instance.new("Folder")
	FolderDeGuardado.Name = "Sonido"
	local SonidoDeGuardado = Instance.new("Sound",FolderDeGuardado)
	SonidoDeGuardado.SoundId = "rbxassetid://"..ID
	
	

	FolderDeGuardado.Parent = AudiosEnFila
	
end)
