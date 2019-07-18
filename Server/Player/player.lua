 --creates new user
function createUser(identifier)
    local identifier, license, username = getPlayerID(source), GetPlayerIdentifiers(source)[2], GetPlayerName(source)
    
    local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE id = @id', {['@id'] = identifier})

    if #result > 0 then
        SFW.Debug('User loaded from database')
    else
        MySQL.Async.execute('INSERT INTO users (`id`, `license`, `username`, `lastPosition`, `rank`) VALUES (@id, @license, @username, @lastPosition, @rank)',
        {
           ['@id']           = identifier,
           ['@license']      = license,
           ['@username']     = username,
           ['@lastPosition'] = '{2523.57,-385.02,92.5}',
           ['@rank']         = 'user'
       }, function(rowsChanged)
           SFW.Debug('New user created')
       end)
    end
end


function getUserPermission(identifier, source)
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    local username = GetPlayerName(src)

    local isAdmin = MySQL.Sync.fetchAll('SELECT rank FROM users WHERE id = @id', {['@id'] = identifier})

    if (isAdmin) then
        for k,v in ipairs(isAdmin) do
            if v.rank == 'user' then
                SFW.Debug('Player ' .. username .. ' is not admin')
            elseif(v.rank == ('mod') or ('admin') or ('owner')) then
                SFW.Debug('Player ' .. username .. ' is ' .. v.rank)
            end
        end
    end
end


--DEBUGGING
RegisterCommand('admin', function(source, args, rawCommand) 
    local src = source
    local player = GetPlayerData(src)

    if(player.rank == 'admin' or player.rank == 'owner') then
        TriggerClientEvent('chat:addMessage', source, {color = {255, 0, 0}, multiline = true, args = {'SYSTEM', 'Your permission level is ^1' .. player.rank}})
        print(player.rank)
    elseif(player.rank == 'user' or player.rank == 'mod') then
        TriggerClientEvent('chat:addMessage', source, {color = {255, 0, 0}, multiline = true, args = {'SYSTEM', 'You dont have this power'}})
        print(player.rank)
    end
end)

RegisterCommand('addAdmin', function(source, args, rawCommand) 
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    local player = GetPlayerData(source)
    local level = tostring(args[1])

    local test = MySQL.Sync.execute('UPDATE users SET rank = @rank WHERE id = @id', {['@id'] = identifier, ['@rank'] = level})

    SFW.Debug(identifier .. ' updated user ' .. identifier)
end)

RegisterCommand('test', function(source, args, rawCommand)
    local src = source
    local identifiers = GetPlayerIdentifiers(src)
    local playerName = GetPlayerName(src)

    for i in ipairs(identifiers) do
        print('Player: ' .. playerName .. ', Identifier #' .. i .. ': ' .. identifiers[i])
    end
end)