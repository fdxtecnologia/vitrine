module(...,package.seeall);

function new()
    local login = {};
    
    function login:buildForm(parentGroup)

        display.setStatusBar( display.HiddenStatusBar )
        local title = display.newText("Logar com Facebook!", 10, 50, native.systemFontBold, 16)
        local fbUtils = require("scripts.Utils.FacebookUtils").new()
        local response = fbUtils:login()
        print ("Response: "..tostring(response))
        local storyboard  = require("storyboard");
        parentGroup:insert(title)
        if(response) then
        	storyboard.gotoScene("scripts.home.HomeScene")
    	end
    end
        
    return login
end
