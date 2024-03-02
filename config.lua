Config = {}

Config.Debug = false -- Enable or disable debug mode
Config.Blips = true -- Enable or disable blips
Config.MineButton = 0x4CC0E2FE --B Key
Config.MiningTime = 10000 -- 10 seconds
Config.MiningTool = "pickaxe" -- Name of the tool to equip
Config.ToolDurability = 100 -- Durability of the tool
---------------------------------------------
Config.LootAmountMin = 1 -- Amount of one item to give, example 1 copper
Config.LootAmountMax = 3 -- Amount of one item to give, example 3 copper
Config.ExtraReward = "gold_nugget"
Config.ExtraRewardChance = 30 -- 30% chance to get extra reward
Config.ExtraRewardAmount = 1 -- Amount of extra reward to give
---------------------------------------------
Config.Minigame = {
    focus = true, -- Should minigame take nui focus (required)
    cursor = false, -- Should minigame have cursor
    maxattempts = 2, -- How many fail attempts are allowed before game over
    type = 'bar', -- What should the bar look like. (bar, trailing)
    userandomkey = false, -- Should the minigame generate a random key to press?
    keytopress = 'E', -- userandomkey must be false for this to work. Static key to press
    keycode = 69, -- The JS keycode for the keytopress
    speed = 34, -- How fast the orbiter grows
    strict = true -- if true, letting the timer run out counts as a failed attempt
}
---------------------------------------------
Config.WebhookURL = "https://discord.com/api/webhooks/yourwebhook" -- Discord Webhook URL
Config.WebhookName = "Mining" -- Name of the Webhook
Config.WebhookAvatar = "https://i.imgur.com/4w3U9xv.png" -- Avatar of the Webhook
---------------------------------------------
-- Add your mine locations here
Config.Mines = {
    Annesburg = {
        {Pos = vector3(2760.96, 1310.65, 69.89), },
        {Pos = vector3(2760.58, 1304.03, 69.96), },
        {Pos = vector3(2755.62, 1302.49, 69.92), },
        {Pos = vector3(2755.31, 1308.27, 69.9), },
        {Pos = vector3(2719.52, 1314.32, 69.68), },
        {Pos = vector3(2715.46, 1314.63, 69.68), },
        {Pos = vector3(2713.42, 1307.67, 69.85), },
        {Pos = vector3(2719.35, 1307.68, 69.74), },
    },
    Kamassa = {
        {Pos = vector3(2323.55, 1130.41, 96.46), },
        {Pos = vector3(2327.18, 1131.41, 96.65), },
        {Pos = vector3(2330.95, 1137.24, 96.23), },
        {Pos = vector3(2326.73, 1144.7, 96.28), },
    },

    Grizzly = {
        {Pos = vector3(-2368.08, 124.68, 216.19), },
        {Pos = vector3(-2368.84, 118.23, 216.75), },
        {Pos = vector3(-2372.7, 116.29, 216.75), },
        {Pos = vector3(-2366.38, 108.74, 216.72), },
        {Pos = vector3(-2357.17, 110.77, 216.87), },
    },

    Tumbleweed = {
        {Pos = vector3(-5958.27, -3189.61, -22.27), },
        {Pos = vector3(-5961.31, -3180.73, -23.03), },
        {Pos = vector3(-5963.39, -3190.17, -22.26), },
        {Pos = vector3(-5957.84, -3189.87, -22.28), },
        {Pos = vector3(-5960.86, -3173.74, -23.53), },
        {Pos = vector3(-5964.86, -3174.23, -23.55), },
    }


}
-- Add your mine Rewards here, The more you add the less the chance.
Config.MineOre = {
    Annesburg = {"coal", "rock", "coal", "coal", "coal"}, --the more you add the less the chance 1 item has
    Kamassa = {"nitrite", "rock"},
    Grizzly = {"iron", "rock"},
    Tumbleweed = {"copperore", "rock"},
}

