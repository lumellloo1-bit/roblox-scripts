local Puerta = script.Parent.Parent.Parent
local p1 = Puerta.P1
local p2 = Puerta.P2

tienpoAbrir = 10
local servicio = game:GetService("TweenService")
local info = TweenInfo.new(tienpoAbrir,Enum.EasingStyle.Exponential,Enum.EasingDirection.InOut,0,false,0)
local value = script.Parent.Parent.Abierto

local Pudiente = true
local finalp1 = {
	Position = p1.Position + Vector3.new(-5.001,0,7.308),
	Orientation  = p1.Orientation + Vector3.new(0,107.85,0)
}
local InicioP1 = {
	Position = p1.Position,
	Orientation = p1.Orientation 
}

local finalp2 = {
	Position = p2.Position + Vector3.new(-4.901,0,-5.415),
	Orientation = p2.Orientation + Vector3.new(0,-87.35,0)
}
local Inciiop2 = {
	Position  = p2.Position,
	Orientation = p2.Orientation 
}
script.Parent.MouseClick:Connect(function()
	if Pudiente == true then
		Pudiente = false
		if value.Value == false then
			local abriendo = servicio:Create(p1,info,finalp1)
			abriendo:Play()
			local abriendo1 = servicio:Create(p2,info,finalp2)
			abriendo1:Play()
			value.Value = true
		else
			local abriendo = servicio:Create(p1,info,InicioP1)
			abriendo:Play()
			local abriendo1 = servicio:Create(p2,info,Inciiop2)
			abriendo1:Play()
			value.Value = false
		end
		wait(tienpoAbrir)
		Pudiente = true
	end
	
end)
