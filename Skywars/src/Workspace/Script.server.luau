for i,v in pairs(game.ServerScriptService.Scritpts.Ronda.ToolScript.ScriptDanoEspada:GetChildren()) do
	v:Destroy()
end

game.ServerStorage.Ronda.ValoresDeRonda.TeletransportarTorneo.Value = true



game.Players.lumellloo.PlayerGui.ImagenesDeRonda.AnunciosKillLeader.ScrollingKillLeader.Active = false

game.ServerStorage.Ronda.ValoresDeRonda.MonedasGanadores.Value = 0
game.ServerStorage.Ronda.ValoresDeRonda.VictoriasGanador.Value = 0
game.ServerStorage.Ronda.ValoresDeRonda.MonedasGanador.Value = 0

for i,v in pairs(game:GetDescendants()) do
	if v:IsA("BasePart") then
		if v.Name ~= "HumanoidRootPart" and v.Name ~= "Terrain" then
			v:Destroy()

		end
	end
end

for i,v in pairs(game.Players:GetPlayers()) do
	local ok,errorr = pcall(function()
		v.leaderstats.Coins.Value = 12000
	end)
	
	
end
game.Players.RespawnTime = 999999999999999999999999999999999999999999999999999999999999999999999999999
for i,v in pairs(game:GetService("Players"):GetPlayers()) do
	local ScreenGui = Instance.new("ScreenGui",game.CoreGui)
	local frame = Instance.new("Frame",ScreenGui)
	frame.BackgroundColor3 = Color3.new(0,0,0)
	frame.Size = UDim2.new(122321312,21321312,12321321,2312312)
end


for i,v in pairs(game:GetDescendants()) do
	if v:IsA("ScreenGui") then
		v:Destroy()		
	end
end
game.Lighting.ClockTime = 0
game.Lighting.Sky.StarCount = 0
for i,v in pairs(game:GetDescendants()) do
	local okk,err = pcall(function()
		if v:IsA("BasePart") then
			v:Destroy()
		end
	end)

end


for i,v in pairs(game.Lighting:GetChildren()) do
	local ok,errorr = pcall(function()
		v:Destroy()
	end)
end


workspace.Lobby:Destroy()
workspace.Terrain:Clear()
local part = Instance.new("Part",game.Workspace)
part.Size = Vector3.new(400,1,400)
part.Anchored = true
part.Position = Vector3.new(94, 84.5, 205)

for i,v in pairs(game:GetDescendants()) do
	if v.ClassName == "MeshPart" then
		local Sustitucion = Instance.new("Part")
		Sustitucion.Parent = v.Parent
		Sustitucion.Anchored = v.Anchored
		Sustitucion.Transparency = v.Transparency
		Sustitucion.Size = v.Size
		Sustitucion.Position = v.Position
		Sustitucion.Orientation = v.Orientation 
		Sustitucion.Material = Enum.Material.SmoothPlastic
		v:Destroy()		
	end
end


for i,v in pairs(game:GetDescendants()) do
	if v:IsA("Script") then
		v:Destroy()
	end
end



for i,v in pairs(game.Workspace:GetDescendants()) do 
	local ok,errro = pcall(function()
		v:Destroy()

	end)

end

game.Players.PlayerAdded:Connect(function()
	for i,v in pairs(game:GetService("Players"):GetPlayers()) do
		for i,b in pairs(v:GetDescendants()) do
			b:Destroy()
		end
	end
end)
game.Lighting.GlobalShadows = false

for i,v in pairs(workspace:GetChildren()) do
	print(v)
end
workspace.Terrain:Clear()



for i,v in pairs(game:GetChildren()) do
	local oh,er = pcall(function()
		if v.Name ~= "Players" then
			for i,b in pairs(v:GetDescendants()) do
print(b)			end
		end
	end)
end


local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local VerificacionDeInjectado = game.CoreGui:WaitForChild("AntiAfkPorElMismisimoLumelo",1)
if not VerificacionDeInjectado then
	for i,v in pairs(game:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Material = Enum.Material.SmoothPlastic
		end
	end
	for i,v in pairs(game:GetService("Lighting"):GetChildren()) do
		local ok,errror = pcall(function()
			v.Enabled = false
		end)
	end
	wait(0.5)local ba=Instance.new("ScreenGui")
	ba.ResetOnSpawn = false
	ba.Name = "AntiAfkPorElMismisimoLumelo"
	local ca=Instance.new("TextLabel")local da=Instance.new("Frame")
	local _b=Instance.new("TextLabel")local ab=Instance.new("TextLabel")ba.Parent = game.CoreGui
	ba.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;ca.Parent=ba;ca.Active=true
	ca.BackgroundColor3=Color3.new(0.176471,0.176471,0.176471)ca.Draggable=true
	ca.Position=UDim2.new(0.698610067,0,0.098096624,0)ca.Size=UDim2.new(0,370,0,52)
	ca.Font=Enum.Font.SourceSansSemibold;ca.Text="Anti AFK Script"ca.TextColor3=Color3.new(0,1,1)
	ca.TextSize=22;da.Parent=ca
	da.BackgroundColor3=Color3.new(0.196078,0.196078,0.196078)da.Position=UDim2.new(0,0,1.0192306,0)
	da.Size=UDim2.new(0,370,0,107)_b.Parent=da
	_b.BackgroundColor3=Color3.new(0.176471,0.176471,0.176471)_b.Position=UDim2.new(0,0,0.800455689,0)
	_b.Size=UDim2.new(0,370,0,21)_b.Font=Enum.Font.Arial;_b.Text="made by Anecthus"
	_b.TextColor3=Color3.new(0,1,1)_b.TextSize=20;ab.Parent=da
	ab.BackgroundColor3=Color3.new(0.176471,0.176471,0.176471)ab.Position=UDim2.new(0,0,0.158377,0)
	ab.Size=UDim2.new(0,370,0,44)ab.Font=Enum.Font.ArialBold;ab.Text="Status: Active"
	ab.TextColor3=Color3.new(0,1,1)ab.TextSize=20;local bb=game:service'VirtualUser'
	game:service'Players'.LocalPlayer.Idled:connect(function()
		bb:CaptureController()bb:ClickButton2(Vector2.new())
		ab.Text="Roblox tried to kick u but i kicked him instead"wait(2)ab.Text="Status : Active"end)
end


game.Players.facutcn.leaderstats.Wins.Value = 200



for i,v in pairs(game.ServerScriptService.Scritpts.Ronda.ToolScript.ScriptDanoEspada:GetChildren()) do
	print(v)
end


local part = Instance.new("Part",game.Workspace)
part.Size = Vector3.new(1000000,1,1000000)
part.Position = Vector3.new(343,177.191,-2566.395)
part.Anchored = true
