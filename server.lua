Config = {}

Config.debug = false
Config.whName = 'Player ID Logger' -- The Webhook bot's name.
Config.whLink = '' -- Enter your Discord channel webhook URL here. https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks.
Config.oxmysql = false -- true if using oxmysql, false if using mysql-async. Please make sure to change fxmanifest.lua if you are changing this option.
-- DO NOT CHANGE/MODIFY ANYTHING BELOW THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING!!

local namecache = {}

Citizen.CreateThread(function()
    if Config.loginLogLink == '' then
        print('^7[^1INFO^7]: Please set a WebHook URL at line 5 in the server.lua to log players joining and leaving.')
    end
end)

function split(s, delimiter)result = {};for match in (s..delimiter):gmatch("(.-)"..delimiter) do table.insert(result, match) end return result end

AddEventHandler("playerConnecting", function(name, setKick, def)
    local identifiers = GetPlayerIdentifiers(source)
    if #identifiers > 0 and identifiers[1] ~= nil then
        local playername = GetPlayerName(source)
        local token = GetPlayerToken(source)
        local saneplayername = "Adjusted Playername"
        local steamid  = false
        local license  = false
        local timestamp = os.date("%d/%m/%Y at %X")

        namecache[identifiers[1]] = playername
    
        if string.gsub(playername, "[^a-zA-Z0-9]", "") ~= "" then
            saneplayername = string.gsub(playername, "[^a-zA-Z0-9 ]", "")
        end
            
        local data = {
            ["@name"] = saneplayername,
            ["@token"] = token,
            ["@timestamp"] = os.date("%Y-%m-%d %X")
        }
        if Config.loginLogLink ~= '' then    
            for k,v in ipairs(identifiers) do
                data["@"..split(v,":")[1]] = v
            end

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
                '**[FiveM Token]:** '..token..'\n'..
                '**[Current Session ID]:** '..source..'\n'..
                '**[Connected Time]:** '..timestamp..'\n'
            }
            if Config.debug then
                print('Prior to SendWebHook being activated - ')
                print('whData.link: ' .. whData.link \n 'whData.title: ' .. whData.link \n 'whData.color: ' .. whData.link \n 'whData.link: ' .. whData.message \n )
            end
                
            SendWebHook(whData.link, whData.title, whData.color, whData.message)
        end

        if Config.oxmysql then
            MySQL.update("INSERT INTO `blackbook` (`steam`, `license`, `ip`, `name`, `xbl`, `live`, `discord`, `fivem`, `token`, `lastconnect`) VALUES (@steam, @license, @ip, @name, @xbl, @live, @discord, @fivem, @token, @timestamp) ON DUPLICATE KEY UPDATE `license`=@license, `ip`=@ip, `name`=@name, `xbl`=@xbl, `live`=@live, `discord`=@discord, `fivem`=@fivem, `token`=@token, `lastconnect`=@timestamp", data)
        else
            MySQL.Async.execute("INSERT INTO `blackbook` (`steam`, `license`, `ip`, `name`, `xbl`, `live`, `discord`, `fivem`, `token`, `lastconnect`) VALUES (@steam, @license, @ip, @name, @xbl, @live, @discord, @fivem, @token, @timestamp) ON DUPLICATE KEY UPDATE `license`=@license, `ip`=@ip, `name`=@name, `xbl`=@xbl, `live`=@live, `discord`=@discord, `fivem`=@fivem, `token`=@token, `lastconnect`=@timestamp", data)
        end
    else
        DropPlayer(source, "[BlackBook] No identifiers were found when connecting, please reconnect")
    end
end)

function SendWebHook(discord_webhook, title, color, message)
    local embedMsg = {}
    timestamp = os.date("%c")
    embedMsg = {
        {
            ["color"] = color,
            ["title"] = title,
            ["description"] = message,
            ["footer"] ={
            ["text"] = timestamp.." (Server Time).",
            },
        }
    }
    if Config.debug then
        print('After to SendWebHook being activated - ')
        print('discord_webhook: ' .. whData.link \n 'title: ' .. whData.link \n 'color: ' .. whData.link \n 'link: ' .. whData.message \n )
    end
    
    PerformHttpRequest(discord_webhook, function(err, text, headers)end, 'POST', json.encode({username = Config.whName, embeds = embedMsg}), { ['Content-Type']= 'application/json' })
end
