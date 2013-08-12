module(...,package.seeall);
local storyboard = require( "storyboard" );
saver = require( "scripts.Utils.dataSaver" );

function new()
    
    --Definitions
    local gCart = display.newGroup();
    gCart.x = 0;
    gCart.y = display.contentHeight;
    local pullTab = display.newCircle(gCart, display.contentWidth*0.5, 0, 25);
    local cart = {products={}};
    pullTab:setFillColor(125, 125, 125, 255); 
    local widget = require( "widget" );
    local tableRowsCount = 0;

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
        
        local rowQty = display.newText(row, "Quantidade: "..product.quantity, 0,0, "Helvetica", 14);
        rowQty:setReferencePoint(display.CenterReferencePoint);
        rowQty.x = row.contentWidth*0.5;
        rowQty.y = row.contentHeight*0.75;
        row.rowQty = rowQty;
        
        local rowTitle = display.newText(row,product.title, 0, 0, "Helvetica", 15);
        rowTitle:setReferencePoint(display.CenterReferencePoint);
        rowTitle.x = row.contentWidth*0.5;
        rowTitle.y = row.contentHeight*0.5;
        
        local rowPrice = display.newText(row,"R$ "..product.totalPrice, 0, 0, "Helvetica", 16);
        rowPrice:setReferencePoint(display.CenterRightReferencePoint);
        rowPrice.x = row.contentWidth - rowQty.contentWidth*0.1;
        rowPrice.y = row.contentHeight*0.5;
        row.rowPrice = rowPrice;
        
        --Minus item button
        local gMinusBtn = display.newGroup();
        local minusBtn = display.newRect(gMinusBtn,0, 0,row.contentHeight*0.97, row.contentHeight*0.97);
        minusBtn:setFillColor(0,171,255,255);
        local minusText = display.newText(gMinusBtn, "-", 0, 0, "Helvetica", 15);
        minusText:setReferencePoint(display.CenterReferencePoint);
        minusText.x = minusBtn.width*0.5;
        minusText.y = minusBtn.height*0.5;
        gMinusBtn.x = row.contentWidth;
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
        gPlusBtn.x = minusBtn.width+row.contentWidth;
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
        gDeleteBtn.x = plusBtn.width + minusBtn.width +row.contentWidth;
        gDeleteBtn.row = row;
        gDeleteBtn.product = product;
        gDeleteBtn.touch = onTouchDeleteProduct;
        gDeleteBtn:addEventListener("touch",gDeleteBtn);
        
        row.isEditOpen = false;
        
        row:insert(gMinusBtn);
        row:insert(gPlusBtn);
        row:insert(gDeleteBtn);    
    end
    
    local function onRowTouch(event)
        local phase = event.phase;
        local row = event.target;
        
        if phase == "swipeRight" then
            print("ROW SWIPE RIGHT"..row.index);
            if(row.isEditOpen==true)then
                transition.to(row, {time=80, x=row.x + (row.contentHeight*3)});
                row.isEditOpen = false;
            end
        elseif phase == "swipeLeft" then
            print("ROW SWIPE LEFT"..row.index);
            if(row.isEditOpen == false)then
                transition.to(row, {time=80, x=row.x - (row.contentHeight*3)});
                row.isEditOpen = true;
            end
        end
        
    end

    cart.subtotal = 0;

    local topTab = display.newRect(0, 0, display.contentWidth, display.contentHeight*0.1);
    topTab:setFillColor(125, 125, 125, 255);
    
    local totalTab = display.newRect(0,0, display.contentWidth, display.contentHeight*0.1);
    totalTab:setReferencePoint(display.BottomLeftReferencePoint);
    totalTab.y = display.contentHeight;
    totalTab:setFillColor(125, 125, 125, 255);
    
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
    totalText:setReferencePoint(display.BottomCenterReferencePoint);
    totalText.x = display.contentWidth *0.5;
    totalText.y = display.contentHeight - display.contentHeight*0.01;
    
    local tableView = widget.newTableView{
        top=topTab.height,
        width = display.contentWidth,
        height = display.contentHeight-topTab.height-totalTab.height,
        listener = tableViewListener,
        onRowRender = onRowRender,
        onRowTouch = onRowTouch
    }
    
    gCart.tableView = tableView;
    gCart.cart = cart;
    gCart:insert(tableView);
    gCart:insert(topTab);
    gCart:insert(totalTab);
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
        totalText.text = "Subtotal: R$ "..valor;
    end

    function gCart:remakeTable()

        local isRepeated = false;
        local isCategory = false
        local rowHeight = display.contentHeight*0.2;
        local rowColor = 
        { 
            default = { 0, 0, 0 },
        }
        local lineColor = { 0, 0, 0 }

        gCart.tableView:removeSelf();
        gCart.tableView = nil;

        local newTableView = widget.newTableView{
            top=topTab.height,
            width = display.contentWidth,
            height = display.contentHeight-topTab.height-totalTab.height,
            listener = tableViewListener,
            onRowRender = onRowRender,
            onRowTouch = onRowTouch
        }

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
        end        
    end
    
    function gCart:refreshList()
        gCart.tableView:deleteAllRows();
        local isCategory = false
        local rowHeight = display.contentHeight*0.2;
        local rowColor = 
        { 
            default = { 0, 0, 0 },
        }
        local lineColor = { 0, 0, 0 }

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
        saver.saveValue("cart","");
    end
    
    function gCart:addToList(product)
        local isRepeated = false;
        local isCategory = false
        local rowHeight = display.contentHeight*0.2;
        local rowColor = 
        { 
            default = { 0, 0, 0 },
        }
        local lineColor = { 0, 0, 0 }

        cart.subtotal = cart.subtotal + product.price;
        totalText.text = "Subtotal: R$ "..cart.subtotal;
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

