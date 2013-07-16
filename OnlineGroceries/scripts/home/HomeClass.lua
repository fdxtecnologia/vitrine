module(...,package.seeall);
system.activate("multitouch");

function new()
	
	local home = {};
        
	function home:buildCenario(listProds,parentGroup)
            
            local function scrolling(event)
                
                local phase = event.phase;
                local direction = event.direction;
                local scaleX = 1;
                local scaleY = 1;
                
                if("began" == phase)then
                    print("began");
                elseif("moved" == phase)then
                    print("Moved");

                    scaleX = scaleX + 0.05;
                    scaleY = scaleY + 0.05;
                elseif("ended" == phase)then
                    print("Ended");
                end
                
                if(event.limitReached)then
                    if("up" == direction)then
                        print("Reached on Top");
                    elseif("down" == direction)then
                        print("Reached on Bottom");
                    elseif("left" == direction)then
                        print("Reached on Left");
                    elseif("right" == direction)then
                        print("Reached on Right");
                    end
                end
                
                return true;
            end
            
            local widget = require "widget";
            local scrollView = widget.newScrollView{
                   width = display.contentWidth,
                   height = display.contentHeight,
                   scrollWidth = display.contentWidth,
                   scrollHeight = display.contentHeight,
                   listener = scrolling
            };        
            
            home:createThumbProd(listProds,scrollView);
            parentGroup:insert(scrollView.view);
        end   

        function home:createThumbProd(listProds,scrollView)
            
            local posX = 40;
            local posY = 40;
            local qtyCol = 1;
            local qtyRows = 0;
            local scaleX = 1;
            local scaleY = 1;
            local qtdMaxRow = 0;
            local isFirstTime = true;
            local sizeImage = 80;
            
            for i=1,#listProds do
                local image = display.newImageRect("images/produtos/"..listProds[i].sku..".jpg",sizeImage,sizeImage,true);
                image:setReferencePoint(display.CenterReferencePoint);
                image.x = posX;
                image.y = posY;
                image.xScale = scaleX;
                image.yScale = scaleY;
                
                --if(qtyCol > 0)then
                    --scaleX = scaleX * 0.7;
                    --scaleY = scaleY * 0.7;
                --end
                
                function image:touch(event)
                    if(event.phase=="began")then
                        print("TOUCH BEGAN");
                        display.getCurrentStage():setFocus(self);
                        self.markX = self.x;
                        self.markY = self.y;
                        self.isFocus = true;
                        self:toFront();
                    elseif self.isFocus then
                        if(event.phase=="moved")then
                            local x = (event.x - event.xStart) + self.markX;
                            local y = (event.y - event.yStart) + self.markY;
                            self.x, self.y = x,y;
                            print("DRAG");
                        end
                        if(event.phase=="ended")then
                            self.x = self.markX;
                            self.y = self.markY;
                            display.getCurrentStage():setFocus(nil); 
                            self.isFocus = nil;
                        end
                    end
                    return true;
                end
                image:addEventListener("touch", image);
                scrollView:insert(image);
                --posY = posY + display.contentHeight*0.05 + image.height*scaleY;
                qtyRows = qtyRows + 1;
                posY = (80 * qtyRows) + 40;
                
                if(qtyRows >= 3) then
                    qtyCol = qtyCol + 1;
                    qtyRows = 0;
                    posX = posX + 80 * (0.8 ^ qtyCol);
                    posY = 40;
                    scaleX = scaleX * (0.97 ^ qtyCol);
                    scaleY = scaleY * (0.97 ^ qtyCol);
                end
                
--                if(isFirstTime==true)then
--                    if((posY+image.height) >= display.contentHeight) then
--                        qtdCol = qtyCol +1;
--                        qtdMaxRow = qtyRows;
--                        qtyRows = 0;
--                        posX = posX + display.contentWidth*0.05 + image.width*scaleX;
--                        posY = display.contentHeight * 0.05;
--                        isFirstTime = false;
--                    end
--                else
--                    if(qtyRows == qtdMaxRow) then
--                        qtyRows = 0;
--                        posX = posX + image.width*scaleX;
--                        posY = display.contentHeight * 0.05;                        
--                    end
--                end
                
            end            
        end
        
    return home;
end

