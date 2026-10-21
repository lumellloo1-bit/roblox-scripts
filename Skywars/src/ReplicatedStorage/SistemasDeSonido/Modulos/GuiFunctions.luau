
local TweenService = game:GetService("TweenService")
local ReplicatedStorasge = game:GetService("ReplicatedStorage")
local SistemasDeSonidoReplicated = ReplicatedStorasge:WaitForChild("SistemasDeSonido")
local SonidosEnFila = SistemasDeSonidoReplicated:WaitForChild("SonidosEnFila")



local TiempoDeTween = 0.01
local InfoGuisTweenPasar = TweenInfo.new(0.25,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,true)
local FInal = {Value = 1}
local MarketplaceService = game:GetService("MarketplaceService")
local SonidosDePromediado = workspace:WaitForChild("SistemasDeSonido"):WaitForChild("Verificadores"):WaitForChild("SonidosDePromediado")


local module = {}



function module.TweenOut(CualquierGui,GrandeX,GrandeY)
	CualquierGui:TweenSize(
		UDim2.fromScale(GrandeX,GrandeY),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Linear,
		TiempoDeTween
	)
end
function module.TweenIn(CualquierGui,GrandeX,GrandeY)
	CualquierGui:TweenSize(
		UDim2.fromScale(GrandeX,GrandeY),
		Enum.EasingDirection.In,
		Enum.EasingStyle.Linear,
		TiempoDeTween
	)
end


function module.AbrirGuiAnimation(v,NormalSize,tiempoDeTween)
	local InfoAbrirCerrarGuis = TweenInfo.new(tiempoDeTween,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false)
	local Tabla = {Size = NormalSize}
	local Track = TweenService:Create(v,InfoAbrirCerrarGuis,Tabla)
	Track:Play()
end

function module.ChecarId(PantallaDeCargaFunction,TextBoxDePedirCanciones,tipoDeId,RemoteVerificadorDeAudio,EsperaRemote,EsperaDeVerificacion,SonidoDePrueba)
	PantallaDeCargaFunction(true)
	local PrimerFiltro = false
	local SegundoFiltro = false
	local Input = TextBoxDePedirCanciones
	local ID = table.concat(string.split(Input," "),"")
	local IDCorrecto,IDfallido = pcall(function()
		tipoDeId	= MarketplaceService:GetProductInfo(ID,Enum.InfoType.Asset)
	end)
	if IDCorrecto then
		if tipoDeId.AssetTypeId == 3 then
			PrimerFiltro = true
		else
			PrimerFiltro = false
		end
	else
		PrimerFiltro = false
	end
	if PrimerFiltro == true then
		RemoteVerificadorDeAudio:FireServer(ID)
		EsperaRemote = RemoteVerificadorDeAudio.OnClientEvent:Connect(function(SegundoFiltroRemote)
			SegundoFiltro = SegundoFiltroRemote
			if EsperaDeVerificacion.Value == true then
				EsperaDeVerificacion.Value = false
			else
				EsperaDeVerificacion.Value = true
			end

			EsperaRemote:Disconnect()
		end)
	else
		PantallaDeCargaFunction(false)
		return false
	end
	EsperaDeVerificacion.Changed:Wait()
	if SegundoFiltro == true then
		local Correcto,Incorrecto = pcall(function()
			SonidoDePrueba.SoundId = "rbxassetid://"..ID
		end)
		
		if SonidoDePrueba.IsLoaded == false then
			SonidoDePrueba.Changed:Wait()
		end

		if SonidoDePrueba.TimeLength > 0 then
			PantallaDeCargaFunction(false)
			local paso = true
			SonidoDePrueba.SoundId = ""
			table.foreach(SonidosEnFila:GetDescendants(),function(_,SonidoEnFila)
				if SonidoEnFila:IsA("Sound") then
					if SonidoEnFila.SoundId == "rbxassetid://"..ID then
						paso = false
					end
					
				end
			end)
			if paso == true then
				return ID
			else
				return false
			end
			
			
		else
			PantallaDeCargaFunction(false)
			SonidoDePrueba.SoundId = ""
			return false

		end

	else
		PantallaDeCargaFunction(false)
		return false

	end

end



function module.MediaDeLaCancion(ID,PDC)
	local resultado = module.Sumatorias(ID,PDC)
	return resultado
end
return module
