module(...,package.seeall);
system.activate("multitouch");

function new()
    
    local home = {};
    local cart = {};
    
    -- Evento que trata a aba do carrinh e adiciona items ao gCart.cart={}
    local function prod_listener(self,event)
        
        if(event.type == "selected")then
            transition.to(self, {time = 100, y=self.y-display.contentHeight*0.2});
        elseif(event.type == "added")then
            local product = event.product;
            local isRepeated = false;
            transition.to(self, {time = 100, y=self.y+display.contentHeight*0.2});
            print("Cart: ",cart);
            for i=1,#self.cart.products do
                if(self.cart.products[i].idProduct == product.idProduct)then
                    isRepeated = true;
                    self.cart.products[i].quantity = self.cart.products[i].quantity + 1;
                    self.cart.products[i].totalPrice = product.price * self.cart.products[i].quantity;
                end
            end
            if(isRepeated==false)then
                product.quantity = product.quantity +1;
                product.totalPrice = product.price;
                table.insert(self.cart.products, product);
            end
            cart = self.cart;
            local list = "";
            for j=1,#self.cart.products do
                list = list.."Produto:"..self.cart.products[j].title.." Quantidade:"..self.cart.products[j].quantity.." Preço:"..self.cart.products[j].totalPrice.."\n";
            end
            if(self.textProduct == nil)then
                self.textProduct = display.newText(list, 0, self.listProdY,display.contentWidth,0, native.systemFont, 14);
            else
                self:remove(self.textProduct);
                self.textProduct = display.newText(list, 0, self.listProdY,display.contentWidth,0, native.systemFont, 14);
            end
            self:insert(self.textProduct);
        elseif(event.type == "release")then
            transition.to(self, {time = 100, y=self.y+display.contentHeight*0.2});
        end
    end
    
    -- Drag and Drop no carrinho 
    local function onTouch(self, event)
        if event.phase == "began" then
            print("TOUCH");
            self.startX= event.x
            --self.startY= event.y
            display.getCurrentStage():setFocus(self)
        elseif event.phase == "moved" then
            local movedX = event.x - self.startX
            --local movedY = event.y - self.startY
            print(movedX, movedY)
            self.x = self.x + movedX
            --self.y = self.y + movedY
            self.startX = event.x
            --self.startY = event.y
        elseif event.phase == "ended" then
                display.getCurrentStage():setFocus(nil)
        end             
    end
    
    --Construção do carrinho
    function home:buildCenario(listProds,parentGroup)
        --Taxa de incremento da escala
        local t3 = 0.95;
        
        local gCart = display.newGroup();
        gCart.x = 0;
        gCart.y = display.contentHeight;
        local bgCart = display.newRect(gCart, 0, 0, display.contentWidth, display.contentHeight);
        bgCart:setFillColor(125, 125, 125,255);       
        
        local carousel = display.newGroup();
        
--        local function scrolling(event)
--            
--            local phase = event.phase;
--            local direction = event.direction;
--            local scroll = event.target;
--            
--            local a,b,e,f
--       
--            --Atribuições
--            a = display.contentHeight * 0.1
--            b = display.contentHeight * 0.35
--            e = display.contentHeight * 0.05
--            f = display.contentHeight * 0.1
--                       
--            
----            if "moved" == phase then
----                local x,y = scroll:getContentPosition();
----                scroll._view.xScale= (-((((e - a + b - f) / scroll.initWidth) * x) + (a - b)))/100
----                scroll._view.yScale= (-((((e - a + b - f) / scroll.initWidth) * x) + (a - b)))/100
----                ---scroll._view.width = scroll._view.width * scroll._view.xScale;
----            end
--            
--            
--            
--            if("moved" == phase)then
--                local x,y = scroll:getContentPosition(); 
--                scroll._view.xScale=1+((x*t3)/scroll._view.width)*(-1)
--                scroll._view.yScale=1+((x*t3)/scroll._view.width)*(-1)
--                --scroll._view.width = scroll._view.width * scroll._view.xScale;
--            elseif ("ended" == phase) then
--                if event.limitReached then
--                    scroll._view.width = scroll._view.width
--                    print(scroll._view.width)
--                end
--            end
--            return true;
--        end
        
--        local widget = require "widget";
--        local scrollView = widget.newScrollView{
--            width = display.contentWidth,
--            height = display.contentHeight,
--            scrollWidth = display.contentWidth,
--            scrollHeight = display.contentHeight,
--            listener = scrolling,
--            verticalScrollDisabled = true
--        };        
        
        home:createThumbProd(listProds,carousel);
        
        carousel.touch = onTouch
        carousel:addEventListener("touch", carousel);
        
        gCart.prod = prod_listener
        gCart.listProdY = 0;
        gCart.cart = {id=1,products={}};
        gCart:addEventListener("prod",gCart);
        
        parentGroup:insert(gCart);
        parentGroup.gCart = gCart;
        parentGroup:insert(carousel);
        parentGroup.carousel = carousel;
    end   
    
     -- Drag and Drop dos items
    local function onDragAndDropImage(self,event)
        
        local gCarousel = self.parent;
        local parentGroup = gCarousel.parent;      
        local gCart = parentGroup.gCart;
    
        if(event.phase=="began")then
            local event = {
                name = "prod",
                type = "selected"
            }
            gCart:dispatchEvent(event);
            
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
                    print("gCart y "..gCart.y);
                    if(self.y >= gCart.y)then
                        local event = {
                            name = "prod",
                            type = "added",
                            product = self.product
                        }
                        gCart:dispatchEvent(event);
                    else
                        local event = {
                            name = "prod",
                            type = "release"
                        }
                        gCart:dispatchEvent(event)
                    end
                    self.x = self.markX;
                    self.y = self.markY;
                    display.getCurrentStage():setFocus(nil); 
                    self.isFocus = nil;
                end
        end
        return true;
    end
    
    -- Cria perspectiva
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

        while i <=#listProds do
                
            local image = display.newImageRect("images/produtos/"..listProds[i].sku..".jpg",sizeImage,sizeImage,true);
            yA = (((((e+f)/2) - ((a+b)/2)) / display.contentWidth) * x) + (( a + b)/2)
            scala1 =  - ((((e - a + b - f) / display.contentWidth) * x) + (a - b))
            image.x = x
            image.y = yA
            image.xScale = (scala1 * t1) / 100
            image.yScale = (scala1 * t1) / 100
            if(scala1 > 0) then
                scrollView:insert(image);
                image.touch = onDragAndDropImage;
                image:addEventListener("touch", image);
                image.product = listProds[i];
            end
                      
            i = i + 1
            
            if(i<=#listProds)then
                local image = display.newImageRect("images/produtos/"..listProds[i].sku..".jpg",sizeImage,sizeImage,true);
                yB = (((((f + g)/2) - ((b + c)/2)) / display.contentWidth) * x) + ((b + c)/2)
                scala1 =  - ((((e - a + b - f) / display.contentWidth) * x) + (a - b))
                image.x = x
                image.y = yB
                image.xScale = (scala1 * t1) / 100
                image.yScale = (scala1 * t1) / 100
                if(scala1 > 0) then
                    scrollView:insert(image);
                    image.touch = onDragAndDropImage;
                    image:addEventListener("touch", image);
                    image.product = listProds[i];
                end
                i = i + 1
            
                if(i<=#listProds)then
                    local image = display.newImageRect("images/produtos/"..listProds[i].sku..".jpg",sizeImage,sizeImage,true);
                    yC = (((((g+h)/2) - ((c+d)/2)) / display.contentWidth) * x) + ((c + d)/2)
                    scala1 =  - ((((e - a + b - f) / display.contentWidth) * x) + (a - b))
                    image.x = x
                    image.y = yC
                    image.xScale = (scala1 * t1) / 100
                    image.yScale = (scala1 * t1) / 100
                    if(scala1 > 0) then
                        scrollView:insert(image);
                        image.touch = onDragAndDropImage;
                        image:addEventListener("touch", image);
                        image.product = listProds[i];
                    end
                    i = i + 1
                end
            end
            --incrementando x
            x = x + (scala1 * t2)
        end
        scrollView.x = 0;
        scrollView.y = 0;
--        scrollView.initX = display.contentWidth *0.05;
--        scrollView.initY = display.contentHeight *0.05;
--        scrollView.qtyCols = qtyCol;
--        scrollView.qtyRows = qtdMaxRow;
--        scrollView.initWidth = scrollView._view.width;
--        scrollView.initHeight = scrollView._view.height;  
    end
    
    --Função pega carrinho atual
    function home:getCart()
        return cart;
    end
    
    return home;
end

