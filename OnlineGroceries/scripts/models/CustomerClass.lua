module(...,package.seeall);

function new()
    local customer = {};
    
    function customer:new()
        customer.name = ""
        customer.addresses = {}
        customer.login = ""
        customer.password = ""
        customer.email = ""
    end
    
    return customer
end


