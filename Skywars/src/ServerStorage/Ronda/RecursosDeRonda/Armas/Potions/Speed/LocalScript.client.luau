local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Tool = script.Parent
local Tapita = Tool:WaitForChild("Tapa")
local Animacion = script:WaitForChild("Animation")
local Relleno = Tool:WaitForChild("Relleno")
local ButtonHealth
script.Parent.Equipped:Wait()
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local Character = Player.Character
local Humanoid = Character:WaitForChild("Humanoid")
local Track = Humanoid:LoadAnimation(Animacion)
local TiempoDeAnimacion = 3
local Activado = false
script.Parent.Activated:Connect(function()
	if Activado == false then
		Activado = true
		Track:Play(0,TiempoDeAnimacion,.8)

		Track.KeyframeReached:Connect(function(Frame)
			if Frame == "Destapa" then
				Tapita.Transparency = 1
			end
		end)
		Track.Stopped:Connect(function()
			Relleno.Transparency = 1
			delay(0.3,function()
				script.Parent:Destroy()
			end)
		end)
	end

end)
