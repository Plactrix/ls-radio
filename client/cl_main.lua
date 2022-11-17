local radioMenu = false

-- Commands
RegisterCommand("radio", function(_, _, _)
    enableRadio(true)
end)

-- NUI Callbacks
RegisterNUICallback("joinRadio", function(data, cb)
    local playerName = GetPlayerName(PlayerId())
    local getPlayerRadioChannel = exports["tokovoip_script"]:getPlayerData(playerName, "radio:channel")

    if tonumber(data.channel) ~= tonumber(getPlayerRadioChannel) then
        exports["tokovoip_script"]:removePlayerFromRadio(getPlayerRadioChannel)
        exports["tokovoip_script"]:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
        exports["tokovoip_script"]:addPlayerToRadio(tonumber(data.channel))
        exports["mythic_notify"]:DoHudText("inform", Config.messages["joined_to_radio"] .. data.channel .. ".00 MHz </b>")
    else
        exports["mythic_notify"]:DoHudText("error", Config.messages["you_on_radio"] .. data.channel .. ".00 MHz </b>")
    end
    cb("ok")
end)

RegisterNUICallback("leaveRadio", function(data, cb)
    local playerName = GetPlayerName(PlayerId())
    local getPlayerRadioChannel = exports["tokovoip_script"]:getPlayerData(playerName, "radio:channel")

    if getPlayerRadioChannel == "nil" then
        exports["mythic_notify"]:DoHudText("inform", Config.messages["not_on_radio"])
    else
        exports["tokovoip_script"]:removePlayerFromRadio(getPlayerRadioChannel)
        exports["tokovoip_script"]:setPlayerData(playerName, "radio:channel", "nil", true)
        exports["mythic_notify"]:DoHudText("inform", Config.messages["you_leave"] .. getPlayerRadioChannel .. ".00 MHz </b>")
    end
    cb("ok")
end)

RegisterNUICallback("escape", function(data, cb)
    enableRadio(false)
    SetNuiFocus(false, false)
    cb("ok")
end)

-- Threads
CreateThread(function()
    while true do
        if radioMenu then
            DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
            DisableControlAction(0, 2, guiEnabled) -- LookUpDown
            DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate
            DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride
            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({
                    type = "click"
                })
            end
        end
        Wait(0)
    end
end)

-- Functions
function PrintChatMessage(msg)
    TriggerEvent("chat:addMessage", {
        color = { 255, 0, 0},
        multiline = true,
        args = { "System", msg }
    })
end

function enableRadio(toggle)
    SetNuiFocus(true, true)
    radioMenu = toggle
    SendNUIMessage({
        type = "enableui",
        enable = toggle
    })
end
