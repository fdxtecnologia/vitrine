module(...,package.seeall);

function new()
    
    local gCart = display.newGroup();
    gCart.x = 0;
    gCart.y = display.contentHeight;
    local pullTab = display.newCircle(gCart, display.contentWidth*0.5, 0, 25);
    local cart = {products={}};
    pullTab:setFillColor(125, 125, 125, 255); 
    local widget = require( "widget" );
    -- Handle row rendering
    local function onRowRender( event )
        local phase = event.phase
        local row = event.row

        local rowTitle = display.newText( row, "Title " .. cart.products[row.index].title.." qtd:"..cart.products[row.index].quantity, 0, 0, nil, 14 )
        rowTitle.x = row.x - ( row.contentWidth * 0.5 ) + ( rowTitle.contentWidth * 0.5 )
        rowTitle.y = row.contentHeight * 0.5
        rowTitle:setTextColor( 0, 0, 0 )
    end
    
    local topTab = display.newRect(gCart, 0, 0, display.contentWidth, display.contentHeight*0.1);
    topTab:setFillColor(125, 125, 125, 255);
    local tableView = widget.newTableView{
        top=topTab.height,
        width = display.contentWidth,
        height = display.contentHeight,
        listener = tableViewListener,
        onRowRender = onRowRender,
        onRowTouch = onRowTouch
    }
    
    gCart:insert(tableView);
    
    function gCart:getCart()
        return cart;
    end
    
    function gCart:setCart(newCart)
        cart = newCart;
    end
    
    function gCart:refreshList()
        tableView:deleteAllRows();
        local isCategory = false
        local rowHeight = 40
        local rowColor = 
        { 
            default = { 120, 120, 120 },
        }
        local lineColor = { 220, 220, 220 }
        
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
        local rowHeight = 40
        local rowColor = 
        { 
            default = { 120, 120, 120 },
        }
        local lineColor = { 220, 220, 220 }
        for i=1,#cart.products do
            if(cart.products[i].idProduct == product.idProduct)then
                isRepeated = true;
                cart.products[i].quantity = cart.products[i].quantity + 1;
                cart.products[i].totalPrice = product.price * cart.products[i].quantity;
                gCart:refreshList();
            end
        end
        if(isRepeated==false)then
            product.quantity = product.quantity +1;
            product.totalPrice = product.price;
            table.insert(cart.products, product);
            tableView:insertRow
            {
                isCategory = isCategory,
                rowHeight = rowHeight,
                rowColor = rowColor,
                lineColor = lineColor,
            } 
        end 
    end
     
    return gCart;
end

