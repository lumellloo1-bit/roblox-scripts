local tool = script.Parent
local poderActovar = false
local contador =0 
tool.Activated:Connect(function()
	
	if poderActovar == false then
		poderActovar = true
		contador = contador + 1
		
		local character = script.Parent.Parent
		local humanoid = character.Humanoid
		local track = humanoid:LoadAnimation(script.Animation)
		track:Play()
		wait(2)
		track:Stop()
		poderActovar = false
		if contador >2 then
			script.Parent:Destroy()
		end
	end
	
end)
