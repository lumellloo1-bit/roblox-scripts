local puerta = script.Parent.Parent.Parent.Puerta
tienpoAbrir = 10
local servicio = game:GetService("TweenService")
local info = TweenInfo.new(tienpoAbrir,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut,0,false,0)
local value = script.Parent.Parent.Parent.Puerta.Abierto
local Pudiente = true
local final = {
	Position = puerta.Position + Vector3.new(-1.259,0,19.76)
}
local final1 = {
	Position = puerta.Position 
}

script.Parent.MouseClick:Connect(function()
	if Pudiente == true then
		Pudiente = false
		if value.Value == false then
			local abriendo = servicio:Create(puerta,info,final)
			abriendo:Play()
			value.Value = true
		else
			local abriendo = servicio:Create(puerta,info,final1)
			abriendo:Play()
			value.Value = false
		end
		wait(tienpoAbrir)
		Pudiente = true
	end
	
end)
