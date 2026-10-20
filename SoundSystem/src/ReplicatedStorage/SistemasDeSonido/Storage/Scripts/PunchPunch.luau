local module = {}
function module.AltaVoz(v)
	-- instances 
	local Bocina = v
	local Sound = game.Workspace:WaitForChild("SoundGroup"):FindFirstChild("Sonido")

	local Servicio = game:GetService("RunService")
	local PartesEnMovimiento = Bocina:FindFirstChild("Movimiento")
	local SizeParteZ = PartesEnMovimiento.ParteZ.Size.Y
	local SizeParteZ1 = PartesEnMovimiento.ParteZ1.Size.Y
	local PositionParteM = PartesEnMovimiento.ParteM.Position
	local PositionParteM1 = PartesEnMovimiento.ParteM1.Position
	local Handle = Bocina:FindFirstChild("Handle")
	-- NumberValues
	local RazonZ = SizeParteZ/1000
	local RazonZ1 = SizeParteZ1/1000
	local Problema = Bocina.ALTA.Position - PartesEnMovimiento.ParteZ.Position
	local Problema1 = Bocina.ALTA1.Position - PartesEnMovimiento.ParteZ1.Position 
	local mg = Problema.Magnitude
	local mg1 = Problema1.Magnitude

	Servicio.RenderStepped:Connect(function()
		local loundress = Sound.PlaybackLoudness
		local Resta = RazonZ * loundress
		local Resta1 = RazonZ1 * loundress
		for i,v in pairs(PartesEnMovimiento:GetChildren()) do
			v.Orientation = Handle.Orientation
		end
		local TamaAdquiZ = SizeParteZ - (RazonZ * loundress)
		local TamaAdquiZ1 = SizeParteZ1 - (RazonZ1 * loundress)
		local PosiAdquiZ = RazonZ * loundress
		local PosiAdquiZ1 = RazonZ * loundress
		local ParteZPosition = Bocina.ALTA.Position + Bocina.ALTA.CFrame.LookVector * (mg+ Resta)
		local ParteZ1Position = Bocina.ALTA1.Position + Bocina.ALTA1.CFrame.LookVector * (mg1 + Resta1)
		PartesEnMovimiento.ParteZ.Size = Vector3.new(PartesEnMovimiento.ParteZ.Size.X,TamaAdquiZ,PartesEnMovimiento.ParteZ.Size.Z)
		PartesEnMovimiento.ParteZ1.Size  = Vector3.new(PartesEnMovimiento.ParteZ1.Size.X,TamaAdquiZ,PartesEnMovimiento.ParteZ1.Size.Z)
		PartesEnMovimiento.ParteM.Position = Bocina.ALTA.Position + Bocina.ALTA.CFrame.LookVector * Resta
		PartesEnMovimiento.ParteM1.Position = Bocina.ALTA1.Position + Bocina.ALTA1.CFrame.LookVector *  Resta1
		PartesEnMovimiento.ParteZ.Position = ParteZPosition 
		PartesEnMovimiento.ParteZ1.Position = ParteZ1Position
	end)
end
function module.Vocina(v)
	local service = game:GetService("RunService")
	local Sound = game.Workspace.SoundGroup.Sonido
	local Brillo = v.Light.Light.Brightness
	local razon = Brillo/game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales.Maximo.Value
	local Transparencia = v.Light.Transparency
	local raon1 = Transparencia/game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales.Maximo.Value
	service.RenderStepped:Connect(function()
		local necesidadparaacti = game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales.Maximo.Value - (game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales.Promedio.Value * .2)
		Brillo = razon  * Sound.PlaybackLoudness
		Transparencia = razon *  Sound.PlaybackLoudness
		if Sound.PlaybackLoudness > necesidadparaacti then
			v.Light.Light.Brightness = Brillo
			v.Light.Transparency = 1 - Transparencia
		else
			v.Light.Transparency = 1
			v.Light.Light.Brightness = 0
		end

	end)

end
function module.DJLight(v)
	local service = game:GetService("RunService")
	local Sound = game.Workspace.SoundGroup.Sonido
	local Brillo = v.Light.Light.Brightness
	local razon = Brillo/1000
	local Transparencia = v.Light.Transparency
	local raon1 = Transparencia/1000
	service.RenderStepped:Connect(function()

		Brillo = razon  * Sound.PlaybackLoudness
		Transparencia = razon *  Sound.PlaybackLoudness
		if Sound.PlaybackLoudness > game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales.Promedio.Value then
			v.Light.Light.Brightness = Brillo
			v.Light.Transparency = 1 - Transparencia
		else
			v.Light.Transparency = 1
			v.Light.Light.Brightness = 0
		end

	end)

end
function module.MaquinaDeHumo(v)
	local Podder = true
	local Service = game:GetService("RunService")

	Service.RenderStepped:Connect(function()
		local Sound = game.Workspace.SoundGroup.Sonido
		local Ruido = Sound.PlaybackLoudness * 1
		local necesidad = game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales.Maximo.Value - (game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales.Maximo.Value * 0.1)
		if Ruido > necesidad then
			if Podder == true then
				Podder = false
				v.Body.Sound:Play()
				local Parte = v.Body.LightE
				Parte.SpotLight.Color = Parte.Color
				v.Body.LightE.ParticleEmitter.Enabled = true
				v.Body.LightE.SpotLight.Enabled = true
				wait(8.647)
				v.Body.Sound:Stop()
				v.Body.LightE.ParticleEmitter.Enabled = false
				v.Body.LightE.SpotLight.Enabled = false
				wait(6)
				Podder = true
			end
		end
	end)
end
function module.SizeBOla(v)
	local Size = v.Size

	local Servicio = game:GetService("RunService")

	Servicio.RenderStepped:Connect(function()
		local razon = 5/1000
		local Sonido = game.Workspace.SoundGroup.Sonido
		local tamaoAgregado = razon * Sonido.PlaybackLoudness
		v.Size = Vector3.new(5 + tamaoAgregado,5 + tamaoAgregado,5 + tamaoAgregado)
	end)

end
function module.Fire(v)
	local Pudiente = false
	local service = game:GetService("RunService")
	local Sound = game.Workspace.SoundGroup.Sonido
	local Tweien = game:GetService("TweenService")
	local position = v.FireBalls.Part.Position
	local Informacion = TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,true,0)

	local final = {
		Position = position + Vector3.new(0,6,0)
	}
	local track = Tweien:Create(v.FireBalls.Part,Informacion,final)
	service.RenderStepped:Connect(function()
		local NecesidadParaActivar = game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales.Maximo.Value + ( game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales.Promedio.Value * 0.3)

		if Sound.PlaybackLoudness >  NecesidadParaActivar then

			if Pudiente == false then
				Pudiente = true
				track:Play()
				v.FireBalls.Part.Fire.Enabled = true
				wait(1)
				v.FireBalls.Part.Fire.Enabled = false
				wait(4)
				Pudiente = false
			end
		end
	end)
	game.Workspace.SoundGroup.Sonido.Loaded:Connect(function()
		track:Play()
		v.FireBalls.Part.Fire.Enabled = true
		wait(1)
		v.FireBalls.Part.Fire.Enabled = false
		wait(4)
	end)
end
function module.MesaDJ(v)
	local Servicio = game:GetService("RunService")
	Servicio.RenderStepped:Connect(function()
		local Razon = 1/game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales.Maximo.Value
		local Sonido = game.Workspace.SoundGroup.Sonido
		local transparencya = 1 - (Razon * Sonido.PlaybackLoudness)
		v.Transparency = transparencya
	end)
end
function module.Lasers(v)
	local contador = 0
	local Pudiente = true
	local Servicio = game:GetService("RunService")
	Servicio.RenderStepped:Connect(function()
		local Maximo = game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales.Maximo.Value
		local Sonido = game.Workspace.SoundGroup.Sonido.PlaybackLoudness
		if Sonido > Maximo then
			if Pudiente == true then
				Pudiente = false
				contador = contador + 1
				if contador > 3 then

					contador = 1
				end
				if contador == 1 then
					local x = math.random(0,255)
					local y = math.random(0,255)
					local z = math.random(0,255)
					for i,Laser in pairs(v.S1:GetChildren()) do
						Laser.Beam.Enabled = true
						Laser.Laer.Color = Color3.new(x,y,z)
						local colorKeypoints = {
							ColorSequenceKeypoint.new(0,Laser.Laer.Color),
							ColorSequenceKeypoint.new(1,Laser.Laer.Color)
						}
						Laser.Beam.Color = ColorSequence.new(colorKeypoints)

					end 
					wait(0.3)
					for i,Laser in pairs(v.S1:GetChildren()) do
						Laser.Beam.Enabled = false
						Laser.Laer.Color = Color3.new(0, 0, 0)
					end 
				end
				if contador == 2 then
					local x = math.random(0,255)
					local y = math.random(0,255)
					local z = math.random(0,255)
					for i,Laser in pairs(v.S2:GetChildren()) do
						Laser.Laer.Color = Color3.new(x,y,z)
						Laser.Beam.Enabled = true
						local colorKeypoints = {
							ColorSequenceKeypoint.new(0,Laser.Laer.Color),
							ColorSequenceKeypoint.new(1,Laser.Laer.Color)
						}
						Laser.Beam.Color = ColorSequence.new(colorKeypoints)
					end 
					wait(0.3)
					for i,Laser in pairs(v.S2:GetChildren()) do
						Laser.Laer.Color = Color3.new(0, 0, 0)
						Laser.Beam.Enabled = false
						local colorKeypoints = {
							ColorSequenceKeypoint.new(0,Laser.Laer.Color),
							ColorSequenceKeypoint.new(1,Laser.Laer.Color)
						}
						Laser.Beam.Color = ColorSequence.new(colorKeypoints)
					end 
				end
				if contador == 3 then
					local x = math.random(0,255)
					local y = math.random(0,255)
					local z = math.random(0,255)
					for i,Laser in pairs(v.S3:GetChildren()) do
						Laser.Laer.Color = Color3.new(x,y,z)
						Laser.Beam.Enabled = true
					end 
					wait(0.3)
					for i,Laser in pairs(v.S3:GetChildren()) do
						Laser.Beam.Enabled = false
						Laser.Laer.Color = Color3.new(0, 0, 0)
					end 
				end


				Pudiente = true
			end
		end
	end)
end
function module.Reflectores(v)
	local posivilodad = false
	local Servicio = game:GetService("RunService")
	Servicio.RenderStepped:Connect(function()

		local Sonido = game.Workspace.SoundGroup.Sonido
		local necesidad = game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales.Maximo.Value - (game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales.Promedio.Value * .2)
		if Sonido.PlaybackLoudness > necesidad  then

			v.Laer.Transparency = 0	
			v.Beam.Enabled  = true

		else
			v.Beam.Enabled  = false
			v.Laer.Transparency = 0	
			v.Laer.Transparency = 1

		end

	end)
end
function module.PistaBaile(v)
	local lasers = v.Lasers:GetChildren()
	local contador = 0
	local Pudiente = true
	local Servicio = game:GetService("RunService")
	Servicio.RenderStepped:Connect(function()
		local Maximo = game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales.Maximo.Value
		local Sonido = game.Workspace.SoundGroup.Sonido.PlaybackLoudness
		if Sonido > Maximo then
			if Pudiente == true then
				Pudiente = false
				for i,laser in pairs(lasers) do
					laser.BrickColor = BrickColor.Random()
				end
				wait(0.3)
				Pudiente = true
			end
		end
	end)
end

function module.All()
	local bocinas = game.Workspace.SistemasDeSonido.Bocinas:GetChildren()
	local FocosWhite = game.Workspace.SistemasDeSonido.LucesRTM:GetChildren()
	local MaquinasDeHumo = game.Workspace.SistemasDeSonido.Maquinas:GetChildren()
	local Pelotas = game.Workspace.SistemasDeSonido.Pselotas:GetChildren()
	local DjLights = game.Workspace.SistemasDeSonido.DJlight:GetChildren()
	local FUego = game.Workspace.SistemasDeSonido.MakinasDeFuego:GetChildren()
	local MesaDjj = game.Workspace.SistemasDeSonido.MesaDJ.REMIX:GetChildren()
	local lasers = game.Workspace.SistemasDeSonido.LaserLap
	local reflectores = game.Workspace.SistemasDeSonido.Proyectores:GetChildren()
	local pistaDeBaille = game.Workspace.SistemasDeSonido.PistaBaile:GetChildren()
	for i,v in pairs(bocinas) do

		module.AltaVoz(v)
	end
	for i,v in pairs(FocosWhite) do
		module.Vocina(v)
	end
	for i,v in pairs(MaquinasDeHumo) do
		module.MaquinaDeHumo(v)
	end

	for i,v in pairs(Pelotas) do
		module.SizeBOla(v)
	end

	for i,v in pairs(DjLights) do
		module.DJLight(v)
	end
	for i,v in pairs(FUego) do
		module.Fire(v)
	end
	for i,v in pairs(MesaDjj) do
		module.MesaDJ(v)
	end
	for i,v in pairs(reflectores) do
		module.Reflectores(v)
	end
	for i,v in pairs(pistaDeBaille) do
		module.PistaBaile(v)
	end
	module.Lasers(lasers)
end
return module
