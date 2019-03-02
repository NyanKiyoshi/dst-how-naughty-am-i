local COMMAND_NAME = "naughty"
local require = GLOBAL.require

local function say(user, say_string)
    print(user.name .. ": " .. say_string)
    user:DoTaskInTime(0, function()
        user.components.talker:Say(say_string)
    end)
end

local function tellPlayerNaughtiness(player)
    local worldsKramped = GLOBAL.TheWorld.components.kramped
    local message = worldsKramped:GetDebugString()
    say(player, message)
end


GLOBAL.AddModUserCommand("naughty mod", COMMAND_NAME, {
    prettyname = function(command) return "How naughty is everyone?" end,
    desc = function() return "List the naughtinesses!" end,
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
