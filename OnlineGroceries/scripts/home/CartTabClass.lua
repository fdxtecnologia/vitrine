module(...,package.seeall);
local storyboard = require( "storyboard" );
saver = require( "scripts.Utils.dataSaver" );

function new()
    
    --Definitions
    local gCart = display.newGroup();
    gCart.x = display.contentWidth;
    gCart.y = 0;
    local pullTab = display.newCircle(gCart,0, display.contentHeight*0.1, 25);
    gCart.pullTab = pullTab;
    local cart = {products={}};
    pullTab:setFillColor(200, 200, 200, 255); 
    local widget = require( "widget" );
    local tableRowsCount = 0;
    local qtyProds = 0;

    local loadFile = saver.loadValue("cart");

    --Navigate to CheckOut
    local function onCheckOutTouch(self,event)
        storyboard.gotoScene("scripts.checkout.CheckoutScene");
    end
    
    --Handle Deletebutton
    local function onTouchDeleteProduct(self,event)
        local phase = event.phase;
        local btn = self;
        local row = btn.parent;

        local listProds = cart.products;

        if phase == "began" then
            print("List lenght: "..#listProds);
            table.remove(listProds, btn.row.index);
            tableRowsCount = tableRowsCount -1;
            gCart:remakeTable();
            gCart:refreshSubtotal();
            saver.saveValue("cart", cart);
        end
        return true;   
    end

    function gCart:tableRefresh()

        local newCart = cart;
        
        for i=1,#cart.products do
            newCart.products[i] = cart.products[i];
        end

        cart = newCart;
    end

    local function onTouchPlusProduct(self,event)
        print("Plus Touched")
        local phase = event.phase;
        local btn = self;

        if phase == "began" then

            cart.products[btn.row.index].quantity = cart.products[btn.row.index].quantity + 1;
            cart.products[btn.row.index].totalPrice = cart.products[btn.row.index].price * cart.products[btn.row.index].quantity;
            gCart:remakeTable();
            gCart:refreshSubtotal();
            saver.saveValue("cart", cart);
        end
        return true;
    end

    local function onTouchMinusProduct(self,event)
        local phase = event.phase;
        local btn = self;

        if phase == "began" then
            if(cart.products[btn.row.index].quantity >=2 ) then
                cart.products[btn.row.index].quantity = cart.products[btn.row.index].quantity - 1;
                cart.products[btn.row.index].totalPrice = cart.products[btn.row.index].price * cart.products[btn.row.index].quantity;
                gCart:remakeTable();
                gCart:refreshSubtotal();
            end
            saver.saveValue("cart", cart);
        end
        return true;
    end
    
    
    -- Handle row rendering
    local function onRowRender( event )
        local phase = event.phase
        local row = event.row
        local product = cart.products[row.index];
        
        --View da row
        local rowImg = display.newImage(row,"images/produtos/"..product.sku..".jpg");
        rowImg.width = rowImg.width*0.25;
        rowImg.height = rowImg.height*0.25;
        rowImg:setReferencePoint(display.TopLeftReferencePoint);
        rowImg.x = row.contentWidth*0.02;
        rowImg.y = row.contentHeight*0.05;
        
        local rowQty = display.newText(row, "Quantidade: "..product.quantity, 0,0, "Helvetica", display.contentWidth*0.02);
        rowQty:setTextColor(0,0,0);
        rowQty:setReferencePoint(display.CenterReferencePoint);
        rowQty.x = row.contentWidth*0.47;
        rowQty.y = row.contentHeight*0.75;
        row.rowQty = rowQty;
        
        local rowTitle = display.newText(row,product.title, 0, 0, "Helvetica", display.contentWidth*0.02);
        rowTitle:setTextColor(0,0,0);
        rowTitle:setReferencePoint(display.CenterReferencePoint);
        rowTitle.x = row.contentWidth*0.47;
        rowTitle.y = row.contentHeight*0.5;
        
        local rowPrice = display.newText(row,"R$ "..product.totalPrice, 0, 0, "Helvetica", display.contentWidth*0.025);
        rowPrice:setTextColor(0,0,0);
        rowPrice:setReferencePoint(display.CenterRightReferencePoint);
        rowPrice.x = row.contentWidth - row.contentWidth*0.1;
        rowPrice.y = row.contentHeight*0.5;
        row.rowPrice = rowPrice;

        local btnsProdOptions = display.newGroup();

        --Minus item button
        local gMinusBtn = display.newGroup();
        local minusBtn = display.newRect(gMinusBtn,0, 0,row.contentHeight*0.97, row.contentHeight*0.97);
        minusBtn:setFillColor(0,171,255,255);
        local minusText = display.newText(gMinusBtn, "-", 0, 0, "Helvetica", 15);
        minusText:setReferencePoint(display.CenterReferencePoint);
        minusText.x = minusBtn.width*0.5;
        minusText.y = minusBtn.height*0.5;
        gMinusBtn.x = 0;
        gMinusBtn.row = row;
        gMinusBtn.touch = onTouchMinusProduct;
        gMinusBtn:addEventListener("touch", gMinusBtn);
        
        --Plus item button 
        local gPlusBtn = display.newGroup();
        local plusBtn = display.newRect(gPlusBtn, 0,0,row.contentHeight*0.97, row.contentHeight*0.97);
        plusBtn:setFillColor(0,162,255,255);
        local plusText = display.newText(gPlusBtn, "+", 0, 0, "Helvetica", 15);
        plusText:setReferencePoint(display.CenterReferencePoint);
        plusText.x = plusBtn.width*0.5;
        plusText.y = plusBtn.height*0.5;
        gPlusBtn.x = minusBtn.width;
        gPlusBtn.row = row;
        gPlusBtn.product = product;
        gPlusBtn.touch = onTouchPlusProduct;
        gPlusBtn:addEventListener("touch", gPlusBtn);
        
        --Delete button
        local gDeleteBtn = display.newGroup();
        local deleteBtn = display.newRect(gDeleteBtn, 0, 0, row.contentHeight*0.97, row.contentHeight*0.97);
        deleteBtn:setFillColor(255,0,0,255);
        local deleteText = display.newText(gDeleteBtn, "Delete", 0, 0, "Helvetica", 15);
        deleteText:setReferencePoint(display.CenterReferencePoint);
        deleteText.x = deleteBtn.width*0.5;
        deleteText.y = deleteBtn.height*0.5;
        gDeleteBtn.x = plusBtn.width + minusBtn.width;
        gDeleteBtn.row = row;
        gDeleteBtn.product = product;
        gDeleteBtn.touch = onTouchDeleteProduct;
        gDeleteBtn:addEventListener("touch",gDeleteBtn);
        
        row.isEditOpen = false;

        btnsProdOptions:insert(gMinusBtn);
        btnsProdOptions:insert(gPlusBtn);
        btnsProdOptions:insert(gDeleteBtn);

        btnsProdOptions:setReferencePoint(display.TopLeftReferencePoint);
        btnsProdOptions.x = row.contentWidth;
        row.btnsProdOptions = btnsProdOptions;


        row:insert(btnsProdOptions);  
    end
    
    local function onRowTouch(event)
        local phase = event.phase;
        local row = event.target;
        
        if phase == "swipeRight" then
            if(row.isEditOpen==true)then
                transition.to(row.btnsProdOptions, {time=80, x=row.btnsProdOptions.x + row.btnsProdOptions.width*1.2});
                row.isEditOpen = false;
            end
        elseif phase == "swipeLeft" then
            if(row.isEditOpen == false)then
                row.btnsProdOptions:setReferencePoint(display.TopRightReferencePoint);
                transition.to(row.btnsProdOptions, {time=80, x=row.btnsProdOptions.x - row.btnsProdOptions.width*1.2});
                row.isEditOpen = true;
            end
        end
        return true;
    end

    cart.subtotal = 0;

    local topTab = display.newRect(0, 0, display.contentWidth*0.06, display.contentHeight);
    topTab:setFillColor(200, 200, 200, 255);

    local countText = display.newText("0",0,0,native.systemFont, display.contentHeight*0.04);
    countText:setTextColor(0,0,0);
    countText:setReferencePoint(display.CenterReferencePoint);
    countText.x = pullTab.x - (pullTab.width/6);
    countText.y = pullTab.y;

    local totalTab = display.newRect(0,0, display.contentWidth, display.contentHeight*0.1);
    totalTab:setReferencePoint(display.BottomLeftReferencePoint);
    totalTab.y = display.contentHeight;
    totalTab:setFillColor(200, 200, 200, 255);

    print("topTab WIDTH ", topTab.width)


    --Botão Checkout
    local gCheckOutBtn = display.newGroup();
    local checkOutBtn = display.newRect(gCheckOutBtn, 0, 0, display.contentWidth*0.12, display.contentHeight*0.1);
    checkOutBtn:setFillColor(0,255,120,255);
    local checkOutText = display.newText(gCheckOutBtn, "Checkout", 0, 0, "Helvetica", 13);
    checkOutText:setReferencePoint(display.CenterReferencePoint);
    checkOutText.x = checkOutBtn.width/2;
    checkOutText.y = checkOutBtn.height/2;
    gCheckOutBtn:setReferencePoint(display.BottomRightReferencePoint);
    gCheckOutBtn.x = display.contentWidth*0.98;
    gCheckOutBtn.y = display.contentHeight;
    gCheckOutBtn.touch = onCheckOutTouch;
    gCheckOutBtn:addEventListener("touch", gCheckOutBtn);
    
    local totalText = display.newText("Subtotal: R$ 0.00 ",0,0,"Helvetica",20);
    totalText:setTextColor(0,0,0);
    totalText:setReferencePoint(display.BottomCenterReferencePoint);
    totalText.x = display.contentWidth *0.5;
    totalText.y = display.contentHeight - display.contentHeight*0.01;
    
    local tableView = widget.newTableView{
        top=0,
        left = topTab.width;
        width = display.contentWidth - topTab.width,
        height = display.contentHeight-totalTab.height,
        listener = tableViewListener,
        onRowRender = onRowRender,
        onRowTouch = onRowTouch
    }

    
    gCart.tableView = tableView;
    gCart.cart = cart;
    gCart:insert(tableView);
    tableView:toFront();
    gCart:insert(topTab);
    gCart.topTab = topTab;
    gCart:insert(countText);
    gCart:insert(totalTab);
    gCart.totalTab = totalTab;
    gCart:insert(gCheckOutBtn);
    gCart:insert(totalText);
    
    function gCart:getCart()
        return cart;
    end
    
    function gCart:setCart(newCart)
       cart = newCart;
    end
    
    function gCart:refreshSubtotal()
        local valor = 0;

        for i=1,#cart.products do
            valor = valor + (cart.products[i].totalPrice);
        end

        cart.subtotal = valor;
        totalText.text ="Quantidade: "..qtyProds.."   Subtotal: R$ "..cart.subtotal;
    end

    function gCart:remakeTable()

        qtyProds = 0;
        local isRepeated = false;
        local isCategory = false
        local rowHeight = display.contentHeight*0.2;
        local rowColor = 
        { 
            default = { 255, 255, 255 },
        }
        local lineColor = { 255, 255, 255 }


        gCart.tableView:removeSelf();
        gCart.tableView = nil;

        local newTableView = widget.newTableView{
            top=0,
            left=topTab.width,
            width = display.contentWidth,
            height = display.contentHeight-totalTab.height,
            listener = tableViewListener,
            onRowRender = onRowRender,
            onRowTouch = onRowTouch
        }

        local mask = graphics.newMask("images/mask.png");
        print("MASK WIDTH ", mask);

        gCart:insert(1,newTableView);
        gCart.tableView = newTableView;

        for i=1,#cart.products do
            gCart.tableView:insertRow
            {
                isCategory = isCategory,
                rowHeight = rowHeight,
                rowColor = rowColor,
                lineColor = lineColor,
            }
            qtyProds=qtyProds+cart.products[i].quantity;
        end

        countText.text = qtyProds;

        gCart:refreshSubtotal();       
    end
    
    function gCart:refreshList()
        gCart.tableView:deleteAllRows();
        local isCategory = false
        local rowHeight = display.contentHeight*0.2;
        local rowColor = 
        { 
            default = { 255, 255, 255 },
        }
        local lineColor = { 255, 255, 255 }

        for i=1,#cart.products do
            gCart.tableView:insertRow
            {
                isCategory = isCategory,
                rowHeight = rowHeight,
                rowColor = rowColor,
                lineColor = lineColor,
            } 
        end
    end

    function gCart:deleteCartState()
        local clearCart = {products={}};
        saver.saveValue("cart",clearCart);
    end
    
    function gCart:addToList(product)
        local isRepeated = false;
        local isCategory = false
        local rowHeight = display.contentHeight*0.2;
        local rowColor = 
        { 
            default = { 255, 255, 255 },
        }
        local lineColor = { 255, 255, 255 }

        for i=1,#cart.products do
            print("Entrou laço "..cart.products[i].title);
            if(cart.products[i].idProduct == product.idProduct)then
                isRepeated = true;
                cart.products[i].quantity = cart.products[i].quantity + 1;
                cart.products[i].totalPrice = product.price * cart.products[i].quantity;
                gCart:refreshList();
            end
        end
        if(isRepeated==false)then
            local newProd = product
            newProd.quantity = 1;
            newProd.totalPrice = product.price;
            table.insert(cart.products, newProd);
            gCart.tableView:insertRow
            {
                isCategory = isCategory,
                rowWidth = display.contentWidth,
                rowHeight = rowHeight,
                rowColor = rowColor,
                lineColor = lineColor,
            } 
            tableRowsCount = tableRowsCount +1;
        end 
       saver.saveValue("cart", cart);
       qtyProds=qtyProds+1;
       countText.text = qtyProds;
       
    end

    if(loadFile == nil) then
        saver.saveValue("cart",cart);
        loadFile = saver.loadValue("cart");
    else
            if(loadFile.products[1] == nil)then
                print("Arquivo nulo");
            else
                cart = loadFile;
                gCart:remakeTable();
                print("LOAD FILE "..cart.products[1].title);
            end
    end 
     
    return gCart;
end

