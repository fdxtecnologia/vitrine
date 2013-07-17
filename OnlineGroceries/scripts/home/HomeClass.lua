module(...,package.seeall);
system.activate("multitouch");

function new()
    
    local home = {};
    
    function home:buildCenario(listProds,parentGroup)
        --Taxa de incremento da escala
        local t3 = 0.95;
        
        local function scrolling(event)
            
            local phase = event.phase;
            local direction = event.direction;
            local scroll = event.target;
            
            local a,b,e,f
       
            --Atribuições
            a = display.contentHeight * 0.1
            b = display.contentHeight * 0.35
            e = display.contentHeight * 0.05
            f = display.contentHeight * 0.1
                       
            
--            if "moved" == phase then
--                local x,y = scroll:getContentPosition();
--                scroll._view.xScale= (-((((e - a + b - f) / scroll.initWidth) * x) + (a - b)))/100
--                scroll._view.yScale= (-((((e - a + b - f) / scroll.initWidth) * x) + (a - b)))/100
--                ---scroll._view.width = scroll._view.width * scroll._view.xScale;
--            end
            
            
            
            if("moved" == phase)then
                local x,y = scroll:getContentPosition(); 
                scroll._view.xScale=1+((x*t3)/scroll.initWidth)*(-1)
                scroll._view.yScale=1+((x*t3)/scroll.initWidth)*(-1)
                --scroll._view.width = scroll._view.width * scroll._view.xScale;
            elseif ("ended" == phase) then
                if event.limitReached then
                    scroll._view.width = scroll._view.width
                    print(scroll._view.width)
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
            listener = scrolling,
            verticalScrollDisabled = true
        };        
        
        home:createThumbProd(listProds,scrollView);
        parentGroup:insert(scrollView.view);
    end   
    
    function home:createThumbProd(listProds,scrollView)
        
        --COMEÇANDO
        local sizeImage = 100;
        local a,b,c,d,e,f,g,h,t2,x
        local t1, t2
        local yA, yB, yC
        local scala1, scalaP
        
        --Atribuições
        a = display.contentHeight * 0.1
        b = display.contentHeight * 0.35
        c = display.contentHeight * 0.6
        d = display.contentHeight * 0.85
        e = display.contentHeight * 0.05
        f = display.contentHeight * 0.1
        g = display.contentHeight * 0.15
        h = display.contentHeight * 0.2
        x = 0
        
        --T1 Multiplica a escala
        t1 = 1
        scala1 =   -((((e - a + b - f) / display.contentWidth) * x) + (a - b))
        x = scala1 * 0.6;
        -- T2 multiplica o passo de X
        t2 = 0.9
        -- 
        local i = 1
        while i < #listProds do
            local image = display.newImageRect("images/produtos/"..listProds[i].sku..".jpg",sizeImage,sizeImage,true);
            yA = (((((e+f)/2) - ((a+b)/2)) / display.contentWidth) * x) + (( a + b)/2)
            scala1 =  - ((((e - a + b - f) / display.contentWidth) * x) + (a - b))
            image.x = x
            image.y = yA
            image.xScale = (scala1 * t1) / 100
            image.yScale = (scala1 * t1) / 100
            if(scala1 > 0) then
                scrollView:insert(image);
            end
                
            i = i + 1
            
            local image = display.newImageRect("images/produtos/"..listProds[i].sku..".jpg",sizeImage,sizeImage,true);
            yB = (((((f + g)/2) - ((b + c)/2)) / display.contentWidth) * x) + ((b + c)/2)
            scala1 =  - ((((e - a + b - f) / display.contentWidth) * x) + (a - b))
            image.x = x
            image.y = yB
            image.xScale = (scala1 * t1) / 100
            image.yScale = (scala1 * t1) / 100
            if(scala1 > 0) then
                scrollView:insert(image);
            end
            i = i + 1
            
            local image = display.newImageRect("images/produtos/"..listProds[i].sku..".jpg",sizeImage,sizeImage,true);
            yC = (((((g+h)/2) - ((c+d)/2)) / display.contentWidth) * x) + ((c + d)/2)
            scala1 =  - ((((e - a + b - f) / display.contentWidth) * x) + (a - b))
            image.x = x
            image.y = yC
            image.xScale = (scala1 * t1) / 100
            image.yScale = (scala1 * t1) / 100
            if(scala1 > 0) then
                scrollView:insert(image);
            end
            i = i + 1
            --incrementando x
            x = x + (scala1 * t2)
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

