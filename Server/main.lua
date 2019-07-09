--SERVER SIDE--
if Setting.EnableDebug then
    print("\n^2-------------------------------------------------------------")
    print("-----------------^0 [Spectrum-Core Framework] ^2-----------------")
    print("-------------------------------------------------------------\n^0")
end

--Save user info :3
--First spawn save
RegisterServerEvent('sfw:createPlayer')
AddEventHandler('sfw:createPlayer', function()
    local src        = source
    local steamID    = GetPlayerIdentifiers(src)[1] --Taken from esx
    local license    = GetPlayerIdentifiers(src)[2] 
    local playerName = GetPlayerName(src)

    MySQL.Async.execute('INSERT INTO users (`id`, `license`, `username`) VALUES (@id, @license, @username) ON DUPLICATE KEY UPDATE `id` = @id',
    {
        ['@id'] = steamID,
        ['@license'] = license,
        ['@username'] = playerName
    }, function(rowsChanged)
        SFW.Debug('Player Saved')
    end)
end)

--save User
RegisterServerEvent('sfw:savePlayer')
AddEventHandler('sfw:savePlayer', function(source)
    local src      = source
    local steamID  = GetPlayerIdentifiers(src)[1] --Taken from esx
end)

---LATAA PELAAJAN
RegisterServerEvent('sfw:loadPlayer')
AddEventHandler('sfw:loadPlayer', function(source)
    local src     = source
    local steamID = GetPlayerIdentifiers(src)[1] --Taken from esx
end)

--Voidaan käyttää pelaajan leftatessa johonkin esim. datan tallentamiseen
AddEventHandler('playerDropped', function(reason)
    local src = source
    local id  = GetPlayerName(src)

    SFW.Debug('Player '.. id ..' has '.. reason)
    --TriggerEvent('sfw:savePlayer', source)
end)

--Voidaan käyttää pelaajan lataamiseen yms.
AddEventHandler('playerConnecting', function(playerName, setKickReason)
    local src = source

    SFW.Debug('Player '.. playerName ..' is connecting')
    TriggerEvent('sfw:loadPlayer', source)
end)