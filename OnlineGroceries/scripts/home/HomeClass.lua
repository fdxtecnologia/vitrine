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
            self.x = self.x + movedX
            self.startX = event.x

            local teste = self.width + self.x;
            print("POSICAO TESTE: --- "..teste)
            if teste < display.contentWidth then
                if(self.finalX == nil)then
                    self.finalX = self.x;
                end
                transition.to(self, { time=100,x=self.finalX})
            end

            local group = self.colunas[1];
            print("Coluna 1:",group[1]);
        elseif event.phase == "ended" then
            if self.x > self.initX then
                print("MAISS");
                transition.to(self, { time=100,x=self.initX})
            end
            display.getCurrentStage():setFocus(nil)
        end             
    end

    --TextField Handler
    local function onTextFieldListener(self,event)
        local phase = event.phase;

        print("PHASEEE: ----- ",event.phase);

        if phase == "ended" then
            self:removeSelf();
        end
    end

    --Fake TextField handler
    local function onTouchFaketextField(self,event)
        local phase = event.phase;
        local parentGroup = self.parent;

        if phase == "began" then
            local textField = native.newTextField(self.x, self.y, self.width, self.height);
            textField.userInput = onTextFieldListener;
            textField:addEventListener("userInput",textField);
            native.setKeyboardFocus(textField);
            textField:setFocus(true);
            --textField:dispatchEvent({name="userInput",phase="began", target=textField });
            --parentGroup:insert(textField);
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

        local searchGroup = display.newGroup();
        local spotlightImg = display.newImage("images/spotlight.png");
        spotlightImg.x = 0;
        spotlightImg.y = 0;
        spotlightImg.width = display.contentHeight*0.08;
        spotlightImg.height = display.contentHeight*0.08;
        spotlightImg.touch = onSearchTouch;
        spotlightImg:addEventListener("touch",spotlightImg);
        local fakeSearchField = display.newRect(0,0,display.contentWidth*0.5, display.contentHeight*0.05);
        fakeSearchField:setReferencePoint(display.TopLeftReferencePoint);
        fakeSearchField.x, fakeSearchField.y  = 0,0;
        searchGroup:insert(fakeSearchField);
        searchGroup:insert(spotlightImg);
        fakeSearchField.touch =  onTouchFaketextField;
        fakeSearchField:addEventListener("touch",fakeSearchField);

        gCart.prod = prod_listener
        gCart.listProdY = 0;
        gCart.cart = {id=1,products={}};
        gCart:addEventListener("prod",gCart);
        gCart.touch = onDragGCart;
        gCart:addEventListener("touch",gCart);
        
        carousel:insert(searchGroup);
        parentGroup:insert(gCart);
        parentGroup.gCart = gCart;
        parentGroup:insert(carousel);
        carousel.initX = carousel.x;
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
            print("Began");
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
                end
                -- local dx = math.abs( event.x - event.xStart )
                -- if dx > 0 then
                --     display.getCurrentStage():setFocus(gCarousel);
                -- end

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
            local bgCarousel = display.newRect(0,0,scrollView.width,display.contentHeight);
            bgCarousel:setFillColor(255,255,255,0);
            scrollView:insert(1,bgCarousel);
            --incrementando x
            x = x + (scala1 * t2)
        end
        scrollView.colunas = colunas;
        scrollView.x = 0;
        scrollView.y = 0;
    end
    
    return home;
end

