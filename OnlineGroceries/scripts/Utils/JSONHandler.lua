module(...,package.seeall);
local json = require("json");

function new()
    
    local jsonHandler = {};
    local strJson;
    
    function jsonHandler:getJSON(url)
      network.request( url, "GET", networkListener );
    end
    
    function jsonHandler:buildParams(body)
        
        local headers = {};
        
        headers["Content-Type"] = "application/x-www-form-urlencoded";
        headers["Accept-Language"] = "en-US";
        
        local params={};
        params.headers = headers;
        params.body = body;
        
        
        return params;
    end
    
    function jsonHandler:getJSONWithParams(url, params, listener)
        network.request(url, "POST", listener, params); 
    end

    function jsonHandler:encode(tableToJson)
        return json:encode(tableToJson);
    end

    function jsonHandler:decode(jsonToTable)
        local tableFromJson = json:decode(jsonToTable);
        return tableFromJson;
    end
    
    return jsonHandler;
end

