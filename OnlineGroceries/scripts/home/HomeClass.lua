module(...,package.seeall);

function new()
	
	local home = {};
        
        function home:newCenario(listProds,parentGroup)
            
            local carouselGroup = display.newGroup;
            
            
        end
        
	function home:buildCenario(listProds,parentGroup)
            
            local function scrolling(event)
                
                local phase = event.phase;
                local direction = event.direction;
                local scroll = event.target;
                local x,y = scroll:getContentPosition();
                
                if("began" == phase)then
                    print("began");
                elseif("moved" == phase)then
                    print("CONTENT POSITION :"..x);
                    print("WIDTH: "..scroll._view.width)
                    scroll._view.xScale=1+(((x+display.contentWidth*0.05)/scroll._view.width)*-1);
                    scroll._view.yScale=1+(((x+display.contentWidth*0.05)/scroll._view.width)*-1);
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
                   verticalScrollDisabled = true,
                   friction = 0,
                   listener = scrolling
            };            
            home:createThumbProd(listProds,scrollView);
            parentGroup:insert(scrollView.view);
        end

        function home:createThumbProd(listProds,scrollView)
            
            local posX = display.contentWidth * 0.05;
            local posY = display.contentHeight * 0.05;
            local qtyCol = 1;
            local qtyRows = 0;
            local scaleX = 1;
            local scaleY = 1;
            local qtdMaxRow = 0;
            local isFirstTime = true;
            
            for i=1,#listProds do
                local image = display.newImageRect("images/produtos/"..listProds[i].sku..".jpg",display.contentWidth*0.25,display.contentHeight*0.25,true);
                image:setReferencePoint(display.TopLeftReferencePoint);
                image.x = posX;
                image.y = posY;
                image.xScale = scaleX;
                image.yScale = scaleY;
                if(qtyRows==0)then
                    scaleX = scaleX - 0.05;
                    scaleY = scaleY - 0.05;
                end
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
                posY = posY + display.contentHeight*0.05 + image.height*scaleY;
                qtyRows = qtyRows + 1;
                if(isFirstTime==true)then
                    if((posY+image.height) >= display.contentHeight) then
                        qtdCol = qtyCol +1;
                        qtdMaxRow = qtyRows;
                        qtyRows = 0;
                        posX = posX + display.contentWidth*0.05 + image.width*scaleX;
                        posY = display.contentHeight * 0.05;
                        isFirstTime = false;
                    end
                else
                    if(qtyRows == qtdMaxRow) then
                        qtyRows = 0;
                        posX = posX + display.contentWidth*0.05 + image.width*scaleX;
                        posY = display.contentHeight * 0.05;                        
                    end
                end              
            end
        end
        
    return home;
end

