resource_type 'gametype' { name = 'FRBS Test Server' }

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'


client_script 'fivem.lua'

client_scripts {
    'config.lua',
    'client/utils.lua',
    'client/Modules/death.lua',
    'client/main.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/functions.lua',
    'server/commands.lua',
    'server/main.lua'
}
