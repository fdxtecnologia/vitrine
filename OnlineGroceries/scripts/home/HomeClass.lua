module(...,package.seeall);

function new()
	
	home = {};
	
	function home:buildCenario(listProds,parentGroup)
            local groupCarousel = display.newGroup();
            groupCarousel:setReferencePoint(display.TopLeftReferencePoint);
            groupCarousel.x=0;
            groupCarousel.y=0;
            for i=1,#listProds do
                home:createThumbProd(listProds[i], groupCarrussel);
            end
            home:createCarousel(groupCarousel);
            parentGroup:insert(groupCarousel);
        end
        
        function home:createThumbProd(prod,parentGroup)
            local groupThumb = display.newGroup();
            groupThumb:setReferencePoint(display.TopLeftReferencePoint);
            local image = display.newImageRect("images/produtos/"..prod.sku..".jpg", display.contentWidth*0.25, display.contentHeight*0.25);
            image:setReferencePoint(display.TopLeftReferencePoint);
            image.x =0;
            image.y=0;
            groupThumb:insert(image);
            parentGroup:insert(parentGroup);
        end
        
        function home:createCarousel(group)
            local WScreen = display.contentWidth;
            local HScreen = display.contentHeight;
            local groupCarousel = display.newGroup();
            local thumb = display.newGroup();
            local qtyRows = HScreen/groupCarousel[1].height;
            local qtyCol = WScreen/groupCarousel[1].width;
            local posX =0;
            local posY =0;
            
            groupCarousel = group;
            
            for i=0,groupCarousel.numChildren do
                thumb = groupCarousel[i];
                thumb.x = posX;
                thumb.y = posY;
                posX = posX + WScreen*0.05;
            end  
        end
	
	return home;
end

