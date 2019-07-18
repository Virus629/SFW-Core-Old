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
--Global variables
local x, y, z = nil

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

RegisterServerEvent('sfw:loadPlayerPos')
AddEventHandler('sfw:loadPlayerPos', function(src)
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

--Voidaan käyttää pelaajan leftatessa johonkin esim. datan tallentamiseen
AddEventHandler('playerDropped', function(reason)
    local src = source
    local steamID  = GetPlayerIdentifiers(src)[1]
    local name  = GetPlayerName(src)

    SFW.Debug('Player '.. name ..' has '.. reason)
end)

--Voidaan käyttää pelaajan lataamiseen yms.
AddEventHandler('playerConnecting', function(playerName, setKickReason)
    local src = source
    local steamID  = GetPlayerIdentifiers(src)[1]

    SFW.Debug('Player '.. playerName ..' is connecting')
    createUser(getPlayerID(src))

    SFW.Debug('Source: '.. getPlayerID(src))
end)
