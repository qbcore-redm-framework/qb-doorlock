local GetPlayer = exports['qbr-core']:GetPlayer
local DoorInfo	= {}

local function IsAuthorized(jobName, doorID)
	for _,job in pairs(doorID.authorizedJobs) do
		if job == jobName then
			return true
		end
	end
	return false
end

RegisterNetEvent('qbr-doorlock:updatedoorsv', function(doorID, state, cb)
    local src = source
	local Player = GetPlayer(src)
	if not IsAuthorized(Player.PlayerData.job.name, Config.DoorList[doorID]) then
		return TriggerClientEvent('QBCore:Notify', src, 9, Lang:t("error.nokey"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	else
		TriggerClientEvent('qbr-doorlock:changedoor', src, doorID, state)
	end
end)

RegisterNetEvent('qbr-doorlock:updateState', function(doorID, state, cb)
    local src = source
	local Player = GetPlayer(src)
	if type(doorID) ~= 'number' then return end
	if not IsAuthorized(Player.PlayerData.job.name, Config.DoorList[doorID]) then
		return
	end
	DoorInfo[doorID] = {}
	TriggerClientEvent('qbr-doorlock:setState', -1, doorID, state)
end)
