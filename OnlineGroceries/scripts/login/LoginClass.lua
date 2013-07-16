module(...,package.seeall);

function new()
    local login = {};
    
    function login:buildForm(parentGroup)
        display.setStatusBar( display.DefaultStatusBar )
        
        local widget = require "widget"
        local sbHeight = display.statusBarHeight
        local tbHeight = 44
        local top = sbHeight + tbHeight
        
        -- forward declarations
        local titleField, noteText, loadSavedNote, saveNote
        
        local textFont = native.newFont( native.systemFont )
        local currentTop = sbHeight+tbHeight+10
        local padding = 10
        
        -- create textField
        titleField = native.newTextField( padding, sbHeight+tbHeight+10, display.contentWidth-(padding*2), 28 )
        titleField.font = textFont
        titleField.size = 14
        
        
    end
    
    function login:authenticate(user, password)
        
    end
    return login
end
