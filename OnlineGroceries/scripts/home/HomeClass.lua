module(...,package.seeall);

function new()
	
	local home = {};
	
	function home:buildCenario(listProds,groupCarousel)
            groupCarousel:setReferencePoint(display.TopLeftReferencePoint);
            groupCarousel.x=0;
            groupCarousel.y=0;
            for i=1,#listProds do
                local thumb = display.newGroup();
                thumb = home:createThumbProd(listProds[i],thumb);
                groupCarousel:insert(thumb);
                thumb = nil;
            end
            
            local teste = display.newGroup();
 
            teste = home:testeAdd(listProds[1],teste);
            
            groupCarousel:insert(teste);
          
            return groupCarousel;
        end 
        
        function home:testeAdd(prod,teste)
            local t2 = teste;
            if(t2==nil)then
                print("TESTE");
            end
            local image = display.newImageRect("images/produtos/"..prod.sku..".jpg",display.contentWidth*0.25,display.contentHeight*0.25,true);
            t2:insert(image);
            return t2;
        end
        
        function home:createThumbProd(prod,groupThumb)
            groupThumb:setReferencePoint(display.CenterLeftReferencePoint);
            groupThumb.x=0;
            groupThumb.y=0;
            local image = display.newImageRect("images/produtos/"..prod.sku..".jpg",display.contentWidth*0.25,display.contentHeight*0.25,true);
            image:setReferencePoint(display.TopLeftReferencePoint);
            image.x = 0;
            image.y = 0;
            groupThumb:insert(image);
            return groupThumb;
        end
        
--        function home:createCarousel(group)
--            local WScreen = display.contentWidth;
--            local HScreen = display.contentHeight;
--            local groupCarousel = display.newGroup();
--            local thumb = display.newGroup();
--            local qtyRows = HScreen/groupCarousel[1].height;
--            local qtyCol = WScreen/groupCarousel[1].width;
--            local posX =0;
--            local posY =0;
--            
--            groupCarousel = group;
--            
--            for i=0,groupCarousel.numChildren do
--                thumb = groupCarousel[i];
--                thumb.x = posX;
--                thumb.y = posY;
--                posX = posX + WScreen*0.05;
--            end  
--        end
	
	return home;
end

