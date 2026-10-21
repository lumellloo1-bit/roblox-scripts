--//Services//--

local Players = game:GetService("Players")
local DataStore = game:GetService("DataStoreService")

--//Variables//--

local CoinsStore = DataStore:GetOrderedDataStore("Coins")
local WinsStore = DataStore:GetOrderedDataStore("Wins")
local KillsStore = DataStore:GetOrderedDataStore("Kills")
--//coding//--

game:BindToClose(function()
	task.wait(1)
end)

local function Get(Key, Store)
	local Succes, Value = pcall(function()
		return Store:GetAsync(Key)
	end)
	
	if Succes then return Value or 0 else return "null" end
end

local function Save(Key, Store, Value)
	local Succes, Error = pcall(function()
		Store:SetAsync(Key, Value)
	end)
	
	if not Succes then warn("Error while saving in key ", Key) end
end

Players.PlayerAdded:Connect(function(Player)
	local Leaderstats = Instance.new("Folder", Player); Leaderstats.Name = "leaderstats"
	local GlobalKey = tostring(Player.UserId).. "_Key"
	
	local PlayerData = {
		["Coins"] = Get(GlobalKey, CoinsStore),
		["Wins"] = Get(GlobalKey, WinsStore),
		["Kills"] = Get(GlobalKey, KillsStore)
	}
	
	for Type, Value in pairs(PlayerData) do 
		if Value == "null" then Player:SetAttribute("Kicked", true); Player:Kick("Hubo un error al cargar tus datos, haz rejoin:)") return end
		
		local Stat = Instance.new("IntValue", Leaderstats)
		Stat.Name = Type
		Stat.Value = Value
	end
end)

Players.PlayerRemoving:Connect(function(Player)
	if Player:GetAttribute("Kicked") then return end;
	if game.VIPServerOwnerId ~= 0 then return end
	local GlobalKey = tostring(Player.UserId).. "_Key"
	
	local Leaderstats = Player:FindFirstChild("leaderstats")
	if not Leaderstats then return end;
	
	for _, Stat in pairs(Leaderstats:GetChildren()) do 
		Save(GlobalKey, DataStore:GetOrderedDataStore(Stat.Name), Stat.Value)
	end
end)
