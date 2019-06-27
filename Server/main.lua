--SERVER SIDE--

if settings.useDebug then
    print("\n^2-------------------------------------------------------------")
    print("-----------^0 [Framework Base Resource Has Started] ^2-----------")
    print("-------------------------------------------------------------\n^0")
end

--Save user info :3
local dataSaved = false

RegisterNetEvent('frbs:saveUser')
AddEventHandler('frbs:saveUser', function(source)
    local src = source
    local steamID = GetPlayerIdentifiers(src)[1] --Taken from esx
    local license = GetPlayerIdentifiers(src)[2] 
    local playerName = GetPlayerName(src)

    if dataSaved == false then
        MySQL.Async.execute('INSERT INTO users (`id`, `license`, `username`) VALUES (@id, @license, @username)',
        {
            ['@id'] = steamID,
            ['@license'] = license,
            ['@username'] = playerName
        }, function(rowsChanged)
            FRBS.Debug(rowsChanged)
            dataSaved = true
        end)
    else
        FRBS.Debug('Already done')
    end
end)

--Voidaan käyttää pelaajan leftatessa johonkin esim. datan tallentamiseen
AddEventHandler('playerDropped', function(reason)
    local src = source
    local id = GetPlayerName(src)

    --print("Player " .. id .. " Has been " .. reason)
    FRBS.Debug('Player '.. id .. ' has ' .. reason)
    TriggerEvent('frbs:saveUser', source)
end)

--Voidaan käyttää pelaajan lataamiseen yms.
AddEventHandler('playerConnecting', function(playerName, setKickReason)
    local src = source
    local ip  = GetPlayerEndpoint(src)

    FRBS.Debug('Player '.. playerName .. ' is connecting')
    FRBS.Debug('IP is: '.. ip)
end)