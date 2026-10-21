local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")


local StoreGui = script.Parent
local StoreFrame = script.Parent:WaitForChild("StoreFrame")
local SobreSoun = script:WaitForChild("Sobre")
local ClickSound = script:WaitForChild("Click")
local FramePacks = StoreFrame:WaitForChild("Store"):WaitForChild("FramePacks")
local Player = Players.LocalPlayer
local ValoresDeRonda = Player:WaitForChild("ValoresDeRonda")
local ToolValues = ValoresDeRonda:WaitForChild("ToolValues")
--SeparacionDistintasGuis--
local SwordsFrame = script.Parent:WaitForChild("SwordFrame")
local ArrowsFrame = script.Parent:WaitForChild("BowFrame")
local PicaxeFrame = script.Parent:WaitForChild("PicaxeFrame")
local BlcksFrame = script.Parent:WaitForChild("BlockFrame")
local PotionsFrame = script.Parent:WaitForChild("PotionsFrame")
local ArmorsFrame = script.Parent:WaitForChild("ArmorFrame")

--RemoteEvents--
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local RemoteStore = RemoteEvents:WaitForChild("RemoteStore")
local RemoteCompra = RemoteStore:WaitForChild("Buy")

--ButtonsStoreFrame--
local ButonDeAbrirPociones = FramePacks:WaitForChild("PotionsButton")
local BotonDeAbrirEspadas = FramePacks:WaitForChild("SwordButton")
local BotonDeAbrirArcos = FramePacks:WaitForChild("BowButton")
local BotonDeAbrirPicos = FramePacks:WaitForChild("PicaxeButton")
local BotonDeAbrirBloques = FramePacks:WaitForChild("BlockButton")
local BotonDeAbrirArmor = FramePacks:WaitForChild("ArmorButton")
--SwordsFrameInstances--
local Swords = SwordsFrame:WaitForChild("Sword")
local SwordsInfoFrame = Swords:WaitForChild("InfoFrame")
local ScrolligBuySwords = Swords:WaitForChild("ScrollingBuySword")
local ScrolligPropetySwords = Swords:WaitForChild("ScrollingPropetiesSword")

--ArrowFrameInstances--
local Arrows = ArrowsFrame:WaitForChild("Bow")
local ArrowaInfoFrame = Arrows:WaitForChild("InfoFrameaArrows")
local ScrollingBuyArros = Arrows:WaitForChild("ScrollingBuyBow")
local ScrolligPropetyArrows = Arrows:WaitForChild("ScrolligPropetysArrow")

--PicaxeFrameInstnaces--
local Picaxes = PicaxeFrame:WaitForChild("Picaxe")
local PicaxesInfoFrame = Picaxes:WaitForChild("InfoFrame")
local ScrollingBuyPicaxes = Picaxes:WaitForChild("ScrollingBuyPicaxe")
local ScrollingPropetyPicaxes = Picaxes:WaitForChild("ScrollingPropetiesPicaxe")
--BlockFrameInstances--
local Blocks = BlcksFrame:WaitForChild("Block")
local BlocksInfoFrame = Blocks:WaitForChild("InfoFrame")
local ScrollingBuyBloques = Blocks:WaitForChild("ScrollingBuyBlock")
local ScrollingPropetyBloques = Blocks:WaitForChild("ScrollingPropetiesBlock")
--PotionsFrameInstances--
local Potions = PotionsFrame:WaitForChild("Potions")
local PotionsInfoFrame = Potions:WaitForChild("InfoFrame")
local ScrolligBuyPotions = Potions:WaitForChild("ScrollingBuyPotions")
local ScrollingPropetyPotions = Potions:WaitForChild("ScrollingPropetiesPotions")
--ArmorFrameInstances--
local Armors = ArmorsFrame:WaitForChild("Armor")
local ArmorsInfoFrame = Armors:WaitForChild("InfoFrame")
local ScrollingBuyArmors = Armors:WaitForChild("ScrollingBuyArmor")
local ScrollingPropetyArmors = Armors:WaitForChild("ScrollingPropetiesArmor")

--SwordFrameButtons--
local BotonDeInfoSwords = SwordsFrame:WaitForChild("Info")
local BotonDePropiedadesSwords = SwordsFrame:WaitForChild("Propiedades")
local BotonDeRegresarSwords = SwordsFrame:WaitForChild("Regresar")
local BotonDeStoreSwords = SwordsFrame:WaitForChild("Store")
--ArrowFrameButtons--
local BotonDeInfoArrows = ArrowsFrame:WaitForChild("Info")
local BotonDePropiedadesArrows = ArrowsFrame:WaitForChild("Propiedades")
local BotonDeRegresarArrows = ArrowsFrame:WaitForChild("Regresar")
local BotonDeStoreArrows = ArrowsFrame:WaitForChild("Store")
--PicaxeFrameButtons--
local BotonInfoPicaxes = PicaxeFrame:WaitForChild("Info")
local BotonDePropetyPicaxes = PicaxeFrame:WaitForChild("Propiedades")
local BotonDeRegresoPicaxes = PicaxeFrame:WaitForChild("Regresar")
local BotonDeStorePixaxe = PicaxeFrame:WaitForChild("Store")
--BlockFrameButtons--
local BotonInfoBlocks = BlcksFrame:WaitForChild("Info")
local BotonDePropetyBlocks = BlcksFrame:WaitForChild("Propiedades")
local BotonDeRegresarBloques = BlcksFrame:WaitForChild("Regresar")
local BotonDeStoreBloque = BlcksFrame:WaitForChild("Store")
--PotionsFrameButtons--
local BotonDeInfoPotions = PotionsFrame:WaitForChild("Info")
local BotonDePropetysPotions = PotionsFrame:WaitForChild("Propiedades")
local BotonDeRegresarPotions = PotionsFrame:WaitForChild("Regresar")
local BotonDeStorePotions = PotionsFrame:WaitForChild("Store")
--ArmorsFrameButtos--
local BotonDeInfoArmor = ArmorsFrame:WaitForChild("Info")
local BotonDePropetysArmors = ArmorsFrame:WaitForChild("Propiedades")
local BotonDeRegresarArmors = ArmorsFrame:WaitForChild("Regresar")
local BotonDeStoreArmors = ArmorsFrame:WaitForChild("Store")
--Values 
local ValorDeAbrirCerrar = script:WaitForChild("Abir")
local ValorDeRotacion = script:WaitForChild("ValorDeRotacion")
local ContadorDeVesesCambiadas = false
local TiempoDeTween = 0.01
local Info = TweenInfo.new(6,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,-1,false,0)
local FInal = {Value = 1}

--Funciones--
local function TweenOut(CualquierGui,GrandeX,GrandeY)
	CualquierGui:TweenSize(
		UDim2.fromScale(GrandeX,GrandeY),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Linear,
		TiempoDeTween
	)
end
local function TweenIn(CualquierGui,GrandeX,GrandeY)
	CualquierGui:TweenSize(
		UDim2.fromScale(GrandeX,GrandeY),
		Enum.EasingDirection.In,
		Enum.EasingStyle.Linear,
		TiempoDeTween
	)
end
local function QuitarSwordsFrame()
	SwordsFrame.Visible = false
	SwordsInfoFrame.Visible = false
	ScrolligPropetySwords.Visible = false
	ScrolligBuySwords.Visible = false
end
local function QuitarArrowsFrame()
	ArrowsFrame.Visible = false
	ArrowaInfoFrame.Visible = false
	ScrolligPropetyArrows.Visible = false
	ScrollingBuyArros.Visible = false
end
local function QuitarPicaxeFrame()
	PicaxeFrame.Visible = false
	PicaxesInfoFrame.Visible = false
	ScrollingPropetyPicaxes.Visible = false
	ScrollingBuyPicaxes.Visible = false
end
local function QuitarBloquesFrame()
	BlcksFrame.Visible = false
	BlocksInfoFrame.Visible = false
	ScrollingPropetyBloques.Visible = false
	ScrollingBuyBloques.Visible = false
end
local function QuitarPotionsFrame()
	PotionsFrame.Visible = false
	PotionsInfoFrame.Visible = false
	ScrollingPropetyPotions.Visible = false
	ScrolligBuyPotions.Visible = false
end
local function QuitarArmorsFrame()
	ArmorsFrame.Visible = false
	ArmorsInfoFrame.Visible = false
	ScrollingPropetyArmors.Visible = false
	ScrollingBuyArmors.Visible = false
end
local function FontText()
	for i,v in pairs(StoreGui:GetDescendants()) do
		local Propety 
		local Ok,Error = pcall(function()
			Propety = v.Font
		end)
		if Propety then
			v.Font = Enum.Font.Creepster

			delay(0,function()
				v.Font = Enum.Font.DenkOne

			end)
		end
	end
end
for i,v in pairs(StoreGui:GetDescendants()) do
	local Propety 
	local Ok,Error = pcall(function()
		Propety = v.Font
	end)
	if Propety then
		v.Font = Enum.Font.DenkOne
		delay(0.1,function()
			v.Font = Enum.Font.DenkOne

		end)
	end
end

local function CambiarDePortadaTools()
	table.foreach(ToolValues:GetChildren(),function(_,ToolV)
		local NombreEnGui = ToolV.Name.."Button"
		table.foreach(FramePacks:GetChildren(),function(_,FramePck)
			if FramePck.Name == NombreEnGui then
				if ToolV.Name ~= "Potions"  then
					local FrameDeTool = StoreGui:FindFirstChild(ToolV.Name.."Frame")
					local Carpeta = FrameDeTool:FindFirstChild(ToolV.Name)
					local Scrolling = Carpeta:FindFirstChild("ScrollingBuy"..ToolV.Name)
					local Deseado = Scrolling:FindFirstChild(ToolV.Value)
					local UI = Deseado:FindFirstChild("UI")
					table.foreach(UI:GetDescendants(),function(_,ColorText)
						if ColorText:IsA("TextLabel") then
							if ColorText.BackgroundColor3 ~= Color3.new(1, 0, 0) then						
								FramePck.TextLabel.BackgroundColor3 = ColorText.BackgroundColor3
							end	
						end
						
					end)
					if Deseado.Name == "Ruby" then
						FramePck.TextLabel.BackgroundColor3 = Color3.new(1, 0, 0)

					end
					local UIPredeterminada = FramePck:FindFirstChildOfClass("ViewportFrame")
					if ContadorDeVesesCambiadas == false then
						local ClonacionDeui = UIPredeterminada:FindFirstChild("UICorner"):Clone()
						UIPredeterminada:Destroy()
						local Clonacion = UI:Clone()
						table.foreach(Clonacion:GetChildren(),function(_,ResidualC)
							if not ResidualC:IsA("Model") then
								ResidualC:Destroy()
							end
						end)
						Clonacion.BackgroundTransparency = .4
						Clonacion.BackgroundColor3 = Color3.new(1, 1, 1)
						Clonacion.Parent = FramePck
						Clonacion.Size = UDim2.new(1,0,1,0)
						Clonacion.Position = UDim2.new(0,0,0,0)
						ClonacionDeui.Parent = Clonacion
					else
						local Clonacion = UI
						table.foreach(Clonacion:GetChildren(),function(_,ResidualC)
							if  ResidualC:IsA("Model") then
								table.foreach(FramePck:GetDescendants(),function(_,R)
									if R:IsA("Model") then
										local ClonacionDDD = ResidualC:Clone()
										ClonacionDDD.Parent = R.Parent
										local Pds 
										R:Destroy()
										Pds = ValorDeRotacion:GetPropertyChangedSignal("Value"):Connect(function()
											ClonacionDDD:PivotTo((CFrame.Angles(0,math.rad(ValorDeRotacion.Value * 360),0)) + Vector3.new(0,5,0))
										end)
										ClonacionDDD.Destroying:Connect(function()
											Pds:Disconnect()
										end)
									end
								end)
							end
						end)
					end					
				end
			end
		end)
	end)
	ContadorDeVesesCambiadas = true

end

CambiarDePortadaTools()

local track = TweenService:Create(ValorDeRotacion,Info,FInal)
track:Play()

for i,v in pairs(StoreGui:GetDescendants()) do
	if v.ClassName == "Model" then
		ValorDeRotacion:GetPropertyChangedSignal("Value"):Connect(function()
			v:PivotTo((CFrame.Angles(0,math.rad(ValorDeRotacion.Value * 360),0)) + Vector3.new(0,5,0))
		end)
	end
end

for i,v in pairs(ToolValues:GetChildren()) do
	v.Changed:Connect(function()
		CambiarDePortadaTools()

	end)
end



table.foreach(StoreGui:GetDescendants(),function(i,v)
	if v.Name == "Coins" or v.Name == "Robux" or v.Name == "Wins" then
		v.MouseButton1Up:Connect(function()
			RemoteCompra:FireServer(v.Name,v.Parent.Parent.Name,v.Parent.Parent.Parent.Parent.Name)

		end)
	end
end)





for i,v in pairs(StoreGui:GetDescendants()) do
	if v.ClassName == "ImageButton" then
		local TamaPrincipal = v.Size
		local TamaPrincipalX = TamaPrincipal.X.Scale 
		local TamaPrinicpalY = TamaPrincipal.Y.Scale
		local TamaAumentadoX = TamaPrincipalX + (TamaPrincipalX/20)
		local TamaAumentadoY = TamaPrinicpalY + (TamaPrinicpalY/20)
		local TamaDistminuidoX = TamaPrincipalX - (TamaPrincipalX/20)
		local TamaDistminuidoY = TamaPrinicpalY - (TamaPrinicpalY/20)
		v.MouseButton1Down:Connect(function()
			TweenIn(v,TamaDistminuidoX,TamaDistminuidoY)
		end)
		v.MouseButton1Up:Connect(function()
			TweenOut(v,TamaPrincipalX,TamaPrinicpalY)
			ClickSound.TimePosition = 0.1

			ClickSound:Play()

		end)

		v.MouseLeave:Connect(function()
			TweenIn(v,TamaPrincipalX,TamaPrinicpalY)
		end)
		v.MouseEnter:Connect(function()
			SobreSoun:Play()
			TweenOut(v,TamaAumentadoX,TamaAumentadoY)
		end)
	end
	if v.ClassName == "TextButton" then
		local TamaPrincipal = v.Size
		local TamaPrincipalX = TamaPrincipal.X.Scale 
		local TamaPrinicpalY = TamaPrincipal.Y.Scale
		local TamaAumentadoX = TamaPrincipalX + (TamaPrincipalX/20)
		local TamaAumentadoY = TamaPrinicpalY + (TamaPrinicpalY/20)
		local TamaDistminuidoX = TamaPrincipalX - (TamaPrincipalX/20)
		local TamaDistminuidoY = TamaPrinicpalY - (TamaPrinicpalY/20)
		v.MouseButton1Down:Connect(function()
			TweenIn(v,TamaDistminuidoX,TamaDistminuidoY)
		end)
		v.MouseButton1Up:Connect(function()
			TweenOut(v,TamaPrincipalX,TamaPrinicpalY)
			ClickSound.TimePosition = 0.1
			ClickSound:Play()
		end)

		v.MouseLeave:Connect(function()
			TweenIn(v,TamaPrincipalX,TamaPrinicpalY)
		end)
		v.MouseEnter:Connect(function()
			SobreSoun:Play()
			TweenOut(v,TamaAumentadoX,TamaAumentadoY)
		end)
	end
end
ValorDeAbrirCerrar.Changed:Connect(function(Cambio)
	StoreGui.Enabled = true
	if Cambio == true then
		table.foreach(StoreGui:GetChildren(),function(_,FrameDador)
			if FrameDador:IsA("Frame") then
				FrameDador:TweenSize(
					UDim2.fromScale(0.8,0.8),
					Enum.EasingDirection.Out,
					Enum.EasingStyle.Quad,
					0.3
				)
			end
		end)
	else
		FontText()
		table.foreach(StoreGui:GetChildren(),function(_,FrameDador)
			if FrameDador:IsA("Frame") then
				FrameDador:TweenSize(
					UDim2.fromScale(0,0),
					Enum.EasingDirection.In,
					Enum.EasingStyle.Quad,
					0.3
				)
				delay(0.3,function()
					StoreGui.Enabled = false
				end)
			end
		end)

	end
end)
BotonDeAbrirArcos.MouseButton1Up:Connect(function()
	FontText()
	StoreFrame.Visible = false
	ArrowsFrame.Visible = true
	ScrollingBuyArros.Visible = true
end)
BotonDeAbrirEspadas.MouseButton1Up:Connect(function()
	FontText()
	StoreFrame.Visible = false
	SwordsFrame.Visible = true
	ScrolligBuySwords.Visible = true
end)
BotonDeAbrirPicos.MouseButton1Up:Connect(function()
	FontText()
	StoreFrame.Visible = false
	PicaxeFrame.Visible = true
	ScrollingBuyPicaxes.Visible = true
end)
BotonDeAbrirBloques.MouseButton1Up:Connect(function()
	FontText()
	StoreFrame.Visible = false
	BlcksFrame.Visible = true
	ScrollingBuyBloques.Visible = true
end)
ButonDeAbrirPociones.MouseButton1Up:Connect(function()
	FontText()
	StoreFrame.Visible = false
	PotionsFrame.Visible = true
	ScrolligBuyPotions.Visible = true
end)
BotonDeAbrirArmor.MouseButton1Up:Connect(function()
	FontText()
	StoreFrame.Visible = false
	ArmorsFrame.Visible = true
	ScrollingBuyArmors.Visible = true
end)

BotonDeRegresarSwords.MouseButton1Up:Connect(function()
	FontText()
	QuitarSwordsFrame()
	StoreFrame.Visible = true
end)
BotonDeRegresarArrows.MouseButton1Up:Connect(function()
	FontText()
	QuitarArrowsFrame()
	StoreFrame.Visible = true
end)
BotonDeRegresoPicaxes.MouseButton1Up:Connect(function()
	FontText()
	QuitarPicaxeFrame()
	StoreFrame.Visible = true
end)
BotonDeRegresarBloques.MouseButton1Up:Connect(function()
	FontText()
	QuitarBloquesFrame()
	StoreFrame.Visible = true
end)
BotonDeRegresarPotions.MouseButton1Up:Connect(function()
	FontText()
	QuitarPotionsFrame()
	StoreFrame.Visible = true
end)
BotonDeRegresarArmors.MouseButton1Up:Connect(function()
	FontText()
	QuitarArmorsFrame()
	StoreFrame.Visible = true
end)
BotonDeInfoSwords.MouseButton1Up:Connect(function()
	FontText()
	ScrolligBuySwords.Visible = false
	ScrolligPropetySwords.Visible = false
	SwordsInfoFrame.Visible = true
end)
BotonDeInfoArrows.MouseButton1Up:Connect(function()
	FontText()
	ScrollingBuyArros.Visible = false
	ScrolligPropetyArrows.Visible = false
	ArrowaInfoFrame.Visible = true
end)
BotonInfoPicaxes.MouseButton1Up:Connect(function()
	FontText()
	ScrollingBuyPicaxes.Visible = false
	ScrollingPropetyPicaxes.Visible = false
	PicaxesInfoFrame.Visible = true
end)
BotonInfoBlocks.MouseButton1Up:Connect(function()
	FontText()
	ScrollingBuyBloques.Visible = false
	ScrollingPropetyBloques.Visible = false
	BlocksInfoFrame.Visible = true
end)
BotonDeInfoPotions.MouseButton1Up:Connect(function()
	FontText()
	ScrolligBuyPotions.Visible = false
	ScrollingPropetyPotions.Visible = false
	PotionsInfoFrame.Visible = true
end)
BotonDeInfoArmor.MouseButton1Up:Connect(function()
	FontText()
	ScrollingBuyArmors.Visible = false
	ScrollingPropetyArmors.Visible = false
	ArmorsInfoFrame.Visible = true
end)
BotonDePropiedadesSwords.MouseButton1Up:Connect(function()
	FontText()
	ScrolligBuySwords.Visible = false
	ScrolligPropetySwords.Visible = true
	SwordsInfoFrame.Visible = false
end)
BotonDePropiedadesArrows.MouseButton1Up:Connect(function()
	FontText()
	ScrollingBuyArros.Visible = false
	ScrolligPropetyArrows.Visible = true
	ArrowaInfoFrame.Visible = false
end)
BotonDePropetyPicaxes.MouseButton1Up:Connect(function()
	FontText()
	ScrollingBuyPicaxes.Visible = false
	ScrollingPropetyPicaxes.Visible = true
	PicaxesInfoFrame.Visible = false
end)
BotonDePropetyBlocks.MouseButton1Up:Connect(function()
	FontText()
	ScrollingBuyBloques.Visible = false
	ScrollingPropetyBloques.Visible = true
	BlocksInfoFrame.Visible = false
end)
BotonDePropetysPotions.MouseButton1Up:Connect(function()
	FontText()
	ScrolligBuyPotions.Visible = false
	ScrollingPropetyPotions.Visible = true
	PotionsInfoFrame.Visible = false
end)
BotonDePropetysArmors.MouseButton1Up:Connect(function()
	FontText()
	ScrollingBuyArmors.Visible = false
	ScrollingPropetyArmors.Visible = true
	ArmorsInfoFrame.Visible = false
end)

BotonDeStoreSwords.MouseButton1Up:Connect(function()
	FontText()
	ScrolligBuySwords.Visible = true
	ScrolligPropetySwords.Visible = false
	SwordsInfoFrame.Visible = false
end)
BotonDeStoreArrows.MouseButton1Up:Connect(function()
	FontText()
	ScrollingBuyArros.Visible = true
	ScrolligPropetyArrows.Visible = false
	ArrowaInfoFrame.Visible = false
end)
BotonDeStorePixaxe.MouseButton1Up:Connect(function()
	FontText()
	ScrollingBuyPicaxes.Visible = true
	ScrollingPropetyPicaxes.Visible = false
	PicaxesInfoFrame.Visible = false
end)
BotonDeStoreBloque.MouseButton1Up:Connect(function()
	FontText()
	ScrollingBuyBloques.Visible = true
	ScrollingPropetyBloques.Visible = false
	BlocksInfoFrame.Visible = false
end)
BotonDeStorePotions.MouseButton1Up:Connect(function()
	FontText()
	ScrolligBuyPotions.Visible = true
	ScrollingPropetyPotions.Visible = false
	PotionsInfoFrame.Visible = false
end)
BotonDeStoreArmors.MouseButton1Up:Connect(function()
	FontText()
	ScrollingBuyArmors.Visible = true
	ScrollingPropetyArmors.Visible = false
	ArmorsInfoFrame.Visible = false
end)
