local Clickeado = false

script.Parent.MouseButton1Down:Connect(function()
	if Clickeado == false then
		Clickeado = true
		local Service = game:GetService("MarketplaceService")
		local id = script.Parent.Parent.SoundID.Text
		local Sound = script.Parent.UICorner.Sound
		local Sonido

		local sus,errorde = pcall(function()
			Sonido = Service:GetProductInfo(id)
		end)
		if sus then
			if Sonido.AssetTypeId == 3 then
				script.Parent.UICorner.Sound.SoundId = "rbxassetid://".. Sonido.AssetId
				script.Parent.UICorner.Sound.Changed:Wait()
				
				if script.Parent.UICorner.Sound.IsLoaded == false and  script.Parent.UICorner.Sound.TimeLength == 0 then
					script.Parent.Parent.MensajeDeError.Text = "EL SONIDO FUE BORRADO"
					script.Parent.Parent.MensajeDeError.Visible = true
					wait(3)
					script.Parent.Parent.MensajeDeError.Visible = false
				else
					local encontrado = false
					for i,v in pairs(game.Workspace.SistemasDeSonido.Audios:GetDescendants()) do
						if v.ClassName == "Sound" then
							if v.SoundId == script.Parent.UICorner.Sound.SoundId then
								encontrado = true
								break
							end
						end
					end
					if encontrado == true then
						script.Parent.Parent.MensajeDeError.Text = "ESTE SONIDO YA SE ENCUENTRA EN LA PLAYLIST"
						script.Parent.Parent.MensajeDeError.Visible = true
						wait(3)
						script.Parent.Parent.MensajeDeError.Visible = false
						
						game.Workspace.SistemasDeSonido.GameStorage.Screens:Clone() .Parent = script.Parent.Parent.Parent.Parent
						script.Parent.Parent.Parent:Destroy()
					else
						local UnaTabla ={}
						local ended = false
						local ResultadoFinal = 0
						local Maximo = 0
						local Minimo
						script.Parent.Parent.Visible = false
						script.Parent.Parent.Parent.Parent.Buttons.Music.Visible = false
						script.Parent.Parent.Parent.Parent.Buttons.Music.Active = false
						script.Parent.UICorner.Sound.Playing = true
						script.Parent.UICorner.Sound.Ended:Connect(function()
							ended = true
						end)
						while wait() do
							if ended == false then
								table.insert(UnaTabla,1,script.Parent.UICorner.Sound.PlaybackLoudness)	

							else

								break
							end
						end
						for i,v in pairs(UnaTabla) do
							ResultadoFinal = ResultadoFinal + v
						end
						local Momentario = 0
						for i,v in pairs(UnaTabla) do
							if v > Momentario then
								Momentario = v
							end
						end

						script.Parent.Parent.Parent.Suselful.Valores.Promedio.Value = ResultadoFinal/#UnaTabla
						script.Parent.Parent.Parent.Suselful.Valores.MaximoV.Value = Momentario

						script.Parent.Parent.Parent.Parent.Buttons.Music.Visible = true
						script.Parent.Parent.Parent.Parent.Buttons.Music.Active = true
						script.Parent.Parent.Visible = false
						script.Parent.Parent.Parent.Suselful.NombreDeCancion.Text = Sonido.Name
						script.Parent.Parent.Parent.Suselful.Visible = true
						script.Parent.Parent.Parent.Parent.Screens.Suselful.Valores.IDCANCION.Value = Sonido.AssetId
					end
				end
			else
				script.Parent.Parent.MensajeDeError.Text = "EL ID QUE INSERTANSTE NO ES DE UN SONIDO"
				script.Parent.Parent.MensajeDeError.Visible = true
				wait(3)
				script.Parent.Parent.MensajeDeError.Visible = false

			end
		else
			script.Parent.Parent.MensajeDeError.Text = "No se encontro ese ID"
			script.Parent.Parent.MensajeDeError.Visible = true
			wait(3)
			script.Parent.Parent.MensajeDeError.Visible = false
		end
		
		Clickeado = false
	end
	
	
end)
