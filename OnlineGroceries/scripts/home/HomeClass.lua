module(...,package.seeall);

function new()
	
	local home = {};
	
	function home:buildCenario(listProds,parentGroup)
            local gCarousel = display.newGroup();
            gCarousel:setReferencePoint(display.TopLeftReferencePoint);
            gCarousel.x=0;
            gCarousel.y=0;
            
            home:createThumbProd(listProds,parentGroup);

            parentGroup:insert(gCarousel);
        end 
        
        function home:createThumbProd(listProds,groupCarousel)
            
            local posX = display.contentWidth * 0.05;
            local posY = display.contentHeight * 0.05;
            
            for i=1,#listProds do
                local image = display.newImageRect("images/produtos/"..listProds[i].sku..".jpg",display.contentWidth*0.25,display.contentHeight*0.25,true);
                image:setReferencePoint(display.TopLeftReferencePoint);
                image.x = posX;
                image.y = posY;
                posX = posX + display.contentWidth*0.05 + image.width;
                
            end
        end
	
	return home;
end

