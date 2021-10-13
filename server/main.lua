local QBCore = exports['qb-core']:GetCoreObject()
local DoorInfo	= {}

RegisterServerEvent('qb-doorlock:updatedoorsv')
AddEventHandler('qb-doorlock:updatedoorsv', function(source, doorID, state, cb)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if not IsAuthorized(Player.PlayerData.job.name, Config.DoorList[doorID]) then
			TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1You do not have a key!^0")
            return
        else 
            TriggerClientEvent('qb-doorlock:changedoor', src, doorID, state)
        end
end)

RegisterServerEvent('qb-doorlock:updateState')
AddEventHandler('qb-doorlock:updateState', function(doorID, state, cb)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if type(doorID) ~= 'number' then
			return
		end
		if not IsAuthorized(Player.PlayerData.job.name, Config.DoorList[doorID]) then
			return
		end
		DoorInfo[doorID] = {}
		TriggerClientEvent('qb-doorlock:setState', -1, doorID, state)
end)

function IsAuthorized(jobName, doorID)
	for _,job in pairs(doorID.authorizedJobs) do
		if job == jobName then
			return true
		end
	end
	return false
end
