--SERVER SIDE--

--"Version check"
local _VERSION = '0.2'


function versionCheck()
    if Setting.EnableDebug then
        print("\n^2-------------------------------------------------------------")
        print("-----------------^0 [Spectrum_Core Framework] ^2-----------------")
        print("-------------------------------------------------------------\n^0")
        print("Spectrum_Core current version is: ".. _VERSION .."\n")
    end
end

Citizen.CreateThread(function()
    while true do
        versionCheck()
        Citizen.Wait(60000 * 10)
    end
end)
--
local x, y, z = nil

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
RegisterServerEvent('sfw:saveLastPos')
AddEventHandler('sfw:saveLastPos', function(lastPos)
    local src      = source
    local steamID  = GetPlayerIdentifiers(src)[1] --Taken from esx

    MySQL.Async.execute('UPDATE users SET `lastPosition` = @lastPos WHERE id = @id',
    {
        ['@id'] = steamID,
        ['lastPos'] = lastPos
    })
end)


RegisterServerEvent('sfw:savePlayer')
AddEventHandler('sfw:savePlayer', function(source)
    local src      = source
    local steamID  = GetPlayerIdentifiers(src)[1] --Taken from esx

    TriggerClientEvent('sfw:savePos', src)
end)

---LATAA PELAAJAN
RegisterServerEvent('sfw:loadPlayer')
AddEventHandler('sfw:loadPlayer', function(src)
    local src     = source
    local steamID = GetPlayerIdentifiers(src)[1] --Taken from esx

    local result = MySQL.Sync.fetchAll('SELECT lastPosition FROM users WHERE id=@id', {['@id'] = steamID})

    if (result) then
        for k,v in ipairs(result) do
            if v.lastPosition ~= "" then
                local spawnPoints = json.decode(v.lastPosition)
                local x, y, z = spawnPoints[1], spawnPoints[2], spawnPoints[3]
                print(x, y, z)

                TriggerClientEvent('sfw:spawnLastPos', src, x, y, z)
            end
        end
    end
end)

-- RegisterCommand('load', function(source, args, rawCommand)
--     TriggerEvent('sfw:loadPlayer')
-- end)

--Voidaan käyttää pelaajan leftatessa johonkin esim. datan tallentamiseen
AddEventHandler('playerDropped', function(reason)
    local src = source
    local id  = GetPlayerName(src)

    SFW.Debug('Player '.. id ..' has '.. reason)
    TriggerEvent('sfw:savePlayer', src)
end)

--Voidaan käyttää pelaajan lataamiseen yms.
AddEventHandler('playerConnecting', function(playerName, setKickReason)
    local src = source

    SFW.Debug('Player '.. playerName ..' is connecting')
end)