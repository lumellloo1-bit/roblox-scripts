--//SERVICES//--
local ReplicatedStorage = game:GetService("ReplicatedStorage")


--//Instances//--
local AdminFrame = script.Parent
local AdminScreen = AdminFrame.Parent
local RemoteEvens = ReplicatedStorage:WaitForChild("RemoteEvents")
local Functions = RemoteEvens:WaitForChild("Functions")
local AdminEvent = Functions:WaitForChild("AdminEvent")
local OpenButton = AdminScreen:WaitForChild("TextButton")
local AdornFrame = AdminFrame:WaitForChild("AdonrFrame")
local ScrollingAdmin = AdornFrame:WaitForChild("ScrollingFrame")
local ScrollingLocal = AdornFrame:WaitForChild("LocalChanges")
local Abierto = false

table.foreach(ScrollingAdmin:GetChildren(),function(_,Frame)
	task.spawn(function()
		if not Frame:IsA("Frame") then return end
		local Boton = Frame:WaitForChild("TextButton")
		local Box = Frame:WaitForChild("TextBox")
		Boton.MouseButton1Up:Connect(function()
			local ValorModificado = Frame.Name
			local ValorDeseado =  table.concat(string.split(Box.Text," "),"")
			Box.Text = "ENTER NUMBER"
			AdminEvent:FireServer(ValorDeseado,ValorModificado,false)
		end)
	end)
	
end)
table.foreach(ScrollingLocal:GetChildren(),function(_,Frame)
	task.spawn(function()
		if not Frame:IsA("Frame") then return end
		local Boton = Frame:WaitForChild("TextButton")
		local Box = Frame:WaitForChild("TextBox")
		Boton.MouseButton1Up:Connect(function()
			local ValorModificado = Frame.Name
			local ValorDeseado =  table.concat(string.split(Box.Text," "),"")
			Box.Text = "ENTER NUMBER"
			AdminEvent:FireServer(ValorDeseado,ValorModificado,true)
		end)
	end)

end)
OpenButton.MouseButton1Up:Connect(function()
	if Abierto == false then
		Abierto = true
		AdminFrame:TweenPosition(UDim2.fromScale(0.055,0.018), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 1, true)
	else
		Abierto = false
		AdminFrame:TweenPosition(UDim2.fromScale(-0.45,0.018), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 1, true)
	end
end)
