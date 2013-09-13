module(...,package.seeall);
local saver = require("scripts.Utils.dataSaver");

function new()
    local login = {};
    
    function login:buildForm(parentGroup)

        display.setStatusBar( display.HiddenStatusBar )
        local title = display.newText("Logar com Facebook!", 10, 50, native.systemFontBold, 16)
        local fbUtils = require("scripts.Utils.FacebookUtils").new()
        local response = fbUtils:login()
        print ("Response: "..tostring(response))
        if(response == true) then
            local customerObject = {
                firstName = "Sand",
                lastName = "Box",
            }
            saver.saveValue("customer",customerObject);
        end
        local storyboard  = require("storyboard");
        parentGroup:insert(title)
        if(response) then
        	storyboard.gotoScene("scripts.home.HomeScene")
    	end
    end
        
    return login
end
