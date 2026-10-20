local contador = script.Parent.Parent.Contador

script.Parent.Changed:Connect(function(change)
	if change == true then
		script.Parent.Parent.Constrains.Motor.TargetAngle = 90
		script.Parent.Parent.Close.ProximityPrompt.ActionText = "Close"
		script.Parent.Parent.Open.ProximityPrompt.ActionText = "Close"
		contador.Value = 0 
	else
		script.Parent.Parent.Constrains.Motor.TargetAngle = 0
		script.Parent.Parent.Close.ProximityPrompt.ActionText = "Open"
		script.Parent.Parent.Open.ProximityPrompt.ActionText = "Open"
	end
end)
