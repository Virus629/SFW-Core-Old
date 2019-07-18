--3d Text etc.
SFW = SFW or {}
SFW.Util = {}

local coordsVisible = false

SFW.Util.DrawScreenText = function(text, positionX, positionY, colorR, colorG, colorB, colorA, scaleX, scaleY)
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

SFW.Util.ShowHelpNotif = function(msg)
	BeginTextCommandDisplayHelp('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandDisplayHelp(0, false, true, -1)
end

--Give weapon
RegisterCommand('giveweapon', function(source, args, rawCommand)
	local ped = PlayerPedId()
	local weapon = string.upper(args[1])

	GiveWeaponToPed(ped, weapon, 2000, false, true)
	exports['notif']:DoLongHudText('inform', 'Sinä sait aseen ' .. tostring(weapon) .. ' ja siinä on täydet ammukset')
end)


--Shows Coords on screen
Citizen.CreateThread(function()
    while true do
		local wait = 250
		
		if coordsVisible then
			wait = 5

			local playerPed = PlayerPedId()
			local playerX, playerY, playerZ = table.unpack(GetEntityCoords(playerPed))
			local playerH = GetEntityHeading(playerPed)

			SFW.Util.DrawScreenText(("~r~X~w~: %s ~r~Y~w~: %s ~r~Z~w~: %s ~r~H~w~: %s~w~"):format(SFW.Math.Round(playerX, 1), SFW.Math.Round(playerY, 1), SFW.Math.Round(playerZ, 1), SFW.Math.Round(playerH, 1)), 0.5, 0.96, 186, 186, 186, 255, 0.378, 0.378)
		end

		Citizen.Wait(wait)
	end
end)

ToggleCoords = function()
	coordsVisible = not coordsVisible
end

RegisterCommand("coords", function(source, args, rawCommand)
    if Setting.EnableDebug then
		ToggleCoords()
    else
        print('Debug is false')
    end
end)
---