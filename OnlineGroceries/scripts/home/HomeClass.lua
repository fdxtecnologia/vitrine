module(...,package.seeall);

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
            self.isFocus = true;
        end
        if (self.isFocus == true) then
            if phase == "moved" then
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
                self.isFocus = nil;
            end
        end
        return true;
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
            self.isFocus = true;
        end
        if(self.isFocus == true) then
            if event.phase == "moved" then
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
                    transition.to(self, { time=100,x=self.initX})
                end
                display.getCurrentStage():setFocus(nil);
                self.isFocus = nil;
            end
        end

        return true;           
    end

    --Cada letra da busca dispara esse evento **AUTO-COMPLETE HANDLER**
    local function onEachLetters(self,event)
        local phase = event.type;
        local parentGroup = self.parent;
        local carousel = parentGroup.carousel;

        if phase == "editing" then
            --Aqui deve ser feita a pesquisa e mover o scrollbar para posição X armazenada no banco
            local resultSet = inMemDB:searchByName(event.text, 1);
            if(#resultSet < 1 ) then
                print("Nenhum resultado");
            else
                local name = resultSet[1].nameProduct;
                local posX = resultSet[1].posX; 

                transition.to(carousel,{time=100, x=posX*(-1)});
            end
        end
    end
    
    --Construção do cenario
    function home:buildCenario(listProds,parentGroup)
        --Taxa de incremento da escala
        local t3 = 0.95;
        
        local gCart = require("scripts.home.CartTabClass").new();     
        
        local carousel = display.newGroup();     
        
        home:createThumbProd(listProds,carousel);

        carousel.touch = onTouch;
        carousel:addEventListener("touch", carousel);

        -- local searchGroup = display.newGroup();
        -- local spotlightImg = display.newImage("images/spotlight.png");
        -- spotlightImg.x = 0;
        -- spotlightImg.y = 0;
        -- spotlightImg.width = display.contentHeight*0.08;
        -- spotlightImg.height = display.contentHeight*0.08;
        -- spotlightImg.touch = onSearchTouch;
        -- spotlightImg:addEventListener("touch",spotlightImg);

        -- searchGroup:insert(spotlightImg);

        local textFieldSearch = require("scripts.fdxTextField").new((display.contentWidth*0.5)-(display.contentWidth*0.25),display.contentHeight*0.02,display.contentWidth*0.5,display.contentHeight*0.05,"Busca","center");
        textFieldSearch.letters = onEachLetters;
        textFieldSearch:addEventListener("letters",textFieldSearch);


        gCart.prod = prod_listener
        gCart.listProdY = 0;
        gCart.cart = {id=1,products={}};
        gCart:addEventListener("prod",gCart);
        gCart.touch = onDragGCart;
        gCart:addEventListener("touch",gCart);

        parentGroup:insert(gCart);
        parentGroup.gCart = gCart;
        parentGroup:insert(carousel);
        parentGroup:insert(textFieldSearch);
        parentGroup.searchField = textFieldSearch;
        carousel.initX = carousel.x;
        parentGroup.carousel = carousel;
    end   
    
    local function listener(event,img)
        print("TESTE");
    end

     -- Drag and Drop dos items
    local function onDragAndDropImage(self,event)
        
        local gThumb = self.parent;
        local gCol = gThumb.parent;
        local gCarousel = gCol.parent;
        local parentGroup = gCarousel.parent;      
        local gCart = parentGroup.gCart;
        local image = self.image;

        if(event.phase=="began")then
            local event = {
                name = "prod",
                type = "selected"
            }
            print("Began");
            display.getCurrentStage():setFocus(self);
            gCart:dispatchEvent(event);
            gThumb.markX = gThumb.x;
            gThumb.markY = gThumb.y;
            self.isFocus = true;
            gThumb:toFront();
            gCol:toFront();
        end
        if(self.isFocus == true) then
            if(event.phase=="moved")then
                    local x = (event.x - event.xStart) + gThumb.markX;
                    local y = (event.y - event.yStart) + gThumb.markY;
                    gThumb.x, gThumb.y = x,y;
            elseif(event.phase=="ended")then
                    if(event.y >= gCart.y)then
                        print("ADDED");
                        local event = {
                            name = "prod",
                            type = "added",
                            product = image.product
                        }
                        gCart:dispatchEvent(event);
                    else
                        local event = {
                           name = "prod",
                           type = "release"
                        }
                        gCart:dispatchEvent(event)
                    end
                gThumb.x = gThumb.markX;
                gThumb.y = gThumb.markY;
                print("SET FOCUS NIL");
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
        local touchableAreaSize = sizeImage*0.3;
        local a,b,c,d,e,f,g,h,t2,x
        local t1, t2
        local yA, yB, yC
        local scala1, scalaP
        local showTouchableArea = false;
        
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
            local touchableArea = display.newRect(0,0,touchableAreaSize,touchableAreaSize);
            touchableArea:setReferencePoint(display.CenterReferencePoint);
            if(showTouchableArea == true) then
                touchableArea:setFillColor(0,255,100,255);
            else
               touchableArea:setFillColor(0,255,100,0);
            end 
            touchableArea.x = x;
            touchableArea.y = yA;
            if(scala1 > 0) then
                local thumbGroup = display.newGroup();
                thumbGroup:insert(image);
                thumbGroup:insert(touchableArea);
                touchableArea.image = image;
                touchableArea.group = thumbGroup;
                group:insert(thumbGroup);
                inMemDB:insertIntoProdTable(image.x-(image.width/2),image.y,listProds[i].title);
                touchableArea.touch = onDragAndDropImage;
                touchableArea:addEventListener("touch", touchableArea);
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
                local touchableArea = display.newRect(0,0,touchableAreaSize,touchableAreaSize);
                touchableArea:setReferencePoint(display.CenterReferencePoint);
                if(showTouchableArea == true) then
                    touchableArea:setFillColor(0,255,100,255);
                else
                   touchableArea:setFillColor(0,255,100,0);
                end 
                touchableArea.x = x;
                touchableArea.y = yB;
                if(scala1 > 0) then
                    local thumbGroup = display.newGroup();
                    thumbGroup:insert(image);
                    thumbGroup:insert(touchableArea);
                    touchableArea.image = image;
                    touchableArea.group = thumbGroup;
                    group:insert(thumbGroup);
                    inMemDB:insertIntoProdTable(image.x-(image.width/2),image.y,listProds[i].title);
                    touchableArea.touch = onDragAndDropImage;
                    touchableArea:addEventListener("touch", touchableArea);
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
                    local touchableArea = display.newRect(0,0,touchableAreaSize,touchableAreaSize);
                    touchableArea:setReferencePoint(display.CenterReferencePoint);
                    if(showTouchableArea == true) then
                        touchableArea:setFillColor(0,255,100,255);
                    else
                       touchableArea:setFillColor(0,255,100,0);
                    end 
                    touchableArea.x = x;
                    touchableArea.y = yC;                   
                    if(scala1 > 0) then
                        local thumbGroup = display.newGroup();
                        thumbGroup:insert(image);
                        thumbGroup:insert(touchableArea);
                        touchableArea.image = image;
                        touchableArea.group = thumbGroup;
                        group:insert(thumbGroup);
                        inMemDB:insertIntoProdTable(image.x-(image.width/2),image.y,listProds[i].title);
                        touchableArea.touch = onDragAndDropImage;
                        touchableArea:addEventListener("touch", touchableArea);
                        image.product = listProds[i];
                    end
                    i = i + 1
                end
            end
            table.insert(colunas,group);
            scrollView:insert(colunas[numColunas]);
            numColunas=numColunas+1;
            local bgCarousel = display.newRect(0,0,scrollView.width,scrollView.height);
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

