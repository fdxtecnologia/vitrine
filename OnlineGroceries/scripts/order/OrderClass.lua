module(...,package.seeall);

function new(customer, products, payment)

    local date = os.date("*t");
    local day = date.day;
    local year = date.year;
    local month = date.month;
    local hour = date.hour;
    local min = date.min;
    local sec = date.sec;

    print("DATE", date.sec);

    if(date.day < 10) then
        day = "0"..date.day;
    end

    if(date.month < 10) then
        month = "0"..date.month;
    end

    if(date.hour < 10) then
        hour = "0"..date.hour;
    end

    if(date.min < 10) then
        min = "0"..date.min;
    end

    if(date.sec < 10) then
        sec = "0"..date.sec;
    end

    local order = {order = {}}
    
    order.order.customer = customer
    order.order.products = {}
    --order.order.processedDate = year.."-"..month.."-"..day.." "..hour..":"..min..":"..sec;
    
    for i=1, #products do
        local prod = products[i]
        local product = {
            idProduct = prod.id,
            sku = prod.sku,
            quantity = prod.quantity,
            price = prod.price,
            totalPrice = prod.quantity * prod.price,
            title = prod.title
        };
        table.insert(order.order.products, prod)
    end
    
    
    return order
end

