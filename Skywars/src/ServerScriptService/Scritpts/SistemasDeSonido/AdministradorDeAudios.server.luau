--//Services//--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
--//InstancesSonido//--
local SistemasSonidoReplicated = ReplicatedStorage:WaitForChild("SistemasDeSonido")
local SistemasSonidoSoundService = SoundService:WaitForChild("SistemasDeSonido")
--//Instances//--
local GrupoDeSonido = SistemasSonidoSoundService:WaitForChild("SonidoConcierto")
local Sonido = GrupoDeSonido:WaitForChild("SonidoPedido")
local Remotes = SistemasSonidoReplicated:WaitForChild("Remotes")
local RemoteDeCambiarCancion = Remotes:WaitForChild("CambiarCancion")
local SonidosPredeterminados = SistemasSonidoReplicated:WaitForChild("SonidosPredeterminados")
local SonidosEnFila = SistemasSonidoReplicated:WaitForChild("SonidosEnFila")
local FolderDeValoresSkipear = SistemasSonidoReplicated:WaitForChild("Skipear")


local ContadorDeSonidosENFIla = 0


local RemoteSkipear = Remotes:WaitForChild("Skipear")

local function CambiarDeCancion()
	local SonidoQueSigue 
	local SonidoPedido = false
	if #SonidosEnFila:GetChildren() > 0 then
		SonidoQueSigue = SonidosEnFila:GetChildren()[1]
		SonidoPedido = true
	else
		ContadorDeSonidosENFIla = ContadorDeSonidosENFIla + 1
		if ContadorDeSonidosENFIla > #SonidosPredeterminados:GetChildren() then
			ContadorDeSonidosENFIla = 1
		end
		SonidoQueSigue = SonidosPredeterminados:GetChildren()[ContadorDeSonidosENFIla]
	end
	local SonidoProximo = SonidoQueSigue:WaitForChild("Sound")
	

	local ID = SonidoProximo.SoundId
	Sonido:Stop()
	Sonido.TimePosition = 0
	Sonido.SoundId = ""
	RemoteDeCambiarCancion:FireAllClients(ID)
	Sonido.SoundId = ID
	Sonido:Play()
	if SonidoPedido == true then
		SonidosEnFila:GetChildren()[1]:Destroy()
	end
end
local function CalcularSkip()
	local NumeroDePersonasTotales = #FolderDeValoresSkipear:GetChildren()
	local NumeroDePersonasSkip = 0
	for i,v in pairs(FolderDeValoresSkipear:GetChildren()) do
		if v.Value == true then
			NumeroDePersonasSkip = NumeroDePersonasSkip + 1
		end
	end
	local Cincuenta = NumeroDePersonasTotales/2
	if NumeroDePersonasSkip > Cincuenta then
		CambiarDeCancion()
		for i,v in pairs(FolderDeValoresSkipear:GetChildren()) do
			v.Value = false
		end
	end
end

CambiarDeCancion()

Sonido.Ended:Connect(function()
	CambiarDeCancion()
end)
FolderDeValoresSkipear.ChildAdded:Connect(function(Child)
	Child.Changed:Connect(function(Cambio)
			CalcularSkip()
	end)
end)
FolderDeValoresSkipear.ChildAdded:Connect(function()
		CalcularSkip()
end)
FolderDeValoresSkipear.ChildRemoved:Connect(function()
	CalcularSkip()
end)

RemoteSkipear.OnServerEvent:Connect(function(Player)
	local ID = Player.UserId
	local Value = FolderDeValoresSkipear:FindFirstChild(ID)
	if Value then
		Value.Value = true
	end
end)
