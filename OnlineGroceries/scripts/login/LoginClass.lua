module(...,package.seeall);
local saver = require("scripts.Utils.dataSaver");

function new()
    local login = {};

    local function onFbEvent( self,event )
       local typeE = event.type;

       if typeE == "logged" then
            print("Logado com access Token", event.data);
       elseif typeE == "requested" then
            local storyboard  = require("storyboard");
            storyboard.gotoScene("scripts.home.HomeScene");
       elseif typeE == "error" then
            print("Um erro ocorreu: ",event.data);
       end
    end
    
    function login:buildForm(parentGroup)

        display.setStatusBar( display.HiddenStatusBar )
        local title = display.newText("Logar com Facebook!", 10, 50, native.systemFontBold, 16)
        local fbUtils = require("scripts.Utils.FacebookUtils").new()
        local response = fbUtils:login();

        Runtime.fbEvent = onFbEvent;
        Runtime:addEventListener("fbEvent", Runtime);

        print ("Response: "..tostring(response))
        if(response == nil) then
            local customerObject = {
                firstName = "Sand",
                lastName = "Box",
            }
            saver.saveValue("customer",customerObject);
        end
        local storyboard  = require("storyboard");
        parentGroup:insert(title)
        if(response == nil) then
        	storyboard.gotoScene("scripts.home.HomeScene")
    	end

    end
        
    return login
end
