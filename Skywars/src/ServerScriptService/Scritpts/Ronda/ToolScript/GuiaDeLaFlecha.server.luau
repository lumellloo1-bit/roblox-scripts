--Servicios--
local RunService =  game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
--Instances--
local RondaServerStorage = ServerStorage:WaitForChild("Ronda")
local ValoresReplicated = ReplicatedStorage:WaitForChild("Valores")
local ValoresDeArmasReplicated = ValoresReplicated:WaitForChild("ValoresArmas")
local ValoresDeRonda = RondaServerStorage:WaitForChild("ValoresDeRonda")
local RecursosDeRonda = RondaServerStorage:WaitForChild("RecursosDeRonda")
local RemoteEvets = ReplicatedStorage:WaitForChild("RemoteEvents")
local RemoteEvetsArmas = RemoteEvets:WaitForChild("RemotesArmas")
local ValoresDeArmas = ValoresDeRonda:WaitForChild("ValoresDeArmas")
local FuncionesStorage = ServerStorage:WaitForChild("Funciones")
local FunccionesLeader = require(FuncionesStorage:WaitForChild("FuncionesLeader"))
local ValoresDeArcoReplicated = ValoresDeArmasReplicated:WaitForChild("ValoresArco")
local ReplicatedStorageReloadArco = ValoresDeArcoReplicated:WaitForChild("ReloadTime")
local RemotesArco = RemoteEvetsArmas:WaitForChild("RemotesArco")
local StorageArmas = RecursosDeRonda:WaitForChild("StorageArmas")
local StorageArco = StorageArmas:WaitForChild("StorageArco")
local Flechas = StorageArco:WaitForChild("Flechas")
local PosicionamientoDeLaFlechaRemote = RemotesArco:WaitForChild("PosicionamientoDeFlecha")
local ValoresDeArco = ValoresDeArmas:WaitForChild("ValoresDeBow")
local MagnitudesDeArco = ValoresDeArco:WaitForChild("Magnitudes")
local DelayTimeArco = ValoresDeArco:WaitForChild("DelayTime")
local ReloadTimeArco = ValoresDeArco:WaitForChild("ReloadTime")
local ValoresDeDelayArco= ValoresDeArcoReplicated:WaitForChild("Jugadores")
local GameScripts = script.Parent.Parent.Parent:WaitForChild("Game")
local AdminScript = GameScripts:WaitForChild("AdminScript")
local ValoresDePotenciadoresReplicated = ValoresReplicated:WaitForChild("ValoresPotenciadores")
local ValoresDeEscudoReplicated = ValoresDePotenciadoresReplicated:WaitForChild("ValoresEscudo")
local JugadoresConEscudo = ValoresDeEscudoReplicated:WaitForChild("Jugadores")

--Values--
local DelayDecoracion = 0.7
local Info = TweenInfo.new(DelayDecoracion,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0)
local Final = {Transparency = 1}


PosicionamientoDeLaFlechaRemote.OnServerEvent:Connect(function(Player,Position)

	local Character = Player.Character
	if not Character then return end
	local V = Character:FindFirstChildOfClass("Humanoid")
	if not V then return end
	if V.Health <= 0 then return end

	local Verificacion = ValoresDeDelayArco:FindFirstChild(Player.Name)
	if not Verificacion then
		local ValueDeArco = Instance.new("BoolValue")
		ValueDeArco.Parent = ValoresDeDelayArco
		ValueDeArco.Name = Player.Name
		local TiempoCambiado = AdminScript:FindFirstChild(Player.Name.."BowReload")
		if TiempoCambiado then
			local Tiempo = TiempoCambiado.Value
			if Tiempo~= 125315813 then
				delay(Tiempo,function()
					ValueDeArco:Destroy()
				end)
			else
				delay(ReloadTimeArco.Value,function()
					ValueDeArco:Destroy()
				end)
			end
		else
			delay(ReloadTimeArco.Value,function()
				ValueDeArco:Destroy()
			end)
		end


		local TipoDeFlecha = Player:WaitForChild("ValoresDeRonda"):WaitForChild("ToolValues"):WaitForChild("Bow").Value
		local TablaDeBlacklist = {}


		table.foreach(Character:GetDescendants(),function(_,Parte)
			if Parte:IsA("BasePart") then
				table.insert(TablaDeBlacklist,Parte)

			end
		end)

		local Arco = Character:FindFirstChild("Bow")
		if Arco then

			--Values
			local Handle = Arco:FindFirstChild("Handle")
			local a = Handle.Position
			local SonidoDeDis = Handle:FindFirstChildOfClass("Sound")
			if SonidoDeDis then
				SonidoDeDis:Play()
			end
			local b = Position
			local Funcion
			local CFrameParaMirar = CFrame.new(a,b)
			local CFrameRotado = CFrame.Angles(0,math.rad(-180),0)
			local CFrameRotado2 = CFrame.Angles(0,math.rad(90),0)
			--Instances--
			local Modelo = Flechas:FindFirstChild(TipoDeFlecha)
			local Clonacion = Modelo:Clone()
			local Misil = Clonacion:WaitForChild("Principal")
			local Principal = Clonacion:WaitForChild("Principal")
			local Argolla = Clonacion:WaitForChild("Argolla")
			local Cuerpo = Clonacion:WaitForChild("Cuerpo")
			local Guas = Clonacion:WaitForChild("Guias")
			local WeldFolder = Clonacion:WaitForChild("Welds")
			--Code
			--Params--
			local Parametros = RaycastParams.new()
			Parametros.FilterType = Enum.RaycastFilterType.Blacklist
			Parametros.FilterDescendantsInstances = TablaDeBlacklist
			local cframeDeDireccion = CFrame.lookAt(a,b)
			local VectorDeDIreccion = cframeDeDireccion.LookVector
			local Rycast = workspace:Raycast(a,VectorDeDIreccion * 3000,Parametros)
			if Rycast then
				local Character = Rycast.Instance.Parent
				local Humanoid = Character:FindFirstChild("Humanoid")
				if Humanoid then
					local NameDelEscudado = Character.Name 
					local Escudado = JugadoresConEscudo:FindFirstChild(NameDelEscudado)
					if not Escudado then
						local DanoDeFlecha = MagnitudesDeArco:FindFirstChild(TipoDeFlecha).Value

						if Humanoid.Health <= 0 then return end
						local DanoCambiado = AdminScript:FindFirstChild(Player.Name.."BowDamage")
						if DanoCambiado then
							local Dano = DanoCambiado.Value
							if Dano~= 125315813 then
								Humanoid.Health = Humanoid.Health - Dano
							else
								Humanoid.Health = Humanoid.Health - DanoDeFlecha
							end
						else
							Humanoid.Health = Humanoid.Health - DanoDeFlecha
						end

						if Humanoid.Health <= 0 then
							local PlayerDead = Players:GetPlayerFromCharacter(Character)
							FunccionesLeader.LeaderDataKillCount(Player,PlayerDead,"Arrow")
						end
					end

				end
				Misil.CFrame = CFrameParaMirar:ToWorldSpace(CFrameRotado)
				Misil.Position = Rycast.Position

				Clonacion.Parent = workspace.RondasFunciones.Deribis
				local CFramePrincipal = Principal.CFrame
				Argolla.CFrame = CFramePrincipal:ToWorldSpace(CFrame.Angles(math.rad(-90),math.rad(-180), 0) + Vector3.new(0, 0, -0.365))
				Cuerpo.CFrame = CFramePrincipal:ToWorldSpace(CFrame.Angles(math.rad(90),math.rad(180),0) + Vector3.new(-0, 0, -2.039))
				Guas.CFrame = CFramePrincipal:ToWorldSpace(CFrame.Angles(0, math.rad(180), 0) + Vector3.new(0, 0, -3.382))
				local Parte = Instance.new("Part",Clonacion)
				Parte.CanTouch = false
				Parte.CanCollide = false
				Parte.CanQuery = false
				Parte.CastShadow = false
				Parte.Shape = Enum.PartType.Cylinder
				local Souns = Misil:FindFirstChildOfClass("Sound")
				if Souns then
					Souns:Play()
				end

				local Magnitud = (a - Rycast.Position).Magnitude
				Parte.Size = Vector3.new(Magnitud - 4,0.3,0.3)
				Parte.Color = Principal.Color
				Parte.Anchored = true
				Parte.Material = Enum.Material.SmoothPlastic
				local lookVect0r = CFrameParaMirar.LookVector
				Parte.CFrame = CFrameParaMirar:ToWorldSpace(CFrameRotado2) 
				Parte.Position = a + (lookVect0r * ((Magnitud/2)-(4/2)))
				local Animacion = TweenService:Create(Parte,Info,Final)
				Animacion:Play()
				delay(DelayDecoracion,function()
					Parte:Destroy()
				end)
				local weld = Instance.new("WeldConstraint",WeldFolder)
				weld.Part0 = Principal
				weld.Part1 = Rycast.Instance
				local weld2 = Instance.new("WeldConstraint",WeldFolder)
				weld2.Part0 = Rycast.Instance
				weld2.Part1 = Argolla
				local weld3 = Instance.new("WeldConstraint",WeldFolder)
				weld3.Part0 = Rycast.Instance
				weld3.Part1 = Cuerpo
				local weld4 = Instance.new("WeldConstraint",WeldFolder)
				weld4.Part0 = Rycast.Instance
				weld4.Part1 = Guas
			else
				Misil.CFrame = CFrameParaMirar:ToWorldSpace(CFrameRotado)
				Misil.Position = a + VectorDeDIreccion * 1000
				b = a + VectorDeDIreccion * 2048
				Clonacion.Parent = workspace.RondasFunciones.Deribis
				local CFramePrincipal = Principal.CFrame
				Argolla.CFrame = CFramePrincipal:ToWorldSpace(CFrame.Angles(math.rad(-90),math.rad(-180), 0) + Vector3.new(0, 0, -0.365))
				Cuerpo.CFrame = CFramePrincipal:ToWorldSpace(CFrame.Angles(math.rad(90),math.rad(180),0) + Vector3.new(-0, 0, -2.039))
				Guas.CFrame = CFramePrincipal:ToWorldSpace(CFrame.Angles(0, math.rad(180), 0) + Vector3.new(0, 0, -3.382))
				local Parte = Instance.new("Part",Clonacion)
				Parte.CanTouch = false
				Parte.CanCollide = false
				Parte.CanQuery = false
				Parte.CastShadow = false
				Parte.Shape = Enum.PartType.Cylinder

				local Magnitud = (a - b).Magnitude
				Parte.Size = Vector3.new(Magnitud - 4,0.3,0.3)
				Parte.Color = Principal.Color
				Parte.Anchored = true
				Parte.Material = Enum.Material.SmoothPlastic
				local lookVect0r = CFrameParaMirar.LookVector
				Parte.CFrame = CFrameParaMirar:ToWorldSpace(CFrameRotado2) 
				Parte.Position = a + (lookVect0r * ((Magnitud/2)-(4/2)))
				local Animacion = TweenService:Create(Parte,Info,Final)
				Animacion:Play()
				delay(DelayDecoracion,function()
					Parte:Destroy()
				end)
				for i,v in pairs(Clonacion:GetChildren()) do
					if v:IsA("MeshPart") then
						v.Anchored = true
					end
				end
			end
			delay(7,function()
				for i,v in pairs(WeldFolder:GetChildren()) do
					v:Destroy()

				end
				for i,v in pairs(Clonacion:GetChildren()) do
					for i,v in pairs(Clonacion:GetChildren()) do
						if v:IsA("MeshPart") then
							v.Anchored = false
						end
					end
				end
			end)
		end
	end

end)
ReloadTimeArco.Changed:Connect(function()
	ReplicatedStorageReloadArco.Value = ReloadTimeArco.Value
end)
