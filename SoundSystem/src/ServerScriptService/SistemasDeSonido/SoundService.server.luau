local Soud = game.Workspace.SoundGroup.Sonido
local Audios = game.Workspace.SistemasDeSonido.Audios
local Sonidos = {
	
}
local NumeroPredeterminados = 0
local Predeterminados = game.Workspace.SistemasDeSonido.EsperaAudios:GetChildren()
	

Audios.ChildAdded:Connect(function(adeed)
	local Numero = #Sonidos
	adeed:WaitForChild("Sound").Changed:Wait()
	table.insert(Sonidos,Numero + 1,adeed:WaitForChild("Sound").SoundId)
end)
local function CreatePlayerModel(PlayerUserId, Position, RigType)
	local Desc;

	local Succ, Err = pcall(function()
		Desc = game:GetService("Players"):GetHumanoidDescriptionFromUserId(PlayerUserId) 
	end)
	
	if Err then
		print(Err)
	end
	if Succ then
		local Char = game:GetService("Players"):CreateHumanoidModelFromDescription(Desc, RigType)
		Char.Parent = game.Workspace.SistemasDeSonido.Momentario
		CFrame.new(Position)
		Char.Name = game:GetService("Players"):GetNameFromUserIdAsync(PlayerUserId)



		if Char then 
			return Char
		end
	end
end

Soud.Ended:Connect(function()
	if game.ReplicatedStorage.SistemasDeSonido.Valores.Cmbio2.Value == true then 
		game.ReplicatedStorage.SistemasDeSonido.Valores.Cmbio2.Value = false
	else
		game.ReplicatedStorage.SistemasDeSonido.Valores.Cmbio2.Value = true
	end
	Soud.TimePosition = 0
	Soud.Volume = 0
	wait(2)
	Soud.Playing =  true
	Soud.Volume = 10
	local ValoresLuminicos
	local ok,errorr = pcall(function()
		local Desendientes = game.Workspace.SistemasDeSonido.Audios:GetDescendants()
		for i,v in ipairs(Desendientes) do
			if v.ClassName == "Sound" then
				if v.SoundId == Sonidos[1] then
					ValoresLuminicos = v
					break
				end
			end
		end
		Soud.SoundId =  Sonidos[1]
		table.remove(Sonidos,1)
		
	end)
	if ok then
		game.Workspace.SistemasDeSonido.Momentario.DJ:Destroy()
		local Actualidad = game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales
		Actualidad:WaitForChild("AmbientColor").Value = ValoresLuminicos.AmbientColor.Value 
		Actualidad:WaitForChild("ColorDelHumo").Value  = ValoresLuminicos.ColorDelHumo.Value 
		Actualidad:WaitForChild("ColorPunch").Value  = ValoresLuminicos.ColorPunch.Value 
		Actualidad:WaitForChild("IntencidadDelPunch").Value  = ValoresLuminicos.IntencidadDelPunch.Value 
		Actualidad:WaitForChild("IntencidadDeluzAmbien").Value  = ValoresLuminicos.IntencidadDeluzAmbien.Value 
		Actualidad:WaitForChild("ColorFuego").Value = ValoresLuminicos.ColorFuego.Value
		Actualidad.Maximo.Value = ValoresLuminicos.Promedio.Maximo.Value
		Actualidad.Promedio.Value = ValoresLuminicos.Promedio.Value
		local Char = CreatePlayerModel(
			ValoresLuminicos.Nombredeljugador.Value, --PlayerUserid
			Vector3.new(game.Workspace.SistemasDeSonido.PositionDJvalue.Value), --Position into workspace --Animation to load
			Enum.HumanoidRigType.R15 -- RigType (Compatible with the animation)
		)
		local tabla = game.Workspace.SistemasDeSonido.Momentario:GetChildren()
		tabla[1].Name = "DJ"
		Soud.TimePosition = 0
		if game.ReplicatedStorage.SistemasDeSonido.Valores.Cambio.Value == true then
			game.ReplicatedStorage.SistemasDeSonido.Valores.Cambio.Value = false
		else
			game.ReplicatedStorage.SistemasDeSonido.Valores.Cambio.Value = true
		end
		ValoresLuminicos.Parent:Destroy()
	end
	if errorr then
		NumeroPredeterminados = NumeroPredeterminados + 1
		if NumeroPredeterminados > #Predeterminados then
			NumeroPredeterminados = 1
		end
		
		Soud.SoundId = Predeterminados[NumeroPredeterminados].Sound.SoundId
		local Actualidad = game.Workspace.SistemasDeSonido.ActualAudio.ValoresActuales
		local predeterminados = Predeterminados[NumeroPredeterminados].Sound
		Actualidad:WaitForChild("AmbientColor").Value = predeterminados.AmbientColor.Value 
		Actualidad:WaitForChild("ColorDelHumo").Value  = predeterminados.ColorDelHumo.Value 
		Actualidad:WaitForChild("ColorPunch").Value  = predeterminados.ColorPunch.Value 
		Actualidad:WaitForChild("IntencidadDelPunch").Value  = predeterminados.IntencidadDelPunch.Value 
		Actualidad:WaitForChild("IntencidadDeluzAmbien").Value  = predeterminados.IntencidadDeluzAmbien.Value
		Actualidad:WaitForChild("ColorFuego").Value = predeterminados.ColorFuego.Value
		Actualidad:WaitForChild("Maximo").Value = predeterminados.Promedio.Maximo.Value
		Actualidad:WaitForChild("Promedio").Value = predeterminados.Promedio.Value
		game.Workspace.SistemasDeSonido.Momentario.DJ:Destroy()
		game.ServerStorage.SistemasDeSonido.GameStorage.DJ:Clone() .Parent = game.Workspace.SistemasDeSonido.Momentario
		game.Workspace.SistemasDeSonido.Momentario.DJ:PivotTo(game.Workspace.SistemasDeSonido.PositionDJvalue.Value)
		Soud.TimePosition = 0
		if game.ReplicatedStorage.SistemasDeSonido.Valores.Cambio.Value == true then
			game.ReplicatedStorage.SistemasDeSonido.Valores.Cambio.Value = false
		else
			game.ReplicatedStorage.SistemasDeSonido.Valores.Cambio.Value = true
		end
	end

	
end)
