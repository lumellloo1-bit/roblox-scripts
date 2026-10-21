local BadgeService = game:GetService("BadgeService")
local Players = game:GetService("Players")

local BADGE_ID = 2130377069

local Badges = {
	["KillBadge1"] = 2130394403,
	["KillBadge100"] = 2130394406,
	["KillBadge1000"] = 2130394467,
	["WinBadge1"] = 2130394342,
	["WinBadge100"] = 2130394402,
	["WinBadge1000"] = 2130394400,
}
local function awardBadge(player, badgeId)
	local success, badgeInfo = pcall(function()
		return BadgeService:GetBadgeInfoAsync(badgeId)
	end)
	if success then
		local Lotiene = BadgeService:UserHasBadgeAsync(player.UserId,badgeId)
		if Lotiene == false then
			if badgeInfo.IsEnabled then
				local awardSuccess, result = pcall(function()
					BadgeService:AwardBadge(player.UserId, badgeId)
				end)
			end
		end

	end
end

local function onPlayerAdded(player)
	local Lotiene = BadgeService:UserHasBadgeAsync(player.UserId,BADGE_ID)
	awardBadge(player,BADGE_ID)
end

Players.PlayerAdded:Connect(function(Player)
	onPlayerAdded(Player)
	local leaderstats = Player:WaitForChild("leaderstats")
	local Kills = leaderstats:WaitForChild("Kills")
	local Wins = leaderstats:WaitForChild("Wins")
	local Coneccion1
	local Coneccion2
	if Kills.Value >= 1 then
		awardBadge(Player,Badges["KillBadge1"])
	end
	if Kills.Value >= 100 then
		awardBadge(Player,Badges["KillBadge100"])
	end
	if Kills.Value >= 1000 then
		awardBadge(Player,Badges["KillBadge1000"])
	end
	if Wins.Value >= 1 then
		awardBadge(Player,Badges["WinBadge1"])
	end
	if Wins.Value >= 100 then
		awardBadge(Player,Badges["WinBadge100"])
	end
	if Wins.Value >= 1000 then
		awardBadge(Player,Badges["WinBadge1000"])
	end

	Coneccion1 = Kills.Changed:Connect(function(Cambio)
		print(Kills.Value,Wins.Value)

		if Kills.Value == 1  or Kills.Value == 100 or Kills.Value == 1000 then
			local BadgeCorrespondiente = Badges["KillBadge"..Kills.Value]
			awardBadge(Player,BadgeCorrespondiente)
		end
	end)
	Coneccion2 = Wins.Changed:Connect(function(Cambio)
		print(Kills.Value,Wins.Value)

		if Wins.Value == 1  or Wins.Value == 100 or Wins.Value == 1000 then
			local BadgeCorrespondiente = Badges["WinBadge"..Wins.Value]
			awardBadge(Player,BadgeCorrespondiente)
		end
	end)
	Players.PlayerRemoving:Connect(function(PlayerRemoving)
		if PlayerRemoving == Player then
			Coneccion1:Disconnect()
			Coneccion2:Disconnect()
		end
	end)
end)
