AddEventHandler('onClientMapStart', function()
	Citizen.Trace('Trying to stop autospawn...')
	exports.spawnmanager:spawnPlayer() -- Ensure player spawns into server.
	--Citizen.Wait(2500)
	exports.spawnmanager:setAutoSpawn(false)
    Citizen.Trace('Autospawn stopped')

    --Should delete emergency vehicles
    for a = 1, 15 do
        EnableDispatchService(a, false)
    end
end)
