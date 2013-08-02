module(...,package.seeall);
local storyboard = require( "storyboard" );

function new()
    
    --Definitions
    local gCart = display.newGroup();
    gCart.x = 0;
    gCart.y = display.contentHeight;
    local pullTab = display.newCircle(gCart, display.contentWidth*0.5, 0, 25);
    local cart = {products={}};
    pullTab:setFillColor(125, 125, 125, 255); 
    local widget = require( "widget" );
    
    --Navigate to CheckOut
    local function onCheckOutTouch(self,event)
        
        storyboard.gotoScene("scripts.checkout.CheckoutScene");
        
    end
    
    --Handle Deletebutton
    local function onTouchDeleteProduct(self,event)
        local phase = event.phase;
        local btn = self;
        local row = btn.parent;
        if phase == "began" then
            print("Delete ROW "..btn.row);
            table.remove(cart.products, btn.row);
            gCart.tableView:deleteRow(btn.row);
            gCart:refreshSubtotal();
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
        
        local rowTitle = display.newText(row,product.title, 0, 0, "Helvetica", 15);
        rowTitle:setReferencePoint(display.CenterReferencePoint);
        rowTitle.x = row.contentWidth*0.5;
        rowTitle.y = row.contentHeight*0.5;
        
        local rowPrice = display.newText(row,"R$ "..product.totalPrice, 0, 0, "Helvetica", 16);
        rowPrice:setReferencePoint(display.CenterRightReferencePoint);
        rowPrice.x = row.contentWidth - rowQty.contentWidth*0.1;
        rowPrice.y = row.contentHeight*0.5;
        
        --Minus item button
        local gMinusBtn = display.newGroup();
        local minusBtn = display.newRect(gMinusBtn,0, 0,row.contentHeight*0.97, row.contentHeight*0.97);
        minusBtn:setFillColor(0,171,255,255);
        local minusText = display.newText(gMinusBtn, "-", 0, 0, "Helvetica", 15);
        minusText:setReferencePoint(display.CenterReferencePoint);
        minusText.x = minusBtn.width*0.5;
        minusText.y = minusBtn.height*0.5;
        gMinusBtn.x = row.contentWidth;
        gMinusBtn.row = row.index;
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
        gPlusBtn.row = row.index;
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
        gDeleteBtn.row = row.index;
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
    cart.subtotal = 0;
    
    local tableView = widget.newTableView{
        top=topTab.height,
        width = display.contentWidth,
        height = display.contentHeight-topTab.height-totalTab.height,
        listener = tableViewListener,
        onRowRender = onRowRender,
        onRowTouch = onRowTouch
    }
    
    gCart.tableView = tableView;
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
            tableView:insertRow
            {
                isCategory = isCategory,
                rowHeight = rowHeight,
                rowColor = rowColor,
                lineColor = lineColor,
            } 
        end
    end
    
    function gCart:addToList(product)
        print("ADD TO LISt")
        local isRepeated = false;
        local isCategory = false
        local rowHeight = display.contentHeight*0.2;
        local rowColor = 
        { 
            default = { 0, 0, 0 },
        }
        local lineColor = { 0, 0, 0 }
        print(cart.subtotal)
        cart.subtotal = cart.subtotal + product.price;
        totalText.text = "Subtotal: R$ "..cart.subtotal;
        for i=1,#cart.products do
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
        end 
    end
     
    return gCart;
end

