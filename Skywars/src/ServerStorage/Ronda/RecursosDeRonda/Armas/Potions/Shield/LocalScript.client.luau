local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local JugadoresConEscudo = ReplicatedStorage:WaitForChild("Valores"):WaitForChild("ValoresPotenciadores"):WaitForChild("ValoresEscudo"):WaitForChild("Jugadores")
local RemoteEventQuitar = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RemotesPotenciadores"):WaitForChild("RemoteQuitarEscudo")

local RemoteEvent = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RemotesPotenciadores"):WaitForChild("RemoteEscudo")
local Poner = script:WaitForChild("Poner")
local Quitar = script:WaitForChild("Quitar")
local Mantener = script:WaitForChild("Mantener")
local Tool = script.Parent
Tool.Equipped:Wait()
local Player = Players.LocalPlayer
local Character = Player.Character
local Humanoid = Character:WaitForChild("Humanoid")
local PonT = Humanoid:LoadAnimation(Poner)
local QuiT = Humanoid:LoadAnimation(Quitar)
local MantenerT = Humanoid:LoadAnimation(Mantener)
local Handle = Tool:WaitForChild("Handle")
MantenerT.Priority = Enum.AnimationPriority.Action
QuiT.Priority = Enum.AnimationPriority.Action
PonT.Priority = Enum.AnimationPriority.Action
Tool.Activated:Connect(function()
	RemoteEvent:FireServer()
end)

JugadoresConEscudo.ChildAdded:Connect(function(Chil)
	local Name = Chil.Name
	if Name == Player.Name then
		PonT:Play()
		PonT.Stopped:Wait()
		MantenerT:Play()
		Handle.Transparency = 0.7
	end
	if Name == "Reloading"..Player.Name then
		Handle.Transparency = 0

		MantenerT:Stop()
		PonT:Stop()
		QuiT:Play()
	end
end)

Tool.Unequipped:Connect(function()
	Handle.Transparency = 0

	PonT:Stop()
	QuiT:Stop()
	MantenerT:Stop()
	RemoteEventQuitar:FireServer()
end)
