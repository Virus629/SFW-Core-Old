--Server side commands
RegisterCommand('cls', function(source)
    TriggerClientEvent('chat:clear', source)
end)

RegisterCommand('disc', function(source)
    local src = source
    DropPlayer(src, 'You have been disconnected')
end)
