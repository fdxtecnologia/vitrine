module(...,package.seeall);
function new()
    
    local Cart = {}
    Cart.items = {}
    Cart.total = 0
    
    
    function Cart:addItem(item)
        Cart.items:insert(item)
        Cart:calculateTotal()
    end
    
    function Cart:removeItem(sku)
        local sku = sku
        for i=1, #Cart.items do
            if Cart.items[i].sku == sku then
                Cart.items:remove(i)
                break
            end
        end
        Cart:calculateTotal()
    end
    
    function Cart:calculateTotal()
        Cart.total = 0
        for i=1, #Cart.items do
            Cart.total = Cart.total + Cart.items[i].price
        end
    end
    
    return Cart;
end

