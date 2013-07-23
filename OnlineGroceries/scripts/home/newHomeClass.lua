module(...,package.seeall);

function new() 
    
    local home={};
    
    function home:buildCenario(listProds,parentGroup)
        
        local vImages = home:getImages(listProds);
        
        require("scripts.home.NewCarousel").new(listProds,vImages,parentGroup);
    end
    
    function home:getImages(listProds)
        local images={}
        
        for i=1,#listProds do
            images[i] = display.newImageRect("images/produtos/"..listProds[i].sku..".jpg",display.contentWidth*0.25,display.contentHeight*0.25,true);
        end
        
        return images;
    end
    
    return home;
end

