RegisterCommand('die', function()
    local playerPed = PlayerPedId()

    SetEntityHealth(playerPed, 0)
end)

RegisterCommand('revive', function()
	local playerPed = PlayerPedId() 
	local coords = GetEntityCoords(playerPed)

	local fomatedCoords = {
		x = math.floor(coords.x*100)/100, 
		y = math.floor(coords.y*100)/100,
		z = math.floor(coords.z*100)/100,
	}

	spawnPed(playerPed, fomatedCoords, 0.0)
end)

function spawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)
end
