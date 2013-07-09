module(...,package.seeall);

function new()
    
    local jsonHandler = {};
    
    function jsonHandler:getJSON(url)
      return network.request( url, "GET", networkListener );
    end
    
    function networkListener(event)
        
        if(event.isError) then
            print("JSON load error!");
        else
            print("JSON :"..event.response);
            return event.response;
        end
    end
    
    return jsonHandler
end

