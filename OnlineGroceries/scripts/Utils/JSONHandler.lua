module(...,package.seeall);

function new()
    
    local jsonHandler = {};
    local strJson
    
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
    
    function jsonHandler:getJSONWithParams(url, params)  
        return network.request(url, "POST", networkListener, params);
    end
    
    function networkListener(event)
        
        if(event.isError) then
            print("JSON load error!");
        else
            print("RESPONSE "..event.response);
            strJson = event.response;
        end
    end
    
    return jsonHandler
end

