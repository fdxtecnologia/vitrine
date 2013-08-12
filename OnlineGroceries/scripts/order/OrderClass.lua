module(...,package.seeall);

function new(customer, products, payment)
    
    local order = {order = {}}
    
    order.order.customer = customer
    order.order.products = {}
    
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

