module(...,package.seeall);

function new()
	
	local home = {};
        
	function home:buildCenario(listProds,scrollView)
            home:createThumbProd(listProds,scrollView);
        end 
        
        function home:createThumbProd(listProds,parentGroup)
            
            local posX = display.contentWidth * 0.05;
            local posY = display.contentHeight * 0.05;
            local qtyCol = 1;
            local qtyRows = 0;
            local scaleX = 0;
            local scaleY = 0;
            
            for i=1,#listProds do
                local image = display.newImageRect("images/produtos/"..listProds[i].sku..".jpg",display.contentWidth*0.25,display.contentHeight*0.25,true);
                image:setReferencePoint(display.TopLeftReferencePoint);
                image.x = posX;
                image.y = posY;
                if(qtyCol>3)then
                    image.width = image.width*0.4;
                    image.height = image.height*0.4;
                end
                parentGroup:insert(image);
                posY = posY + display.contentHeight*0.05 + image.height;
                qtyRows = qtyRows + 1;
                if((posY+image.height) >= display.contentHeight) then
                    qtdCol = qtyCol +1;
                    qtyRows = 0;
                    posX = posX + display.contentWidth*0.05 + image.width;
                    posY = display.contentHeight * 0.05;
                end
            end
        end
	return home;
end

