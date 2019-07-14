--3d Text etc.
SFW = SFW or {}

local coordsVisible = false


SFW.DrawScreenText = function(text, positionX, positionY, colorR, colorG, colorB, colorA, scaleX, scaleY)
	SetTextColour(colorR, colorG, colorB, colorA)
	SetTextFont(7)
	SetTextScale(scaleX, scaleY)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(positionX, positionY)
end


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

			DrawScreenText(("~r~X~w~: %s \n~r~Y~w~: %s \n~r~Z~w~: %s \n~r~H~w~: %s~w~"):format(SFW.Math.FormatCoords(playerX, 1), SFW.Math.FormatCoords(playerY, 1), SFW.Math.FormatCoords(playerZ, 1), SFW.Math.FormatCoords(playerH, 1)))
		end

		Citizen.Wait(sleepThread)
	end
end)

ToggleCoords = function()
	coordsVisible = not coordsVisible
end

RegisterCommand("coords", function()
    if Setting.EnableDebug then
        ToggleCoords()
    else
        print('Debug is false')
    end
end)