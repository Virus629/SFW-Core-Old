resource_type 'gametype' { name = 'SpectrumRP' }

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'


client_scripts {
    'fivem.lua',
    'gui.lua',

    'config.lua',

    'locale.lua',
    'locales/fi.lua',
    
    'client/common.lua',
    'client/utils.lua',
    'client/Modules/death.lua',
    'client/main.lua',

    'shared/math.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',

    'config.lua',

    'locale.lua',
    'locales/fi.lua',

    'server/common.lua',
    'server/functions.lua',
    'server/commands.lua',
    'server/main.lua',

    'shared/math.lua'
}
