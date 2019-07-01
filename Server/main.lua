--SERVER SIDE--

if settings.useDebug then
    print("\n^2-------------------------------------------------------------")
    print("-----------^0 [Framework Base Resource Has Started] ^2-----------")
    print("-------------------------------------------------------------\n^0")
end

--Save user info :3
--First spawn save
RegisterNetEvent('frbs:createPlayer')
AddEventHandler('frbs:createPlayer', function()
    local src = source
    local steamID = GetPlayerIdentifiers(src)[1] --Taken from esx
    local license = GetPlayerIdentifiers(src)[2] 
    local playerName = GetPlayerName(src)


    MySQL.Async.execute('INSERT INTO users (`id`, `license`, `username`) VALUES (@id, @license, @username)',
    {
        ['@id'] = steamID,
        ['@license'] = license,
        ['@username'] = playerName
    }, function(rowsChanged)
        FRBS.Debug("Player Saved first time")
    end)
end)

RegisterCommand('test', function(source, args, raw)
    local steamID = GetPlayerIdentifiers(source)[1] --Taken from esx
    local license = GetPlayerIdentifiers(source)[2] 
    local playerName = GetPlayerName(source)


    MySQL.Async.execute('INSERT INTO users (`id`, `license`, `username`) VALUES (@id, @license, @username)',
    {
        ['@id'] = steamID,
        ['@license'] = license,
        ['@username'] = playerName
    }, function(rowsChanged)
        FRBS.Debug("Player Saved first time")
    end)
end)

--save User
RegisterNetEvent('frbs:savePlayer')
AddEventHandler('frbs:savePlayer', function(source)
    local src = source
    local steamID = GetPlayerIdentifiers(src)[1] --Taken from esx

    FRBS.Debug("Player ".. src .. " saved")
end)

---LATAA PELAAJAN
RegisterNetEvent('frbs:loadPlayer')
AddEventHandler('frbs:loadPlayer', function(source)
    local src = source
    local steamID = GetPlayerIdentifiers(src)[1] --Taken from esx

    MySQL.Async.fetchAll('SELECT * FROM users', {}, function(result)
        if result ~= nil then
            FRBS.Debug(result[1].position)
        end
    end)
end)

--Voidaan käyttää pelaajan leftatessa johonkin esim. datan tallentamiseen
AddEventHandler('playerDropped', function(reason)
    local src = source
    local id = GetPlayerName(src)

    FRBS.Debug('Player '.. id .. ' has ' .. reason)
    TriggerEvent('frbs:savePlayer', source)
end)

--Voidaan käyttää pelaajan lataamiseen yms.
AddEventHandler('playerConnecting', function(playerName, setKickReason)
    local src = source

    FRBS.Debug('Player '.. playerName .. ' is connecting')
    --TriggerEvent('frbs:loadPlayer', source)
end)