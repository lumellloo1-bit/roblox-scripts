-- Services--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Debris = game:GetService("Debris")
--Instances--

local FolderDeRemotesPico = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RemotesArmas"):WaitForChild("RemotesBloque")
local FolderDeValuesPico = ServerStorage:WaitForChild("Ronda"):WaitForChild("ValoresDeRonda"):WaitForChild("ValoresDeArmas"):WaitForChild("ValoresDeBlock")
local Presicion = FolderDeValuesPico:FindFirstChild("PresicionBoxBloque")
local RangoDelPico = FolderDeValuesPico:WaitForChild("RangoDelBloque")
local RemoteEvent = FolderDeRemotesPico:WaitForChild("PosisionamientoDeBloque")
local FolderDeBloques = ServerStorage:WaitForChild("Ronda"):WaitForChild("RecursosDeRonda"):WaitForChild("StorageArmas"):WaitForChild("StorageBloque"):WaitForChild("Bloques")
local Sound = script.Sound
--Funciones


local function VerificacionDePosition(Player,Position)
	local Character = Player.Character
	if not Character then return end
	local Humanod = Character:FindFirstChildOfClass("Humanoid")
	if not Humanod then return end
	if Humanod.Health <= 0 then return end
	if Position.Y <  218.7 then
		local OverParams = OverlapParams.new()
		OverParams.FilterType = Enum.RaycastFilterType.Blacklist
		local PlayerPosition = Character.HumanoidRootPart.Position
		local Magnitude = (Position - PlayerPosition).Magnitude
		if Magnitude < RangoDelPico.Value then
			local TablaDeNoDeseados = {}
			for i,v in pairs(Character:GetChildren()) do
				if v.ClassName == "Accessory" then
					for i,c in pairs(v:GetChildren()) do
						if c.Name == "Handle" then
							table.insert(TablaDeNoDeseados,c)
						end
					end
				end
				if v.ClassName == "Part" then
					if v.Name == "Torso" or v.Name == "Head" then
					else
						table.insert(TablaDeNoDeseados,v)
					end
				end
			end
			OverParams.FilterDescendantsInstances = TablaDeNoDeseados
			local Verificador = Instance.new("Part",game.Workspace)
			Verificador.Size = Vector3.new(Presicion.Value,Presicion.Value,Presicion.Value)
			Verificador.Anchored = true
			Verificador.Position = Position
			Verificador.CanTouch = false
			Verificador.CanCollide = false
			Verificador.CanQuery = false
			Verificador.CastShadow = false

			local partes = workspace:GetPartsInPart(Verificador,OverParams)
			Verificador:Destroy()

			if partes[1] then
			else

				local ValoresDeRonda = Player:WaitForChild("ValoresDeRonda"):WaitForChild("ToolValues"):WaitForChild("Block")
				local NumeroDeBloques = Player:WaitForChild("ValoresDePartida"):WaitForChild("NumberBlocks")
				
				if NumeroDeBloques.Value > 0  then
					local Bloque = FolderDeBloques:WaitForChild(ValoresDeRonda.Value):Clone()
					Bloque.Parent = workspace.RondasFunciones.BloquesDeRonda
					Bloque.Position = Position
					Bloque.Name = "Block"
					local SonidoEnBloque = Sound:Clone()
					SonidoEnBloque.Parent = Bloque
					SonidoEnBloque:Play()
					Debris:AddItem(SonidoEnBloque,SonidoEnBloque.TimeLength)
					
					local colorH,ColorS,colorV =Bloque.Color:ToHSV() 
					
					local NumeroRandom = (math.random(-20,0))/100
					Bloque.Color = Color3.fromHSV(colorH,ColorS  ,colorV+ NumeroRandom)

					
					NumeroDeBloques.Value = NumeroDeBloques.Value - 1

					local Tool = Character:FindFirstChild("Block")
					if Tool then
						local Handle = Tool:FindFirstChild("Handle")
						if Handle then
							local SurfaceGui = Handle:FindFirstChild("SurfaceGui")
							if SurfaceGui then
								local Textlabel = SurfaceGui:FindFirstChild("TextLabel")
								if Textlabel then
									Textlabel.Text = NumeroDeBloques.Value
								end
							end
						end
					else
						Tool = Player.Backpack:FindFirstChild("Block")
						if Tool then
							local Handle = Tool:FindFirstChild("Handle")
							if Handle then
								local SurfaceGui = Handle:FindFirstChild("SurfaceGui")
								if SurfaceGui then
									local Textlabel = SurfaceGui:FindFirstChild("TextLabel")
									if Textlabel then
										Textlabel.Text = NumeroDeBloques.Value
									end
								end
							end
						end
						
					end

				end

			end
		end

	end
	
end

RemoteEvent.OnServerEvent:Connect(function(Player,Position)
	VerificacionDePosition(Player,Position)
end)
