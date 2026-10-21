--//Services//--
local InsertService = game:GetService("InsertService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")


--//Instances//--
local SistemasDeSonidoReplicated = ReplicatedStorage:WaitForChild("SistemasDeSonido")
local RemoteEvents = SistemasDeSonidoReplicated:WaitForChild("Remotes")
local RemoteVerificadorDeAudios = RemoteEvents:WaitForChild("VerificacionDeAudos")

--//Functions//--

RemoteVerificadorDeAudios.OnServerEvent:Connect(function(Player,ID)
	local ok,Error = pcall(function()
		local Verificacion = InsertService:LoadAsset(ID)
	end)
	if ok then
		RemoteVerificadorDeAudios:FireClient(Player,true)
	else
		RemoteVerificadorDeAudios:FireClient(Player,false)
	end
end)
