module(...,package.seeall);

function new()
    
    local home = {};

    local numImagesPerCol = 2;
    
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
                movedX = event.x - self.startX;
                self.x = self.x + movedX;
                self.startX = event.x;
            elseif phase == "ended" then
                    if(self.x <= display.contentWidth*0.5)then
                        self.x = 0;
                    else
                        self.x = display.contentWidth;
                        --self:toBack();
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
            transition.to(self, {time = 100, x=self.x-display.contentWidth*0.2});
        elseif(event.type == "added")then
            self:addToList(event.product);
            transition.to(self, {time = 100, x=self.x+display.contentWidth*0.2});
        elseif(event.type == "release")then
            transition.to(self, {time = 100, x=self.x+display.contentWidth*0.2});
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
                print("POSICAO TESTE: --- "..self.x)
                if teste < display.contentWidth then
                    if(self.finalX == nil)then
                        self.finalX = self.x;
                        print("FINAL X", self.finalX," WIDTH ",self.width - display.contentWidth);
                    end
                    transition.to(self, { time=100,x=self.finalX})
                end
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
    function home:buildCenario(listProds,parentGroup,numColunas)
        --Taxa de incremento da escala
        
        numImagesPerCol = numColunas;

        local gCart = require("scripts.home.CartTabClass").new();     
        
        local carousel = display.newGroup(); 
        
        home:createThumbProd(listProds,carousel);

        carousel.touch = onTouch;
        carousel:addEventListener("touch", carousel);

        local textFieldSearch = require("scripts.fdxTextField").new((display.contentWidth*0.5)-(display.contentWidth*0.25),display.contentHeight*0.02,display.contentWidth*0.5,display.contentHeight*0.08,"Busca","center");
        textFieldSearch.letters = onEachLetters;
        textFieldSearch:addEventListener("letters",textFieldSearch);


        gCart.prod = prod_listener
        gCart.listProdY = 0;
        gCart.cart = {id=1,products={}};
        gCart:addEventListener("prod",gCart);
        gCart.touch = onDragGCart;
        gCart:addEventListener("touch",gCart);

        parentGroup.gCart = gCart;
        parentGroup:insert(carousel);
        parentGroup:insert(gCart);
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
        local image = gThumb[2];

        if(event.phase=="began")then
            local event = {
                name = "prod",
                type = "selected"
            }
            print("Began");
            display.getCurrentStage():setFocus(self);
            gCart:dispatchEvent(event);
            image.markX = image.x;
            image.markY = image.y;
            self.isFocus = true;
            gThumb:toFront();
            gCol:toFront();
        end
        if(self.isFocus == true) then
            if(event.phase=="moved")then
                    local x = (event.x - event.xStart) + image.markX;
                    local y = (event.y - event.yStart) + image.markY;
                    image.x, image.y = x,y;
            elseif(event.phase=="ended")then
                    if(event.x >= gCart.x)then
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
                image.x = image.markX;
                image.y = image.markY;
                print("SET FOCUS NIL");
                display.getCurrentStage():setFocus(nil);
               self.isFocus = nil;
            end
        end
        return true;
    end
    
    -- Cria perspectiva
    function home:createThumbProd(listProds,scrollView)

        local i = 1;
        local sizeBackGround = (display.contentHeight*0.8)/numImagesPerCol;
        local sizeImage = (display.contentHeight*0.64)/numImagesPerCol;
        local xThumb = 0;
        local prodIndex = 1;
        local colunas={};
        local qtdProd = math.ceil(#listProds/numImagesPerCol);
        local touchableAreaSize = sizeImage*0.3;
        local showTouchableArea = false;

        print("qtdProd ",qtdProd);
        while i<= qtdProd do 

            local yThumb = display.contentHeight*0.2;
            local coluna = display.newGroup();

            for j=1, numImagesPerCol do
                if(listProds[prodIndex] == nil) then
                    local thumbGroup = display.newGroup();
                    local background = display.newImageRect("images/Teste.png",sizeBackGround,sizeBackGround,true);
                    background:setReferencePoint(display.TopLeftReferencePoint);
                    background.x = 0;
                    background.y = 0;
                    thumbGroup.x = xThumb;
                    thumbGroup.y = yThumb;
                    thumbGroup:insert(background);
                    coluna:insert(thumbGroup);
                    yThumb = yThumb + sizeBackGround;
                else
                    local thumbGroup = display.newGroup();
                    local background = display.newImageRect("images/Teste.png",sizeBackGround,sizeBackGround,true);
                    background:setReferencePoint(display.TopLeftReferencePoint);
                    background.x = 0;
                    background.y = 0;
                    local image = display.newImageRect("images/produtos/"..listProds[prodIndex].sku..".png",sizeImage,sizeImage,true);
                    image:setReferencePoint(display.BottomCenterReferencePoint);
                    image.x = sizeBackGround/2;
                    image.y = (11/12)*sizeBackGround;
                    image.product = listProds[prodIndex];
                    local etiqueta = display.newImageRect("images/Etiqueta.png",sizeBackGround*0.7,sizeBackGround*0.15,true);
                    etiqueta:setReferencePoint(display.BottomCenterReferencePoint);
                    etiqueta.x = sizeBackGround/2;
                    etiqueta.y = (25/26)*sizeBackGround;
                    local favorite = display.newImageRect("images/Favorito.png",sizeBackGround*0.2,sizeBackGround*0.2,true);
                    favorite.x = image.width*1.1;
                    favorite.y = image.height*0.2;

                    --------- VERIFICAÇÃO se É o FAVORITO AQUIII
                    listProds[prodIndex].isFav = false;
                    if(listProds[prodIndex].isFav == true) then
                        favorite.alpha = 1;
                    else
                        favorite.alpha = 0;
                    end
                    --------------------------------------------
                    local onSale = display.newImageRect("images/Promocao.png", sizeBackGround*0.25,sizeBackGround*0.2,true);
                    onSale.x = image.x - image.width/2.5;
                    onSale.y = image.y - image.height*0.95;

                    --------- VERIFICAÇÃO se É Ofertar AQUIII
                    listProds[prodIndex].isOnSale = true;
                    if(listProds[prodIndex].isOnSale == true) then
                        onSale.alpha = 1;
                    else
                        onSale.alpha = 0;
                    end
                    --------------------------------------------
                    local priceText = display.newText("R$ "..listProds[prodIndex].price.."- UN",0,0,native.systemFont, display.contentHeight*0.03);
                    priceText:setReferencePoint(display.CenterReferencePoint);
                    priceText.x = etiqueta.x;
                    priceText.y = etiqueta.y - (priceText.height/2)*1.5;
                    priceText:setTextColor(0,0,0);

                    local touchableArea = display.newRect(0,0,touchableAreaSize,touchableAreaSize);
                    touchableArea:setReferencePoint(display.CenterReferencePoint);
                    if(showTouchableArea == true) then
                        touchableArea:setFillColor(0,255,100,255);
                    else
                       touchableArea:setFillColor(0,255,100,0);
                    end 
                    touchableArea.x = sizeBackGround/2;
                    touchableArea.y = sizeBackGround/2;

                    touchableArea.touch = onDragAndDropImage;
                    touchableArea:addEventListener("touch", touchableArea);
                    thumbGroup:insert(background);
                    thumbGroup:insert(image);
                    thumbGroup:insert(touchableArea);
                    thumbGroup:insert(etiqueta);
                    thumbGroup:insert(priceText);
                    thumbGroup:insert(favorite);
                    thumbGroup:insert(onSale);

                    thumbGroup.x = xThumb;
                    thumbGroup.y = yThumb;
                    coluna:insert(thumbGroup);
                    inMemDB:insertIntoProdTable(xThumb,yThumb,listProds[prodIndex].title);

                    yThumb = yThumb + sizeBackGround;
                    prodIndex = prodIndex +1;
                end
            end
            table.insert(colunas,coluna);
            scrollView:insert(coluna);

            xThumb = xThumb+sizeBackGround;
            i = i +1;
        end

        print("TAMANHO LIST PRODS", #listProds)

        scrollView.x =0;
        scrollView.y =0;

        -- --COMEÇANDO
        -- local sizeImage = 90;
        -- local sizeBackGround = 100;
        -- local touchableAreaSize = sizeImage*0.3;
        -- local a,b,c,d,e,f,g,h,t2,x
        -- local t1, t2
        -- local yA, yB, yC
        -- local scala1, scalaP
        -- local showTouchableArea = false;
        
        -- --Atribuições
        -- a = display.contentHeight * 0.1
        -- b = display.contentHeight * 0.35
        -- c = display.contentHeight * 0.6
        -- d = display.contentHeight * 0.85
        -- e=a
        -- --e = display.contentHeight * 0.05
        -- --f = display.contentHeight * 0.1
        -- f=b
        -- --g = display.contentHeight * 0.15
        -- g=c
        -- --h = display.contentHeight * 0.2
        -- h=d
        -- x = 0
        
        -- --T1 Multiplica a escala
        -- t1 = 1
        -- scala1 =   -((((e - a + b - f) / display.contentWidth) * x) + (a - b))
        -- x = scala1 * 0.6;
        -- -- T2 multiplica o passo de X
        -- t2 = 1.23
        -- -- 
        -- local i = 1
        -- local numColunas = 1;
        -- local colunas={};
        -- while i <=#listProds do
        --     local group = display.newGroup();
        --     sizeBackGround = ((1-0.2)*display.contentHeight)/3;
        --     local background = display.newImageRect("images/Teste.png",sizeBackGround,sizeBackGround,true);
        --     background.x = x;
        --     local image = display.newImageRect("images/produtos/smirnoff.png",sizeImage,sizeImage,true);
        --     yA = display.contentHeight*0.2;
        --     image.x = x
        --     image.y = yA
        --     background.y = yA;
        --     image.xScale = (scala1 * t1) / 100
        --     image.yScale = (scala1 * t1) / 100
        --     local touchableArea = display.newRect(0,0,touchableAreaSize,touchableAreaSize);
        --     touchableArea:setReferencePoint(display.CenterReferencePoint);
        --     if(showTouchableArea == true) then
        --         touchableArea:setFillColor(0,255,100,255);
        --     else
        --        touchableArea:setFillColor(0,255,100,0);
        --     end 
        --     touchableArea.x = x;
        --     touchableArea.y = yA;
        --     if(scala1 > 0) then
        --         local thumbGroup = display.newGroup();
        --         thumbGroup:insert(background);
        --         thumbGroup:insert(image);
        --         thumbGroup:insert(touchableArea);
        --         touchableArea.image = image;
        --         touchableArea.group = thumbGroup;
        --         group:insert(thumbGroup);
        --         inMemDB:insertIntoProdTable(image.x-(image.width/2),image.y,listProds[i].title);
        --         touchableArea.touch = onDragAndDropImage;
        --         touchableArea:addEventListener("touch", touchableArea);
        --         image.product = listProds[i];
        --     end
                      
        --     i = i + 1
            
        --     if(i<=#listProds)then
        --         local background = display.newImageRect("images/Teste.png",sizeBackGround,sizeBackGround,true);
        --         background.x = x;
        --         local image = display.newImageRect("images/produtos/smirnoff.png",sizeImage,sizeImage,true);
        --         yB = yA+sizeBackGround;
        --         image.x = x
        --         image.y = yB
        --         background.y = yB;
        --         image.xScale = (scala1 * t1) / 100
        --         image.yScale = (scala1 * t1) / 100
        --         local touchableArea = display.newRect(0,0,touchableAreaSize,touchableAreaSize);
        --         touchableArea:setReferencePoint(display.CenterReferencePoint);
        --         if(showTouchableArea == true) then
        --             touchableArea:setFillColor(0,255,100,255);
        --         else
        --            touchableArea:setFillColor(0,255,100,0);
        --         end 
        --         touchableArea.x = x;
        --         touchableArea.y = yB;
        --         if(scala1 > 0) then
        --             local thumbGroup = display.newGroup();
        --             thumbGroup:insert(background);
        --             thumbGroup:insert(image);
        --             thumbGroup:insert(touchableArea);
        --             touchableArea.image = image;
        --             touchableArea.group = thumbGroup;
        --             group:insert(thumbGroup);
        --             inMemDB:insertIntoProdTable(image.x-(image.width/2),image.y,listProds[i].title);
        --             touchableArea.touch = onDragAndDropImage;
        --             touchableArea:addEventListener("touch", touchableArea);
        --             image.product = listProds[i];
        --         end
        --         i = i + 1
            
        --         if(i<=#listProds)then
        --             local background = display.newImageRect("images/Teste.png",sizeBackGround,sizeBackGround,true);
        --             background.x = x;
        --             local image = display.newImageRect("images/produtos/smirnoff.png",sizeImage,sizeImage,true);
        --             yC = yB + sizeBackGround;
        --             image.x = x
        --             image.y = yC
        --             background.y = yC;
        --             image.xScale = (scala1 * t1) / 100
        --             image.yScale = (scala1 * t1) / 100
        --             local touchableArea = display.newRect(0,0,touchableAreaSize,touchableAreaSize);
        --             touchableArea:setReferencePoint(display.CenterReferencePoint);
        --             if(showTouchableArea == true) then
        --                 touchableArea:setFillColor(0,255,100,255);
        --             else
        --                touchableArea:setFillColor(0,255,100,0);
        --             end 
        --             touchableArea.x = x;
        --             touchableArea.y = yC;                   
        --             if(scala1 > 0) then
        --                 local thumbGroup = display.newGroup();
        --                 thumbGroup:insert(background);
        --                 thumbGroup:insert(image);
        --                 thumbGroup:insert(touchableArea);
        --                 touchableArea.image = image;
        --                 touchableArea.group = thumbGroup;
        --                 group:insert(thumbGroup);
        --                 inMemDB:insertIntoProdTable(image.x-(image.width/2),image.y,listProds[i].title);
        --                 touchableArea.touch = onDragAndDropImage;
        --                 touchableArea:addEventListener("touch", touchableArea);
        --                 image.product = listProds[i];
        --             end
        --             i = i + 1
        --         end
        --     end
        --     table.insert(colunas,group);
        --     scrollView:insert(colunas[numColunas]);
        --     numColunas=numColunas+1;
        --     local bgCarousel = display.newRect(0,0,scrollView.width,scrollView.height);
        --     bgCarousel:setFillColor(255,255,255,0);
        --     scrollView:insert(1,bgCarousel);
        --     --incrementando x
        --     x = x + sizeBackGround;
        -- end
        -- scrollView.colunas = colunas;
        -- scrollView.x = 0;
        -- scrollView.y = 0;
    end
    
    return home;
end

