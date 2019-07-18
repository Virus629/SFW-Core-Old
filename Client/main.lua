--CLIENT SIDE--

--Client side for user last position saving
RegisterNetEvent('sfw:savePos')
AddEventHandler('sfw:savePos', function() 
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    local formatCoords = {
        x = SFW.Math.Round(coords.x, 2),
        y = SFW.Math.Round(coords.y, 2),
        z = SFW.Math.Round(coords.z, 2)
    }

    local lastPos = '{'.. formatCoords.x .. ',' .. formatCoords.y .. ',' .. formatCoords.z ..'}'  --'{"x:"'..formatCoords.x..',"y:"'..formatCoords.y..',"z:"'..formatCoords.z..'}' 

    TriggerServerEvent('sfw:saveLastPos', lastPos)

    if Setting.EnableDebug then --DEBUG
        TriggerEvent('chat:addMessage', {color = { 255, 0, 0 }, multiline = true, args = {"SYSTEM", "Your last location has been set to: " .. lastPos}})
    end
end)

--Saves user location
RegisterCommand('save', function(source, args, rawCommand)
    local ped = PlayerPedId() 
    TriggerEvent('sfw:savePos')
end)

--Loads last point
local alreadySpawned isLoaded = false

RegisterNetEvent('sfw:spawnLastPos')
AddEventHandler('sfw:spawnLastPos', function(x, y, z)
    local ped = PlayerPedId()
    if(not isLoaded) then
        SetEntityCoords(ped, x, y, z, 1, 1, 1, 1)
        print('Spawned to custom location')
        FreezeEntityPosition(ped, true)
        Citizen.Wait(1500)
        FreezeEntityPosition(ped, false)
        isLoaded = true
    end
end)

-- Spawns player into server. Saves user
AddEventHandler('playerSpawned', function()
    local ped = PlayerPedId()

    if(not alreadySpawned) then
        alreadySpawned = 1
        print('SOURCE: '.. ped)
        TriggerServerEvent('sfw:loadPlayerPos', ped)
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(60000 * 5) -- saves user pos every 5 min
                TriggerEvent('sfw:savePos')
            end
        end)
    end
end)
