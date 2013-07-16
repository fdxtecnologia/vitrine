module(...,package.seeall);

function new()
	
	local home = {};
        
	function home:buildCenario(listProds,parentGroup)
            
            local function scrolling(event)
                
                local phase = event.phase;
                local direction = event.direction;
                local scroll = event.target;
                
                if("began" == phase)then
                    print("began");
                elseif("moved" == phase)then
                    local x,y = scroll:getContentPosition(); 
                    print("posX: "..(((x)/scroll.initWidth)*-1));
                    scroll._view.xScale=1+((((x)/scroll.initWidth)*-1)*(1-(scroll.qtyCols*0.05)));
                    --scroll.width = scroll.width * scroll._view.xScale;
                    scroll._view.yScale=1+((((x)/scroll.initWidth)*-1)*(1-(scroll.qtyCols*0.05)));
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
                   verticalScrollDisabled = true,
                   leftPadding = display.contentWidth *0.05,
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
                        qtyCol = qtyCol +1;
                        qtdMaxRow = qtyRows;
                        qtyRows = 0;
                        posX = posX + display.contentWidth*0.05 + image.width*scaleX;
                        print("position X"..posX);
                        posY = display.contentHeight * 0.05;
                        isFirstTime = false;
                    end
                else
                    if(qtyRows == qtdMaxRow) then
                        qtyRows = 0;
                        qtyCol = qtyCol +1;
                        posX = posX + display.contentWidth*0.05 + image.width*scaleX;
                        print("position X"..posX);
                        posY = display.contentHeight * 0.05;
                    end
                end              
            end
            scrollView.initX = display.contentWidth *0.05;
            scrollView.initY = display.contentHeight *0.05;
            scrollView.qtyCols = qtyCol;
            scrollView.qtyRows = qtdMaxRow;
            scrollView.initWidth = scrollView._view.width;
            scrollView.initHeight = scrollView._view.height;
        end
        
    return home;
end

