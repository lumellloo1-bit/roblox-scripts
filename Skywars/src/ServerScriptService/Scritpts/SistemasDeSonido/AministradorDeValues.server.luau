--//services//--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")


--//InstancesReplicated//--
local SistemasDeSonidoReplicatedStorage = ReplicatedStorage:WaitForChild("SistemasDeSonido")


--//Instances//--
local FolderDeValoresSkippear = SistemasDeSonidoReplicatedStorage:WaitForChild("Skipear")


Players.PlayerAdded:Connect(function(Player)
	local ID = Player.UserId
	local Values = Instance.new("BoolValue",FolderDeValoresSkippear)
	Values.Name = ID
	Values.Value = false
end)

Players.PlayerRemoving:Connect(function(Player)
	local ID = Player.UserId
	local ValorBuscado = FolderDeValoresSkippear:FindFirstChild(ID)
	if ValorBuscado then
		ValorBuscado:Destroy()
	end
end)
