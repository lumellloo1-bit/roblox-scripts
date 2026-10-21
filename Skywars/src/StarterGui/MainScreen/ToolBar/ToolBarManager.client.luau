--//Services//--

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

--//Variables//--

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local StarterPack = Player:WaitForChild("Backpack")

local MainFrame = script.Parent
local ButtonModel = script.Parent:WaitForChild("ButtonModel")
local SelectSFX = MainFrame:FindFirstAncestorOfClass("ScreenGui"):WaitForChild("SelectSFX")


local Humanoid = Character:WaitForChild("Humanoid")

local KeyBinds = {
	Enum.KeyCode.One,
	Enum.KeyCode.Two,
	Enum.KeyCode.Three,
	Enum.KeyCode.Four,
	Enum.KeyCode.Five,
	Enum.KeyCode.Six,
	Enum.KeyCode.Seven,
	Enum.KeyCode.Eight,
	Enum.KeyCode.Nine
}

------------------------------------------------------------------------------

local ToolsDePersonaje = {}
local ToolEquipada

local CurrentTool = nil
local CurrentButton = nil

--//Coding//--

local function ToggleTool(Tool, Button)
	if Tool == CurrentTool then 
		CurrentTool = nil
		Humanoid:UnequipTools()
		CurrentButton:TweenSize(UDim2.fromScale(1, 1), Enum.EasingDirection.In, Enum.EasingStyle.Quad, .08, true)
		CurrentButton = nil
		
	else
		if CurrentTool then 
			SelectSFX:Play()
			
			Humanoid:UnequipTools()
			CurrentTool = Tool
			Humanoid:EquipTool(Tool)
			Button:TweenSize(UDim2.fromScale(1.1, 1.1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, .08, true)
			CurrentButton:TweenSize(UDim2.fromScale(1, 1), Enum.EasingDirection.In, Enum.EasingStyle.Quad, .08, true)
			CurrentButton = Button
			
		else
			SelectSFX:Play()
			
			CurrentButton = Button
			CurrentTool = Tool
			CurrentButton:TweenSize(UDim2.fromScale(1.1, 1.1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, .08, true)
			Humanoid:EquipTool(Tool)
		end
	end
end





StarterPack.ChildAdded:Connect(function(Tool)
	if Tool ~= ToolEquipada then
		local Button = ButtonModel:Clone()
		local ToolConfiguration = Tool:WaitForChild("Configuration") 
		local Image = ToolConfiguration:WaitForChild("Image").Value
		local LayoutOrder = ToolConfiguration:WaitForChild("LayoutOrder").Value
		Button.Frame.Icon.Image = Image
		Button.BindVisual.Text = LayoutOrder
		Button.Parent = MainFrame
		Button.Visible = true
		Button.LayoutOrder = LayoutOrder
		local ConeccionDeA = Button.MouseButton1Down:Connect(function()
			ToggleTool(Tool, Button)
		end)
		local ConeccionDeB = UIS.InputBegan:Connect(function(Input, UsingUi)
			if UsingUi then return end;
			if Input.KeyCode == KeyBinds[LayoutOrder] then 
				ToggleTool(Tool, Button)
			end
		end)
		
		Tool.Changed:Connect(function(Cambio)
			if Cambio == "Parent" then
				if not Tool.Parent  then
					 CurrentTool = nil
					 CurrentButton = nil
					Button:Destroy()
					ConeccionDeA:Disconnect()
					ConeccionDeB:Disconnect()
				end
			end

		end)
	end
end)

StarterPack.ChildRemoved:Connect(function(Tool)
	if Tool.Parent then
		ToolEquipada = Tool
	end
end)
