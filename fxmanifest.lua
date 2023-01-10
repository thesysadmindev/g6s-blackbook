fx_version 'cerulean'
game 'gta5'

author 'Discord: thesysadmin#0001'
description 'BlackBook Identifier System, logs all player identifiers to a database and sends a webhook message to a Discord channel upon successful connection.'
version '1.0.0'

server_scripts {
    '@mysql-async/lib/MySQL.lua', -- comment this if you are using oxmysql
   -- '@oxmysql/lib/MySQL.lua', uncomment this if you are using oxmysql
    'server.lua'
}
