for i,v in pairs(script.Parent.Parent:GetChildren()) do
	local random = math.random(1,2)
	if random == 1 then
		v.Position = v.Position + Vector3.new(-.05,0,0)
	else
		v.Position = v.Position + Vector3.new(.05,0,0)
	end
end
