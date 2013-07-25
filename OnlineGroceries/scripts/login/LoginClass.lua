module(...,package.seeall);

function new()
    local login = {};
    
    function login:buildForm(parentGroup)
        display.setStatusBar( display.HiddenStatusBar )
        
        local formGroup = display.newGroup();
        
--        local widget = require "widget"
--        local sbHeight = display.statusBarHeight
--        local tbHeight = 44
--        local top = sbHeight + tbHeight
        
        -- forward declarations
        local titleField, noteText, loadSavedNote, saveNote
        local textFont = native.newFont( native.systemFont )
        
        local lblLogin = display.newText(formGroup, "Login", display.contentWidth*0.5-display.contentWidth*0.1, display.contentHeight*0.1, display.contentWidth*0.2, display.contentHeight*0.2, textFont, 23);
        
        local userField = native.newTextField(display.contentWidth*0.5-((display.contentWidth*0.33)/2), display.contentHeight*0.3, display.contentWidth*0.33, 23, listener);
        
        local passField = native.newTextField(display.contentWidth*0.5-((display.contentWidth*0.33)/2), display.contentHeight*0.4, display.contentWidth*0.33, 23, listener);
        
        
        
        formGroup:insert(userField);
        formGroup:insert(passField);
    end
    
    function login:authenticate(user, password)
        
    end
    
    return login
end
