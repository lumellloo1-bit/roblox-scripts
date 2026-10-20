

script.Parent.Changed:Connect(function()
	if script.Parent.Value >10 then
		script.Parent.Parent.Abierto.Value = false
	end
end)
