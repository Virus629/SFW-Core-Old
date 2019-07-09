--3d Text etc.
SFW = SFW or {}

local coordsVisible = false

DrawScreenText = function(text)
	SetTextColour(186, 186, 186, 255)
	SetTextFont(7)
	SetTextScale(0.378, 0.378)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.95, 0.91)
end

Citizen.CreateThread(function()
    while true do
		local sleepThread = 250
		
		if coordsVisible then
			sleepThread = 5

			local playerPed = PlayerPedId()
			local playerX, playerY, playerZ = table.unpack(GetEntityCoords(playerPed))
			local playerH = GetEntityHeading(playerPed)

			DrawScreenText(("~r~X~w~: %s \n~r~Y~w~: %s \n~r~Z~w~: %s \n~r~H~w~: %s~w~"):format(SFW.Math.FormatCoord(playerX, 1), SFW.Math.FormatCoord(playerY, 1), SFW.Math.FormatCoord(playerZ, 1), SFW.Math.FormatCoord(playerH, 1)))
		end

		Citizen.Wait(sleepThread)
	end
end)

ToggleCoords = function()
	coordsVisible = not coordsVisible
end

RegisterCommand("coords", function()
    if settings.useDebug then
        ToggleCoords()
    else
        print('Debug is false')
    end
end)