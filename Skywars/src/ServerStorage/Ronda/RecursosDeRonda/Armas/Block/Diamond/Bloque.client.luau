-- Servicios --
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--Instancias --
local Tool = script.Parent
local Handle = Tool:WaitForChild("Handle")
local PartesGuia = Tool:WaitForChild("PartesGuia")
local ParteGuiaP = PartesGuia:WaitForChild("GuiaP")
local ParteGuia1 = PartesGuia:WaitForChild("Guia1")
local ParteGuia2 = PartesGuia:WaitForChild("Guia2")
local ParteGuia3 = PartesGuia:WaitForChild("Guia3")
local ParteGuia4 = PartesGuia:WaitForChild("Guia4")
local ParteGuia5 = PartesGuia:WaitForChild("Guia5")
local SelectionBox = Tool:WaitForChild("SelectionBox")
local Animacion = script:WaitForChild("AnimacionDeBlouqe")
local RemoteEvent = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RemotesArmas"):WaitForChild("RemotesBloque"):WaitForChild("PosisionamientoDeBloque")
local StorageServer = ReplicatedStorage:WaitForChild("Storage")
local Icons = StorageServer:WaitForChild("Icons")
local IconoDeMouseUsado = Icons:WaitForChild("Value")
Tool.Equipped:Wait()
local Player = Players.LocalPlayer
local Character = Tool.Parent
local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
local Humanoid = Character:FindFirstChild("Humanoid")
local NumeroDeBloques = Player.ValoresDePartida.NumberBlocks
local Mouse = Player:GetMouse()
--Tablas--
local RycastFilterDesendantsTable = {}
--Params--
for i,v in pairs(Character:GetDescendants()) do
	if v:IsA("MeshPart") or v:IsA("Part") then
		if v.Parent == PartesGuia then
		else
			table.insert(RycastFilterDesendantsTable,1,v)

		end
	end
end
local PosicionRycastParams = RaycastParams.new()
PosicionRycastParams.FilterType = Enum.RaycastFilterType.Blacklist
PosicionRycastParams.FilterDescendantsInstances = RycastFilterDesendantsTable
--InstanciasBindables--
local Activacion
local AgregacionDeObjeto = 0
local Campo = false
local CampoComenzado = false
local PosicionInicialDeCamino
local PosicionDelMouseCambiada = Vector2.new(0,0)
--Valores--
local MaximaDistanciaDeRycast = 1000
local RangoDePicoAdornee = 16
local inf = 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
--Funciones--
local function PosicionDeAdorno(e1,a)
	
	ParteGuiaP.Position = e1 + (1 + AgregacionDeObjeto) * a
	ParteGuia1.Position = e1 + (2 + AgregacionDeObjeto) * a
	ParteGuia2.Position = e1 + (3+ AgregacionDeObjeto) * a
	ParteGuia3.Position = e1 + (4+ AgregacionDeObjeto) * a
	ParteGuia4.Position = e1 + ( AgregacionDeObjeto) * a 
	ParteGuia5.Position = e1 + (-1+ AgregacionDeObjeto) * a
end
local function QueryTouchAdorno(Pone)
	if Pone == true then
		table.foreach(PartesGuia:GetChildren(),function(_,PartGuia)
			PartGuia.CanQuery = true
			PartGuia.CanTouch = true
		end)
	else
		table.foreach(PartesGuia:GetChildren(),function(_,PartGuia)
			PartGuia.CanQuery = false
			PartGuia.CanTouch = false
		end)
	end
end
local function TransparenciaDeBloques(Pone)
	if Pone == true then
		ParteGuiaP.Transparency = 0.5
		ParteGuia1.Transparency = 0.7
		ParteGuia2.Transparency = 0.8
		ParteGuia3.Transparency = 0.9
	else
		ParteGuiaP.Transparency = 1
		ParteGuia1.Transparency =1
		ParteGuia2.Transparency = 1
		ParteGuia3.Transparency = 1
	end

end
local function PosicionDeBloqueDeseada()
	local PosicionDelMose = UserInputService:GetMouseLocation()
	local PantallaRycast = workspace.CurrentCamera:ViewportPointToRay(PosicionDelMose.X, PosicionDelMose.Y)
	local VectorDeDireccion = PantallaRycast.Direction * MaximaDistanciaDeRycast
	local raycastResult = workspace:Raycast(PantallaRycast.Origin, VectorDeDireccion,PosicionRycastParams)
	if raycastResult then
		if raycastResult.Instance.Name == "Block" then
			local PosicionDelBloque = raycastResult.Instance.Position
			local RestaDeVectores = (PosicionDelBloque - raycastResult.Position) * -2
			local TablaDePosicion = {RestaDeVectores.X,RestaDeVectores.Y,RestaDeVectores.Z}
			local TablaDeDeseadas = {PosicionDelBloque.X,PosicionDelBloque.Y,PosicionDelBloque.Z}

			for i,v in pairs(TablaDePosicion) do
				if math.abs(v) == 4 then
					local Value = TablaDeDeseadas[i] + TablaDePosicion[i]
					table.remove(TablaDeDeseadas,i) table.insert(TablaDeDeseadas,i,Value)
					local VectorDePosicion = Vector3.new(TablaDeDeseadas[1],TablaDeDeseadas[2],TablaDeDeseadas[3])
					local MG = (VectorDePosicion - HumanoidRootPart.Position).Magnitude
					if MG < RangoDePicoAdornee then
						return VectorDePosicion
					end

				end
			end
		end
	end
end
local function MovimientoDeMouse() 
	if CampoComenzado == true then
		local PuedeComenzar = false
		local b = Instance.new("Part")b.CFrame = game.Workspace.Camera.CFrame local c = b.Orientation.Y if c <=45 and c >=-45 then a = Vector3.new(0,0,-4)elseif c <= -45 and c >= -135 then a = Vector3.new(4,0,0)elseif c >= 45 and c<= 135 then a = Vector3.new(-4,0,0)else 	a = Vector3.new(0,0,4)	end	local a1 = ((HumanoidRootPart.Position - b.Position).Magnitude) + 20   local b1 = UserInputService:GetMouseLocation()local c1 = workspace.CurrentCamera:ViewportPointToRay(b1.X, b1.Y)local d1 = c1.Direction * a1	local e1 = workspace:Raycast(c1.Origin, d1,PosicionRycastParams)
		local a2 = ((HumanoidRootPart.Position - b.Position).Magnitude) + 20   local b2 = UserInputService:GetMouseLocation()local c2 = workspace.CurrentCamera:ViewportPointToRay(b2.X, b2.Y)local d2 = c1.Direction * a2	local e2 = workspace:Raycast(c2.Origin, d2,PosicionRycastParams)
		if  e2 then
			if e2.Instance.Parent == PartesGuia then
				PuedeComenzar = true
			end

		end
		if not PuedeComenzar  then
			CampoComenzado = false
			Campo = false
			AgregacionDeObjeto = 0
			TransparenciaDeBloques(false)
			SelectionBox.Adornee = nil
		end
	end

	local b = Instance.new("Part")b.CFrame = game.Workspace.Camera.CFrame local c = b.Orientation.Y if c <=45 and c >=-45 then a = Vector3.new(0,0,-4)elseif c <= -45 and c >= -135 then a = Vector3.new(4,0,0)elseif c >= 45 and c<= 135 then a = Vector3.new(-4,0,0)else 	a = Vector3.new(0,0,4)	end	local a1 = ((HumanoidRootPart.Position - b.Position).Magnitude) + 20   local b1 = UserInputService:GetMouseLocation()local c1 = workspace.CurrentCamera:ViewportPointToRay(b1.X, b1.Y)local d1 = c1.Direction * a1	local e1 = workspace:Raycast(c1.Origin, d1,PosicionRycastParams)
	if e1 then	
		if e1.Instance.Name == "Block" then
			local magni = (e1.Instance.Position - HumanoidRootPart.Position).Magnitude
			if magni < 16 then
				SelectionBox.Adornee = e1.Instance
				PosicionDeAdorno(e1.Instance.Position,a)
				QueryTouchAdorno(false)
				TransparenciaDeBloques(false)
				Campo = false
			end

		end
	else
		QueryTouchAdorno(true)
		local a2 = ((HumanoidRootPart.Position - b.Position).Magnitude) + 20   local b2 = UserInputService:GetMouseLocation()local c2 = workspace.CurrentCamera:ViewportPointToRay(b2.X, b2.Y)local d2 = c1.Direction * a2	local e2 = workspace:Raycast(c2.Origin, d2,PosicionRycastParams)
		if e2 then
			if e2.Instance.Parent == PartesGuia then
				SelectionBox.Adornee = ParteGuiaP
				Campo = true
				TransparenciaDeBloques(true)
			else
				TransparenciaDeBloques(false)
				Campo = false
				SelectionBox.Adornee = nil
			end
		else
			Campo = false
			TransparenciaDeBloques(false)
			SelectionBox.Adornee = nil

		end

	end
	b:Destroy()
end
--Eventos--
Activacion = Tool.Activated:Connect(function()
	local position = PosicionDeBloqueDeseada()
	if Campo == true then
		if NumeroDeBloques.Value > 0 then
			local Magnitude = (HumanoidRootPart.Position - ParteGuiaP.Position).Magnitude
			if Magnitude < 12 then
				if CampoComenzado == false then
					PosicionInicialDeCamino = ParteGuiaP.Position
				end
				ParteGuia3.Transparency  = 1
				CampoComenzado = true
				RemoteEvent:FireServer(ParteGuiaP.Position)
				PosicionDeAdorno(PosicionInicialDeCamino,a)
				AgregacionDeObjeto = AgregacionDeObjeto + 1

			end
		end

	else
		if position then
			RemoteEvent:FireServer(position)
		end
	end
end)

Tool.Activated:Connect(function()
	local Track = Humanoid:LoadAnimation(Animacion)
	Track:Play()
end)
PosicionDlMose = Mouse.Move:Connect(function()
	MovimientoDeMouse()

end)


Tool.Equipped:Connect(function()
	Mouse.Icon = IconoDeMouseUsado.Value
end)

Tool.Unequipped:Connect(function()
	Mouse.Icon = ""
end)
