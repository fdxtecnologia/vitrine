module(...,package.seeall);

function new()
    
    local menu ={};
    
    
    function menu:buildMenu(group)
        local image = display.newImageRect("images/bg-entrance.png", display.contentWidth, display.contentHeight);
        image.x=0;
        image.y=0;
                
        group:insert(image);        
    end
    
    return menu;
    
end

