local Position = script.Parent.HumanoidRootPart.Position
local Character = script.Parent
local Humanoid = Character.Humanoid
local Animation = script.Uno
local Animation2 = script.Dos
local Animation3 = script.Tres
local Animation4 = script.Cuatro
local Animation5 = script.Cinco

local Track = Humanoid:LoadAnimation(Animation)
local Track2 = Humanoid:LoadAnimation(Animation2)
local Track3 = Humanoid:LoadAnimation(Animation3)
local Track4 = Humanoid:LoadAnimation(Animation4)
local Track5 = Humanoid:LoadAnimation(Animation5)

while true do
	wait(1)
	script.Parent:PivotTo(game.Workspace.SistemasDeSonido.PositionDJvalue.Value)
	Track:Play()
	wait(10)
	script.Parent:PivotTo(game.Workspace.SistemasDeSonido.PositionDJvalue.Value)
	Track:Stop()
	Track2:Play()
	wait(10)
	script.Parent:PivotTo(game.Workspace.SistemasDeSonido.PositionDJvalue.Value)
	Track2:Stop()
	Track3:Play()
	wait(10)
	script.Parent:PivotTo(game.Workspace.SistemasDeSonido.PositionDJvalue.Value)
	Track3:Stop()
	Track4:Play()
	wait(10)
	script.Parent:PivotTo(game.Workspace.SistemasDeSonido.PositionDJvalue.Value)
	Track4:Stop()

	script.Parent:PivotTo(game.Workspace.SistemasDeSonido.PositionDJvalue.Value)
end
