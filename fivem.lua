local firstSpawn = true
-- Spawns player into server. Saves user
AddEventHandler('playerSpawned', function()
    if firstSpawn then
        TriggerServerEvent('frbs:createPlayer')
        firstSpawn = false
    end
end)

AddEventHandler('onClientMapStart', function()
	Citizen.Trace('Trying to stop autospawn...')
	exports.spawnmanager:spawnPlayer() -- Ensure player spawns into server.
	--Citizen.Wait(2500)
	exports.spawnmanager:setAutoSpawn(false)
    Citizen.Trace('Autospawn stopped')
end)
