addon.name      = 'jumpY';
addon.author    = 'Voxludorum';
addon.version   = '1.1';
addon.desc      = 'Binds Xbox Y Button to a text command.';
addon.link      = 'https://ashitaxi.com/';

require('common');

local isButtonDown = false;

--defaults to jumping when pressing 'Y'
local myCommand = "/jump";

ashita.events.register('xinput_button', 'xinput_button_cb', function (e)

    if (e.button == 15) then
        local newState = (e.state == 1);
        if (newState ~= isButtonDown) then
            if (newState) then
                AshitaCore:GetChatManager():QueueCommand(0, myCommand);
            end
            isButtonDown = newState;
        end 
    end
end);

ashita.events.register('command', 'command_cb', function (e)
    local args = e.command:args();
    if args[1] == "/setybutton" or args[1] == "/sety" then
        myCommand = args[2]
        for i=3,#args do
            myCommand = myCommand .. " " .. args[i]
        end
        AshitaCore:GetChatManager():QueueCommand(0, "/echo New 'Y' command: " .. myCommand);
        return true
    end
    return false
end);