-- For Help - ilAn#9613
-- For Help - ilAn#9613
-- For Help - ilAn#9613
-- For Help - ilAn#9613
-- For Help - ilAn#9613
-- For Help - ilAn#9613
-- For Help - ilAn#9613


ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Code

TriggerEvent('es:addGroupCommand', 'skin', 'superadmin', function(source, args, user)
	TriggerClientEvent("qb-clothing:client:openMenu", source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'Skin menu'})

RegisterServerEvent("qb-clothing:saveSkin")
AddEventHandler('qb-clothing:saveSkin', function(model, skin)
    local src = source
    local Player = ESX.GetPlayerFromId(src)

    if model ~= nil and skin ~= nil then 
        MySQL.Async.execute('DELETE FROM playerskins WHERE `citizenid` = @identifier',
        {
		    ['@identifier'] = Player.identifier
	    })
        MySQL.Async.fetchAll("INSERT INTO `playerskins` (`citizenid`, `model`, `skin`, `active`) VALUES ('"..Player.getIdentifier().."', '"..model.."', '"..skin.."', 1)")
    end
end)

RegisterServerEvent("qb-clothing:delSkin")
AddEventHandler('qb-clothing:delSkin', function(model, skin)
    local src = source
    local Player = ESX.GetPlayerFromId(src)

    if model ~= nil and skin ~= nil then 
        MySQL.Async.execute('DELETE FROM `playerskins` WHERE `citizenid` = @identifier',
        {
		    ['@identifier'] = Player.identifier
	    })
    end
end)

RegisterServerEvent("qb-clothes:loadPlayerSkin")
AddEventHandler('qb-clothes:loadPlayerSkin', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    --MySQL.Async.fetchAll("SELECT * FROM `playerskins` WHERE `citizenid` = '"..Player.getIdentifier().."' AND `active` = 1",
        MySQL.Async.fetchAll('SELECT * FROM playerskins WHERE citizenid = @identifier AND active = 1', {
            ['@identifier'] = Player.getIdentifier()
        }, function(result)
        if result[1] ~= nil then
            TriggerClientEvent("qb-clothes:loadSkin", src, false, result[1].model, result[1].skin)
        else
            TriggerClientEvent("qb-clothes:loadSkin", src, true)
        end
    end)
end)

RegisterServerEvent("qb-clothes:saveOutfit")
AddEventHandler("qb-clothes:saveOutfit", function(outfitName, model, skinData)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    if model ~= nil and skinData ~= nil then
        local outfitId = "outfit-"..math.random(1, 10).."-"..math.random(1111, 9999)
            MySQL.Async.execute('INSERT INTO player_outfits (citizenid, outfitname, model, skin, outfitId) VALUES (@citizenid, @outfitname, @model, @skin, @outfitId)', {
                ['@citizenid'] = Player.getIdentifier(),
                ['@outfitname'] = outfitName,
                ['@model'] = model,
                ['@skin'] = json.encode(skinData),
                ['@outfitId'] = outfitId,
            })
                MySQL.Async.fetchAll('SELECT * FROM player_outfits WHERE `citizenid` = @identifier', {
                    ['@identifier'] = Player.getIdentifier()
                }, function(result)
                if result[1] ~= nil then
                    TriggerClientEvent('qb-clothing:client:reloadOutfits', src, result)
                else
                    TriggerClientEvent('qb-clothing:client:reloadOutfits', src, nil)
                end
        end)
    end
end)

RegisterServerEvent("qb-clothing:server:removeOutfit")
AddEventHandler("qb-clothing:server:removeOutfit", function(outfitName, outfitId)
    local src = source
    local Player = ESX.GetPlayerFromId(src)

            MySQL.Async.fetchAll('SELECT * FROM player_outfits WHERE `citizenid` = @identifier', {
                ['@identifier'] = Player.getIdentifier()
            }, function(result)
            if result[1] ~= nil then
                TriggerClientEvent('qb-clothing:client:reloadOutfits', src, result)
            else
                TriggerClientEvent('qb-clothing:client:reloadOutfits', src, nil)
            end
    end)
end)

RegisterServerEvent("qb-clothing:delOutfit")
AddEventHandler('qb-clothing:delOutfit', function(model, skin)
    local src = source
    local Player = ESX.GetPlayerFromId(src)

    if model ~= nil and skin ~= nil then 
        MySQL.Async.execute("DELETE FROM `player_outfits` WHERE `citizenid` = '@identifier' AND `outfitname` = '"..outfitName.."' AND `outfitId` = '"..outfitId.."'",
        {
		    ['@identifier'] = Player.identifier
	    })
    end
end)

ESX.RegisterServerCallback('qb-clothing:server:getOutfits', function(source, cb)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local anusVal = {}

        MySQL.Async.fetchAll('SELECT * FROM player_outfits WHERE `citizenid` = @identifier', {
            ['@identifier'] = Player.getIdentifier()
        }, function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                result[k].skin = json.decode(result[k].skin)
                anusVal[k] = v
            end
            cb(anusVal)
        end
        cb(anusVal)
    end)
end)

RegisterServerEvent('qb-clothing:print')
AddEventHandler('qb-clothing:print', function(data)
    print(data)
end)