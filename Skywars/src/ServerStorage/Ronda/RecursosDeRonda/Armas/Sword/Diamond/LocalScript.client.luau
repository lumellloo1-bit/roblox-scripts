--Servicios--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

--Intances--
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local RemotesArmas = RemoteEvents:WaitForChild("RemotesArmas")
local RemotesEspada = RemotesArmas:WaitForChild("RemotesEspada")
local DanEspada = RemotesEspada:WaitForChild("DanoEspada")
local Tool = script.Parent
local Animaciones = Tool:WaitForChild("Anims")
local Uno = Animaciones:WaitForChild("EquipAnim5")
local UnequipAnim = Animaciones:WaitForChild("UnequipAnim2")
local EspadaEstatica = Animaciones:WaitForChild("IdleAnim3")
local ArribaDeCabezaGolpe = Animaciones:WaitForChild("OverheadAnim2")
local Slash = Animaciones:WaitForChild("SlashAnim2")
local Trist = Animaciones:WaitForChild("ThrustAnim2")
local StorageServer = ReplicatedStorage:WaitForChild("Storage")
local Icons = StorageServer:WaitForChild("Icons")
local IconoDeMouseUsado = Icons:WaitForChild("Value")
Tool.Equipped:Wait()
local Player = Players.LocalPlayer
local Character = Player.Character
local Humanoid = Character:WaitForChild("Humanoid")
local Animator = Humanoid:WaitForChild("Animator")
local Mouse = Player:GetMouse()
--//Anims//--

local SacarEspada = Animator:LoadAnimation(Uno)
local MeterEspada = Animator:LoadAnimation(UnequipAnim)
local EspadaQuieta = Animator:LoadAnimation(EspadaEstatica)
local GolpeArriba = Animator:LoadAnimation(ArribaDeCabezaGolpe)
local GolpeLateral1 = Animator:LoadAnimation(Slash)
local GolpeLateral2 = Animator:LoadAnimation(Trist)


--Values//--


local ReloadTime = .65

--//inestables//--
local Break = false
local SecuenciaDeGolpesIniciada = false
local SepuedeGOlpe = false
local DelayTime = 0
local HitEnELqUEeS = 1
Tool.Equipped:Connect(function()
	SacarEspada:Play()
	Break = false
	while wait(.1) do
		if Break == true then
			break
		end
		DelayTime = DelayTime - .05
		if DelayTime < 0  then
			DelayTime = 0
		end
	end

end)

Tool.Activated:Connect(function()
	DanEspada:FireServer()
end)
Tool.Unequipped:Connect(function()
	Break = true 
	SacarEspada:Stop()
	MeterEspada:Stop()
	EspadaQuieta:Stop()
	GolpeArriba:Stop()
	GolpeLateral1:Stop()
	GolpeLateral2:Stop()
end)
Mouse.Button1Down:Connect(function()
	DelayTime = DelayTime + .2
	if DelayTime > 0.5 then
		DelayTime = 0.5
	end
end)


DanEspada.OnClientEvent:Connect(function()
	if SecuenciaDeGolpesIniciada == false then
		SecuenciaDeGolpesIniciada = true
		local speed= GolpeLateral1.Length/ReloadTime
		GolpeLateral1:Play(0,1,speed)
		wait(ReloadTime)
		if DelayTime > 0  then
			local speed1= GolpeLateral2.Length/ReloadTime
			GolpeLateral2:Play(0,1,speed1)
			wait(ReloadTime)
			if DelayTime > 0 then
				local speed2= GolpeArriba.Length/ReloadTime
				GolpeArriba:Play(0,1,speed2)
				wait(ReloadTime)
				SecuenciaDeGolpesIniciada = false
			else
				SecuenciaDeGolpesIniciada = false
			end
		else
			SecuenciaDeGolpesIniciada = false
		end

	end
	
end)

Tool.Equipped:Connect(function()
	Mouse.Icon = IconoDeMouseUsado.Value
end)

Tool.Unequipped:Connect(function()
	Mouse.Icon = ""
end)
