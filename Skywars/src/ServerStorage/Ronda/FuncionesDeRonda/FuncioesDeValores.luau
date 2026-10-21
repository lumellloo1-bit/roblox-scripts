local ValuesRound = {}

function ValuesRound.EnPartida(ValDeRod)
	local Value = Instance.new("BoolValue",ValDeRod)
	Value.Name = "EnPartida"
	Value.Value = false
	local EnLobby = Instance.new("BoolValue",ValDeRod)
	EnLobby.Name  = "EnLobby"
	EnLobby.Value = true
end
function ValuesRound.Tools(Lugar)
	local Block = Instance.new("StringValue",Lugar)
	Block.Name = "Block"
	Block.Value = "Wood"
	local Sword = Instance.new("StringValue",Lugar)
	Sword.Name = "Sword"
	Sword.Value = "Wood"
	local Arrow = Instance.new("StringValue",Lugar)
	Arrow.Name = "Bow"
	Arrow.Value = "Wood"
	local pickaxe = Instance.new("StringValue",Lugar)
	pickaxe.Name = "Picaxe"
	pickaxe.Value = "Wood"
	local Potions = Instance.new("Folder",Lugar)
	Potions.Name = "Potions"
	local Armor = Instance.new("StringValue",Lugar)
	Armor.Name = "Armor"
	Armor.Value = " "
end
function ValuesRound.Contadores(Lugar)
	local Bloques = Instance.new("IntValue",Lugar)
	Bloques.Name = "NumberBlocks"
	Bloques.Value = 0

end
return ValuesRound
