SFW = SFW or {}

--Death module. Handles player dead events
RegisterCommand('die', function()
    local playerPed = PlayerPedId()

    SetEntityHealth(playerPed, 0)
end)

RegisterCommand('revive', function()
	local playerPed = PlayerPedId() 
	local coords    = GetEntityCoords(playerPed)
	local heading   = GetEntityHeading(playerPed)

	local fomatedCoords = {
		x = SFW.Math.FormatCoords(coords.x, 2), -- 2 Decimals
		y = SFW.Math.FormatCoords(coords.y, 2),
		z = SFW.Math.FormatCoords(coords.z, 2)
	}

	spawnPed(playerPed, fomatedCoords, heading)
end)

function spawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)
end
