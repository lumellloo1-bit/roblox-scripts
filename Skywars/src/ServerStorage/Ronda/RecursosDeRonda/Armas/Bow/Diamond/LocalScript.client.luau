-- Service--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
--Instances--
local RemoteEvent = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RemotesArmas"):WaitForChild("RemotesArco"):WaitForChild("PosicionamientoDeFlecha")
local ValoresDeDelay = ReplicatedStorage:WaitForChild("Valores"):WaitForChild("ValoresArmas"):WaitForChild("ValoresArco"):WaitForChild("Jugadores")
local ReloadTime = ReplicatedStorage:WaitForChild("Valores"):WaitForChild("ValoresArmas"):WaitForChild("ValoresArco"):WaitForChild("ReloadTime")
local Tool = script.Parent
local ModeloDeFlecha = Tool:WaitForChild("Flecha")
local Amimation = Tool:WaitForChild("MeshPart"):WaitForChild("Animation")
local Handle = Tool:WaitForChild("Handle")
local StorageServer = ReplicatedStorage:WaitForChild("Storage")
local Icons = StorageServer:WaitForChild("Icons")
local IconoDeMouseUsado = Icons:WaitForChild("Value")
Tool.Equipped:Wait()
local Player = Players.LocalPlayer
local Charactetr = Player.Character
local Track = Charactetr.Humanoid:LoadAnimation(Amimation)
Track.Priority = Enum.AnimationPriority.Action
local Mouse = Player:GetMouse()
--Talbas--
local RycastFilterDesendantsTable = {}
--Params--
for i,v in pairs(Charactetr:GetDescendants()) do
	if v:IsA("MeshPart") or v:IsA("Part") then
		table.insert(RycastFilterDesendantsTable,1,v)
	end
end
local PosicionRycastParams = RaycastParams.new()
PosicionRycastParams.FilterType = Enum.RaycastFilterType.Blacklist
PosicionRycastParams.FilterDescendantsInstances = RycastFilterDesendantsTable
local Sedpuede = true
local function PlayAnimation()
	if Sedpuede ==true then
		Sedpuede = false
		Track.KeyframeReached:Connect(function(keyframeName)
			for i,v in pairs(ModeloDeFlecha:GetChildren()) do
				v.Transparency = 0
			end
		end)
		local speed = Track.Length/ReloadTime.Value

		Track:Play(0,ReloadTime.Value,speed)
		Track.Stopped:Wait()
		Sedpuede = true
	end
	
end
--Parametros--

ValoresDeDelay.ChildAdded:Connect(function(child)
	if child.Name == Player.Name then
		for i,v in pairs(ModeloDeFlecha:GetChildren()) do
			v.Transparency = 1
		end
	end
end)
local function PosDelMosue()
	local PosicionDelMose = UserInputService:GetMouseLocation()
	local PantallaRycast = workspace.CurrentCamera:ViewportPointToRay(PosicionDelMose.X, PosicionDelMose.Y)
	local VectorDeDireccion = PantallaRycast.Direction * 10000
	local raycastResult = workspace:Raycast(PantallaRycast.Origin, VectorDeDireccion,PosicionRycastParams)
	if raycastResult then
		return raycastResult.Position
	else
		return PantallaRycast.Origin + VectorDeDireccion
	end
end


Tool.Activated:Connect(function()
	local Sepuede = ValoresDeDelay:FindFirstChild(Player.Name)
	if not Sepuede then
		local Posicion = PosDelMosue()
		
			
			RemoteEvent:FireServer(Posicion)
		PlayAnimation()
	end
	
end)

Tool.Unequipped:Connect(function()
	Track:Stop()
end)

Tool.Equipped:Connect(function()
	Mouse.Icon = IconoDeMouseUsado.Value
end)

Tool.Unequipped:Connect(function()
	Mouse.Icon = ""
end)
