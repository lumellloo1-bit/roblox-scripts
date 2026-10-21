-- Services--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local TweenService = game:GetService("TweenService")

--Instances--
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local RemoteArmas = RemoteEvents:WaitForChild("RemotesArmas")
local RemotesDePico = RemoteArmas:WaitForChild("RemotesPico")
local RemoteDeQuitarBloque = RemotesDePico:WaitForChild("QuitarBloque")
local RondaStorage = ServerStorage:WaitForChild("Ronda")
local ValoresDeRondaStorage = RondaStorage:WaitForChild("ValoresDeRonda")
local ValoresDeArmasStorage = ValoresDeRondaStorage:WaitForChild("ValoresDeArmas")
local ValoresDePicoStorage = ValoresDeArmasStorage:WaitForChild("ValoresDePicaxe")
local RangoDePico = ValoresDePicoStorage:WaitForChild("RangoDelPico")
local RecursosDeRonda = RondaStorage:WaitForChild("RecursosDeRonda")
local StorageArmas = RecursosDeRonda:WaitForChild("StorageArmas")
local StorageDeBloque = StorageArmas:WaitForChild("StorageBloque")
local TexturasDeBloques = StorageDeBloque:WaitForChild("TexturasDeBloques")
local Sonido = script.Sound
--Values--

local TiempoDeEsperaQuitarBloque = 0.1
--TweenParameters--

local Info = TweenInfo.new(TiempoDeEsperaQuitarBloque,Enum.EasingStyle.Quad,Enum.EasingDirection.In,0,false,0)
local Final = {Size = Vector3.new(0.1,0.1,0.1)}
--Funciones

RemoteDeQuitarBloque.OnServerEvent:Connect(function(Player,Bloque)
	local Character = Player.Character
	if not Character then return end
	local Humanod = Character:FindFirstChildOfClass("Humanoid")
	if not Humanod then return end
	if Humanod.Health <= 0 then return end
	
	local PositionBloque 
	local Ok,Error = pcall(function()
		PositionBloque = Bloque.Position
	end)
	if PositionBloque then
		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
		local magnitud = (HumanoidRootPart.Position - Bloque.Position).Magnitude
		local Pico = Player.ValoresDeRonda.ToolValues.Picaxe
		local Degregacion = ValoresDePicoStorage.Magnitudes:FindFirstChild(Pico.Value)
		if magnitud < RangoDePico.Value then
			local VidaDelBloque = Bloque:FindFirstChild("Vida")
			if VidaDelBloque then
				VidaDelBloque.Value = VidaDelBloque.Value - Degregacion.Value
				if VidaDelBloque.Value <= 0 then
					VidaDelBloque:Destroy()
					local Clonacion = Sonido:Clone()
					Clonacion.Parent = Bloque
					Clonacion:Play()
					Bloque.CanCollide = false
					Bloque.CastShadow = false
					Bloque.CanTouch = false
					Bloque.CanQuery = false
					local Track = TweenService:Create(Bloque,Info,Final)
					Track:Play()
					delay(TiempoDeEsperaQuitarBloque,function()
						Bloque:Destroy()
					end)
					local Monedas = Bloque:FindFirstChild("Monedas")
					if Monedas then
						local Value = Monedas.Value
						local MonedasDeJugador = Player:FindFirstChild("leaderstats"):FindFirstChild("Coins")
						if MonedasDeJugador then
							local atachment = Instance.new("Attachment",workspace.Terrain)
							atachment.WorldPosition = Bloque.Position 
							local ClonacionDePar = script.ParticleEmitter:Clone()
							delay(1.5,function()
								ClonacionDePar:Destroy()
							end)
							ClonacionDePar.Parent = atachment
							ClonacionDePar:Emit(1)
							MonedasDeJugador.Value = MonedasDeJugador.Value + Value
						end
					end
					local NumeroDeBloquesDeLaPersona = Player:FindFirstChild("ValoresDePartida"):FindFirstChild("NumberBlocks")
					if NumeroDeBloquesDeLaPersona then
						if NumeroDeBloquesDeLaPersona.Value < 64 then
							NumeroDeBloquesDeLaPersona.Value = NumeroDeBloquesDeLaPersona.Value + 1
							local Tool = Character:FindFirstChild("Block")
							if Tool then
								local Handle = Tool:FindFirstChild("Handle")
								if Handle then
									local SurfaceGui = Handle:FindFirstChild("SurfaceGui")
									if SurfaceGui then
										local Textlabel = SurfaceGui:FindFirstChild("TextLabel")
										if Textlabel then
											Textlabel.Text = NumeroDeBloquesDeLaPersona.Value
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
												Textlabel.Text = NumeroDeBloquesDeLaPersona.Value
											end
										end
									end
								end

							end

						end
					end

				end
				if VidaDelBloque.Value == 1 then
					for i,v in pairs(TexturasDeBloques:FindFirstChild("4"):GetChildren()) do
						local Clonacion = v:Clone()
						Clonacion.Parent = Bloque
					end

				end
				if VidaDelBloque.Value == 2 then
					for i,v in pairs(TexturasDeBloques:FindFirstChild("3"):GetChildren()) do
						local Clonacion = v:Clone()
						Clonacion.Parent = Bloque
					end

				end
				if VidaDelBloque.Value == 3 then
					for i,v in pairs(TexturasDeBloques:FindFirstChild("2"):GetChildren()) do
						local Clonacion = v:Clone()
						Clonacion.Parent = Bloque
					end

				end
				if VidaDelBloque.Value == 4 then
					for i,v in pairs(TexturasDeBloques:FindFirstChild("1"):GetChildren()) do
						local Clonacion = v:Clone()
						Clonacion.Parent = Bloque
					end

				end
			end
		end
	end
	
end)
