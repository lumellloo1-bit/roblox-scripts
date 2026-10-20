local remote = game.ReplicatedStorage.SistemasDeSonido.EventosDeCanciones.EnvioDeDatos

remote.OnServerEvent:Connect(function(player,colorpunch,colorambient,intenAmbien,intenPunch,colorSmoke,Cancion,ColorFuego,promedium,masimu)
	local Folder = Instance.new("Folder",game.Workspace.SistemasDeSonido.Audios)
	Folder.Name = "Sonido"
	local Audio = Instance.new("Sound",Folder)
	local COlorPunch = Instance.new("Color3Value",Audio)
	COlorPunch.Value = colorpunch
	COlorPunch.Name = "ColorPunch"
	local ColorAmbient = Instance.new("Color3Value",Audio)
	ColorAmbient.Name = "AmbientColor"
	ColorAmbient.Value = colorambient
	local IntencidadAmbien = Instance.new("IntValue",Audio)
	IntencidadAmbien.Name = "IntencidadDeluzAmbien"
	IntencidadAmbien.Value = intenAmbien
	local IntencidadDelPunch = Instance.new("IntValue",Audio)
	IntencidadDelPunch.Name = "IntencidadDelPunch"
	IntencidadDelPunch.Value = intenPunch
	local ColorDelHumo = Instance.new("Color3Value",Audio)
	ColorDelHumo.Value = colorSmoke
	ColorDelHumo.Name = "ColorDelHumo"
	local ColorDelFuego = Instance.new("Color3Value",Audio)
	ColorDelFuego.Value = ColorFuego
	ColorDelFuego.Name = "ColorFuego"
	local JugadorName = Instance.new("StringValue",Audio)
	JugadorName.Value = player.UserId
	JugadorName.Name = "Nombredeljugador"
	local Promedio = Instance.new("NumberValue",Audio)
	Promedio.Name = "Promedio"
	Promedio.Value = promedium
	local Maximo = Instance.new("NumberValue",Promedio)
	Maximo.Name = "Maximo"
	Maximo.Value = masimu
	wait(1)
	Audio.SoundId = "rbxassetid://"..Cancion
end)
