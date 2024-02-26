local BccUtils = exports['bcc-utils'].initiate()
local MiniGame = exports['bcc-minigames'].initiate()
local currentMineName = nil
local isMiningActive = false



RegisterNetEvent("fists-mining:allowMining")
AddEventHandler("fists-mining:allowMining", function(allow, mineName)
    if allow then
        MiniGame.Start('skillcheck', Config.Minigame, function(result)
            if result.passed then
            isMiningActive = true
            if Config.Debug then
                print("Minigame success, triggering server event to add item")
            end
            PlayAnim("amb_work@world_human_pickaxe_new@working@male_a@trans", "pre_swing_trans_after_swing", Config.MiningTime, true, true)
            --Citizen.Wait(Config.MiningTime)
            if currentMineName then
                TriggerServerEvent('fists-mining:awardloot', currentMineName)
                isMiningActive = false
            else
                print("Error: No mine detected.")
            end
        else
            TriggerClientEvent("vorp:TipRight", source, "Mining failed, try again.", 3000)
        end
    end)
    else
        TriggerClientEvent("vorp:TipRight", source, "You need a pickaxe to mine", 3000)
    end
end)


Citizen.CreateThread(function()

    local promptGroup = BccUtils.Prompt:SetupPromptGroup()
    local minePrompt = promptGroup:RegisterPrompt("Hold to start mining.", Config.MineButton, 1, 1, true, 'hold', { timedeventhash = "MEDIUM_TIMED_EVENT" })
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local nearAnyMine = false

        if not isMiningActive then
            for mineName, spots in pairs(Config.Mines) do
                for _, spot in ipairs(spots) do
                    local distance = #(coords - spot.Pos)
                    if distance < 2.0 then
                        nearAnyMine = true
                        promptGroup:ShowGroup("Mine Interaction")

                        if minePrompt:HasCompleted() then
                        
                            if Config.Debug then
                                print("Triggering check for tool")
                            end
                            TriggerServerEvent("fists-mining:checkForTool", mineName)
                        end
                        break 
                    end
                end
                if nearAnyMine then break end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        currentMineName = nil

        for name, spots in pairs(Config.Mines) do
            for _, spot in ipairs(spots) do
                if #(coords - vector3(spot.Pos.x, spot.Pos.y, spot.Pos.z)) < 2.0 then
                    currentMineName = name
                    break  
                end
            end
            if currentMineName then break end
        end
    end
end)




-- Blips setup
Citizen.CreateThread(function()
    BccUtils.Blips:SetBlip('Tumbleweed Mine', 'blip_location_lower', 0.2, -5963.02, -3193.17, -21.57)
    BccUtils.Blips:SetBlip("Grizzly's Mine", 'blip_location_lower', 0.2, -2328.32, 100.18, 221.62)
    BccUtils.Blips:SetBlip('Kamassa River Mine', 'blip_location_lower', 0.2, 2284.27, 1194.54, 108.07)
    BccUtils.Blips:SetBlip('Annesburg Mine', 'blip_location_lower', 0.2, 2776.93, 1339.18, 70.74)
end)

function PlayAnim(animDict, animName, time, raking, loopUntilTimeOver) --function to play an animation
    local animTime = time
    local ped = PlayerPedId()
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
      Wait(100)
    end
    FreezeEntityPosition(ped, true)
    local flag = 16
    if loopUntilTimeOver then
      flag = 1
      animTime = -1
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, 1.0, animTime, flag, 0, true, 0, false, 0, false)
    if raking then
      local playerCoords = GetEntityCoords(PlayerPedId())
      local pickaxeObj = CreateObject("p_pickaxe01x", playerCoords.x, playerCoords.y, playerCoords.z, true, true, false)
      AttachEntityToEntity(pickaxeObj, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(), "PH_R_Hand"), 0.0, 0.0, 0.19, 0.0, 0.0, 0.0, false, false, true, false, 0, true, false, false)
      Wait(time)
      DeleteObject(pickaxeObj)
      ClearPedTasksImmediately(PlayerPedId())
      FreezeEntityPosition(ped, false)
    else
      Wait(time)
      ClearPedTasksImmediately(PlayerPedId())
      FreezeEntityPosition(ped, false)
    end
end
