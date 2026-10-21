local TiempoDeTween = 0.01
local ClickSound = script.Click
local SobreSoun = script.Sobre
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
for i,v in pairs(script.Parent:GetDescendants()) do
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
			ClickSound.TimePosition = 0.2
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
