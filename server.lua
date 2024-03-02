local VORPcore = exports.vorp_core:GetCore()
local BccUtils = exports['bcc-utils'].initiate()
RegisterServerEvent("fists-mining:awardloot")
AddEventHandler("fists-mining:awardloot", function(mineName)
    local _source = source
    local Character = VORPcore.getUser(source).getUsedCharacter 
    local playerName = Character.firstname
    local playerSurname = Character.lastname
    if Config.Debug then
        print("Trying to award loot to player " .. _source)
    end


    local lootItems = Config.MineOre[mineName]
    if not lootItems then
        print("Error: No loot items configured for mineName: " .. tostring(mineName))
        return
    end
    deductPickaxeDurability(_source)
    local selectedItem = lootItems[math.random(#lootItems)]
    local amount = math.random(Config.LootAmountMin, Config.LootAmountMax)
    exports.vorp_inventory:canCarryItem(_source, selectedItem, amount, function(canCarry)
        if canCarry then
            exports.vorp_inventory:addItem(_source, selectedItem, amount)
            TriggerClientEvent("vorp:TipRight", _source, "You have found " .. amount .. " " .. selectedItem, 3000)
            BccUtils.Discord.sendMessage(Config.WebhookURL, Config.WebhookName, Config.WebhookAvatar, "Fists-Mining", "Player " .. playerName .. " " .. playerSurname .. " has successfully mined " .. amount .. " " .. selectedItem)
        else
            TriggerClientEvent("vorp:TipRight", _source, "You can't carry more " .. selectedItem, 3000)
        end
    end)

    if math.random(100) <= Config.ExtraRewardChance then
        exports.vorp_inventory:canCarryItem(_source, Config.ExtraReward, Config.ExtraRewardAmount, function(canCarry)
            if canCarry then
                exports.vorp_inventory:addItem(_source, Config.ExtraReward, Config.ExtraRewardAmount)
                TriggerClientEvent("vorp:TipRight", _source, "You have found an extra " .. Config.ExtraRewardAmount .. " " .. Config.ExtraReward, 3000)
                BccUtils.Discord.sendMessage(Config.WebhookURL, Config.WebhookName, Config.WebhookAvatar, "Fists-Mining", "Player " .. playerName .. " " .. playerSurname .. " has successfully mined " .. Config.ExtraRewardAmount .. " " .. Config.ExtraReward)
            else
                TriggerClientEvent("vorp:TipRight", _source, "You can't carry more " .. Config.ExtraReward, 3000)
            end
        end)
    end
end)

function deductPickaxeDurability(_source)
    local pickaxe = exports.vorp_inventory:getItem(_source, Config.MiningTool)

    if pickaxe and pickaxe.count > 0 then
        local meta = pickaxe.metadata or {}
        local durability = meta.durability or Config.ToolDurability
        durability = durability - 1
        meta.durability = durability
        meta.description = "Durability: " .. durability 
        exports.vorp_inventory:subItem(_source, Config.MiningTool, 1)

        if durability > 0 then
            exports.vorp_inventory:addItem(_source, Config.MiningTool, 1, meta)
        else
            TriggerClientEvent("vorp:TipRight", _source, "Your pickaxe broke.", 3000)
        end
    end
end






RegisterServerEvent("fists-mining:checkForTool")
AddEventHandler("fists-mining:checkForTool", function()
    local _source = source
    local requiredItem = Config.MiningTool

    exports.vorp_inventory:getItem(_source, requiredItem, function(item)
        if item.count > 0 then
            TriggerClientEvent("fists-mining:allowMining", _source, true)
            if Config.Debug then
                print("Player " .. _source .. " has a " .. requiredItem)
            end
        else
            TriggerClientEvent("fists-mining:allowMining", _source, false)
            if Config.Debug then
                print("Player " .. _source .. " does not have a " .. requiredItem)
            end
        end
    end)
end)
