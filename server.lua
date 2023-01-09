ESX = nil
Config = {}

Config.whName = 'Player ID Logger' -- The Webhook bot's name.
Config.whLink = '' -- Enter your Discord channel webhook URL here. https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks.

-- DO NOT CHANGE/MODIFY ANYTHING BELOW THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING!!

local namecache = {}

function split(s, delimiter)result = {};for match in (s..delimiter):gmatch("(.-)"..delimiter) do table.insert(result, match) end return result end

Citizen.CreateThread(function() -- startup
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    while ESX==nil do Wait(0) end
end)

AddEventHandler("playerConnecting",function(name, setKick, def)
    local identifiers = GetPlayerIdentifiers(source)
    if #identifiers>0 and identifiers[1]~=nil then
        namecache[identifiers[1]]=GetPlayerName(source)
        local playername = GetPlayerName(source)
        local saneplayername = "Adjusted Playername"
        if string.gsub(playername, "[^a-zA-Z0-9]", "") ~= "" then
            saneplayername = string.gsub(playername, "[^a-zA-Z0-9 ]", "")
        end
        local data = {
            ["@name"] = saneplayername,
            ["@timestamp"] = os.date("%Y-%m-%d %X")
        }
        for k,v in ipairs(identifiers) do
            data["@"..split(v,":")[1]]=v
        end
        MySQL.Async.execute("INSERT INTO `blackbook` (`steam`, `license`, `ip`, `name`, `xbl`, `live`, `discord`, `fivem`, `lastconnect`) VALUES (@steam, @license, @ip, @name, @xbl, @live, @discord, @fivem, @timestamp) ON DUPLICATE KEY UPDATE `license`=@license, `ip`=@ip, `name`=@name, `xbl`=@xbl, `live`=@live, `discord`=@discord, `fivem`=@fivem, `lastconnect`=@timestamp",data)
    else
        DropPlayer(source,"[BlackBook] No identifiers were found when connecting, please reconnect")
    end
end)

function SendWebHook(discord_webhook, title, color, message)
    local embedMsg = {}
    timestamp = os.date("%c")
    embedMsg = {
        {
            ["color"] = color,
            ["title"] = title,
            ["description"] =  ""..message.."",
            ["footer"] ={
            ["text"] = timestamp.." (Server Time).",
            },
        }
    }
    PerformHttpRequest(discord_webhook, function(err, text, headers)end, 'POST', json.encode({username = Config.whName, embeds = embedMsg}), { ['Content-Type']= 'application/json' })
end

AddEventHandler('g6s_blackbook:sendWebhook', function(whData)
    if whData.link == nil then
        whLink = Config.whLink
    else
        whLink = whData.link
    end
    title = whData.title
    color = whData.color
    message = whData.message
    SendWebHook(whLink, title, color, message)
end)

Citizen.CreateThread(function()
    if Config.loginLogLink == '' then
        print('^7[^1INFO^7]: Please set a WebHook URL in the config.lua to log players joining and leaving.')
    else
        AddEventHandler('playerJoining', function()
            local playername = GetPlayerName(source)
            local timestamp = os.date("%d/%m/%Y at %X")
            local steamid  = false
            local license  = false
            for k,v in pairs(GetPlayerIdentifiers(source))do
                if string.sub(v, 1, string.len("steam:")) == "steam:" then
                    steamid = v
                elseif string.sub(v, 1, string.len("license:")) == "license:" then
                    license = v
                end
            end
            local whData = {
                link = Config.whLink,
                title = 'Player Connecting: '..playername,
                color = 655104,
                message = 
                '**[User]:** '..playername..'\n'..
                '**[Steam Identifier]:** '..steamid..'\n'..
                '**[Rockstar Identifier]:** '..license..'\n'..
                '**[Current Session ID]:** '..source..'\n'..
                '**[Connected Time]:** '..timestamp..'\n'
            }
            TriggerEvent('g6s_blackbook:sendWebhook', whData)
            print('Player connection info for '..playername..' (Session ID: '..source..') sent to Discord on '..timestamp..' successfully!')
        end)
    end
end)