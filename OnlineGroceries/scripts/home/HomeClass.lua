module(...,package.seeall);
system.activate("multitouch");

function new()
    
    local home = {};
    
    local function onDragGCart(self,event)
        local phase = event.phase;
        
        if event.phase == "began" then
            self.startX = self.x;
            self.startY = self.y;
            self.initPosY = self.y;
            self:toFront();
            display.getCurrentStage():setFocus(self)
        elseif phase == "moved" then
            movedY = event.y - self.startY;
            self.y = self.y + movedY;
            self.startY = event.y;
        elseif phase == "ended" then
                if(self.y <= display.contentHeight*0.5)then
                    self.y = 0;
                else
                    self.y = display.contentHeight;
                    self:toBack();
                end
            display.getCurrentStage():setFocus(nil);
        end
    end
    
    -- Evento que trata a aba do carrinho
    local function prod_listener(self,event)
        if(event.type == "selected")then
            transition.to(self, {time = 100, y=self.y-display.contentHeight*0.1});
        elseif(event.type == "added")then
            self:addToList(event.product);
            transition.to(self, {time = 100, y=self.y+display.contentHeight*0.1});
        elseif(event.type == "release")then
            transition.to(self, {time = 100, y=self.y+display.contentHeight*0.1});
        end
    end
    
    -- Move carousel
    local function onTouch(self, event)
        if event.phase == "began" then
            print("TOUCH");
            self.startX= event.x
            display.getCurrentStage():setFocus(self)
        elseif event.phase == "moved" then
            local movedX = event.x - self.startX
            print(movedX, movedY)
            self.x = self.x + movedX
            self.startX = event.x
            local group = self.colunas[1];
            print("Coluna 1:",group[1]);
            self.xScale = 1+((self.x)*(-1))/display.contentWidth;
            self.yScale = 1+((self.x)*(-1))/display.contentWidth;
        elseif event.phase == "ended" then
            display.getCurrentStage():setFocus(nil)
        end             
    end
    
    --Construção do cenario
    function home:buildCenario(listProds,parentGroup)
        --Taxa de incremento da escala
        local t3 = 0.95;
        
        local gCart = require("scripts.home.CartTabClass").new();     
        
        local carousel = display.newGroup();     
        
        home:createThumbProd(listProds,carousel);
        
        carousel.touch = onTouch
        carousel:addEventListener("touch", carousel);
        
        gCart.prod = prod_listener
        gCart.listProdY = 0;
        gCart.cart = {id=1,products={}};
        gCart:addEventListener("prod",gCart);
        gCart.touch = onDragGCart;
        gCart:addEventListener("touch",gCart);
        
        parentGroup:insert(gCart);
        parentGroup.gCart = gCart;
        parentGroup:insert(carousel);
        parentGroup.carousel = carousel;
    end   
    
     -- Drag and Drop dos items
    local function onDragAndDropImage(self,event)
        
        local gCol = self.parent;
        local gCarousel = gCol.parent;
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
        e=a
        --e = display.contentHeight * 0.05
        --f = display.contentHeight * 0.1
        f=b
        --g = display.contentHeight * 0.15
        g=c
        --h = display.contentHeight * 0.2
        h=d
        x = 0
        
        --T1 Multiplica a escala
        t1 = 1
        scala1 =   -((((e - a + b - f) / display.contentWidth) * x) + (a - b))
        x = scala1 * 0.6;
        -- T2 multiplica o passo de X
        t2 = 1.2
        -- 
        local i = 1
        local numColunas = 1;
        local colunas={};
        while i <=#listProds do
            local group = display.newGroup();
            local image = display.newImageRect("images/produtos/"..listProds[i].sku..".jpg",sizeImage,sizeImage,true);
            yA = (((((e+f)/2) - ((a+b)/2)) / display.contentWidth) * x) + (( a + b)/2)
            scala1 =  - ((((e - a + b - f) / display.contentWidth) * x) + (a - b))
            image.x = x
            image.y = yA
            image.xScale = (scala1 * t1) / 100
            image.yScale = (scala1 * t1) / 100
            if(scala1 > 0) then
                group:insert(image);
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
                    group:insert(image);
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
                        group:insert(image);
                        image.touch = onDragAndDropImage;
                        image:addEventListener("touch", image);
                        image.product = listProds[i];
                    end
                    i = i + 1
                end
            end
            table.insert(colunas,group);
            scrollView:insert(colunas[numColunas]);
            numColunas=numColunas+1;
            --incrementando x
            x = x + (scala1 * t2)
        end
        scrollView.colunas = colunas;
        scrollView.x = 0;
        scrollView.y = 0;
    end
    
    return home;
end

