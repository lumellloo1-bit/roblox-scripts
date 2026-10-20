local servos = game.Workspace.SistemasDeSonido.Proyectores:GetChildren()

while wait(1) do
	for i,v in pairs(servos) do
		local a = math.random(-90,90)
		local b = math.random(0,90)
		local Moteores = v.Constrainst.Servos
		Moteores.MotorBasPts.TargetAngle = a
		Moteores.MotorPtsLi.TargetAngle = -b
	end
end
