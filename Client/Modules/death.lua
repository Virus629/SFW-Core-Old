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
		x = SFW.Math.Round(coords.x, 2), -- 2 Decimals
		y = SFW.Math.Round(coords.y, 2),
		z = SFW.Math.Round(coords.z, 2)
	}

	spawnPed(playerPed, fomatedCoords, heading)
end)

TriggerEvent('chat:addSuggestion', '/revive', 'Herätä itsesi henkiin')

function spawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)
end
