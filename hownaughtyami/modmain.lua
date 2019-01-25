local COMMAND_NAME = "naughty"
local require = GLOBAL.require
local kramped = require("components/kramped")

local function say(user, say_string)
    print(user.name .. ": " .. say_string)
    user:DoTaskInTime(0, function()
        user.components.talker:Say(say_string)
    end)
end

kramped.GetDebugStringForPlayer = function (playerdata)
    if playerdata.actions and playerdata.threshold and playerdata.timetodecay then
        return string.format(
            "Have %d / %d naughty actions (decay in %2.2f)...", 
            playerdata.actions, playerdata.threshold, playerdata.timetodecay)
    else
        return "I'm calm."
    end
end

local function tellPlayerNaughtiness(player)
    local worldsKramped = GLOBAL.TheWorld.components.kramped
    local message = worldsKramped:GetDebugString()
    say(player, message)

    --if message == nil then
    --    say(player, "No data found.")
    --else
    --    say(player, message)
    --end
end

AddComponentPostInit("kramped", function (inst)
    local _activeplayers = {}
    inst.activePlayers = _activeplayers
end)

GLOBAL.AddModUserCommand("naughty mod", COMMAND_NAME, {
    --aliases = swaggies,
    prettyname = function(command) return "How naughty is everyone?" end,
    desc = function() return "List the naughtiness!" end,
    permission = "USER",
    params = {},
    emote = true,
    slash = true,
    usermenu = false,
    servermenu = false,
    vote = false,
    serverfn = function(params, caller)
        local player = GLOBAL.UserToPlayer(caller.userid)
        if player ~= nil then
            tellPlayerNaughtiness(player)
        end
    end,
    localfn = function(params, caller) end,
})
