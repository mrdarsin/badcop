QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    isPlayerWhitelisted = PlayerWhitelisted()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData = QBCore.Functions.GetPlayerData()
    isPlayerWhitelisted = PlayerWhitelisted()
end)

Weapons = {
    "weapon_pistol",
    "weapon_smg",
    "weapon_stungun",
    "weapon_nightstick"
}

Jobs = {
    "police"
}

CreateThread(function()
    while true do
        Wait(2000)
        local player = PlayerPedId()
        if not isPlayerWhitelisted then
            for k,v in pairs(Weapons) do
                local player = PlayerPedId()
                local weapon = GetHashKey(v)
                if HasPedGotWeapon(player, weapon, false) then
                    RemoveWeaponFromPed(player, weapon)
                    TriggerServerEvent("antibadcop:server:RemoveItem", v, 1)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[v], "remove", 1) 
                end
            end
        end
    end
end)

function PlayerWhitelisted()
	for k,v in ipairs(Jobs) do
		if v == PlayerData.job.name then
			return true
		end
	end
	return false
end




