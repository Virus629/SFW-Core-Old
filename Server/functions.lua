--Usable events. example: Debug message
local players = {}

SFW = SFW or {} --Test from nopixel

--functions
--Used when calling GetPlayerData(id)
RegisterServerEvent('sfw:addPlayerToTable')
AddEventHandler('sfw:addPlayerToTable', function()
    local src = source
    local id  = GetPlayerIdentifiers(src)[1]

    MySQL.Async.fetchAll('SELECT * FROM users WHERE id = @id',
    {
        ['@id'] = id
    }, function(result)
        table.insert(players, {
            id      = src,
            lastPos = lastPosition,
            rank    = rank
        })
    end)
end)


function GetPlayerById(type, id)
    local identifiers = {}
    local numIDs = GetNumPlayerIdentifiers(id)

    for i = 0, numIDs do
        table.insert(identifiers, GetPlayerIdentifier(id, i))
    end

    for j = 1, #identifiers do
        if string.find(identifiers[j], type, 1) then
            return identifiers[j]
        end
    end
    return false
end

function GetPlayerData(id) 
    for i = 1, #players do
        if players[i].id == id then
            return players[i]
        end
    end
    return false
end

-- TEST 
function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end
-- TEST


--Usable functions
SFW.Debug = function(str) --Test idea from esx
    if Setting.EnableDebug then
        print('^1[SFW Debug]^0 >>> ^2' .. str .. '^0')
    end
end