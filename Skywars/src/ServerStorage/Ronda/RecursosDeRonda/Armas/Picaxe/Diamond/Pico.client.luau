-- Servicios --
local a = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--Instancias --
local Tool = script.Parent
local Handle = Tool:FindFirstChild("Handle")
local SelectionBox = Tool:WaitForChild("SelectionBox")
local RemoteEvent = ReplicatedStorage:FindFirstChild("RemoteEvents"):WaitForChild("RemotesArmas"):WaitForChild("RemotesPico"):WaitForChild("QuitarBloque")
local StorageServer = ReplicatedStorage:WaitForChild("Storage")
local Icons = StorageServer:WaitForChild("Icons")
local IconoDeMouseUsado = Icons:WaitForChild("Value")
Tool.Equipped:Wait()
local Player = a.LocalPlayer
local Character = Tool.Parent
local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
local Mouse = Player:GetMouse()
--Tablas--
local RycastFilterDesendantsTable = {}
--Params--
for i,v in pairs(Character:GetDescendants()) do
	if v:IsA("MeshPart") or v:IsA("Part") then
		table.insert(RycastFilterDesendantsTable,1,v)
	end
end
local PosicionRycastParams = RaycastParams.new()
PosicionRycastParams.FilterType = Enum.RaycastFilterType.Blacklist
PosicionRycastParams.FilterDescendantsInstances = RycastFilterDesendantsTable
--InstanciasBindables--
local Activacion
local AgregacionDeObjeto = 0
local Campo = false
local a
local Advertido = false
local CampoComenzado = false
local PosicionInicialDeCamino 
--Valores--
local MaximaDistanciaDeRycast = 1000
local RangoDePicoAdornee = 16
local inf = 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
--Funciones--


local function PosicionDeBloqueDeseada()
	local PosicionDelMose = UserInputService:GetMouseLocation()
	local PantallaRycast = workspace.CurrentCamera:ViewportPointToRay(PosicionDelMose.X, PosicionDelMose.Y)
	local VectorDeDireccion = PantallaRycast.Direction * MaximaDistanciaDeRycast
	local raycastResult = workspace:Raycast(PantallaRycast.Origin, VectorDeDireccion,PosicionRycastParams)
	if raycastResult then
		if raycastResult.Instance.Name == "Block" then
			local VectorDePosicion = raycastResult.Instance.Position
					local MG = (VectorDePosicion - HumanoidRootPart.Position).Magnitude
					if MG < RangoDePicoAdornee then
						return raycastResult.Instance
					end

				end
		end
end
local function MovimientoDeMouse()
	local b = Instance.new("Part")b.CFrame = game.Workspace.Camera.CFrame local c = b.Orientation.Y if c <=45 and c >=-45 then a = Vector3.new(0,0,-4)elseif c <= -45 and c >= -135 then a = Vector3.new(4,0,0)elseif c >= 45 and c<= 135 then a = Vector3.new(-4,0,0)else 	a = Vector3.new(0,0,4)	end	local a1 = ((HumanoidRootPart.Position - b.Position).Magnitude) + 20   local b1 = UserInputService:GetMouseLocation()local c1 = workspace.CurrentCamera:ViewportPointToRay(b1.X, b1.Y)local d1 = c1.Direction * a1	local e1 = workspace:Raycast(c1.Origin, d1,PosicionRycastParams)
	if e1 then	
		if e1.Instance.Name == "Block" then
			local magni = (e1.Instance.Position - HumanoidRootPart.Position).Magnitude
			if magni < 16 then
				SelectionBox.Adornee = e1.Instance
			else
				SelectionBox.Adornee = nil

			end
		else
			SelectionBox.Adornee = nil

		end
	else
		SelectionBox.Adornee = nil
	end
	b:Destroy()
end

--Eventos--
Activacion = Tool.Activated:Connect(function()
	local position = PosicionDeBloqueDeseada()
	if position then
		RemoteEvent:FireServer(position)	

	end
end)

PosicionDlMose = Player:GetMouse().Move:Connect(function()
	MovimientoDeMouse()
end)

Tool.Equipped:Connect(function()
	Mouse.Icon = IconoDeMouseUsado.Value
end)

Tool.Unequipped:Connect(function()
	Mouse.Icon = ""
end)
