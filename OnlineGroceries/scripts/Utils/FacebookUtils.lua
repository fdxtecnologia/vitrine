module(...,package.seeall);

function new()
	
	local fbUtils = {};
	fbUtils.appId = "392039104231402"
	local facebook = require "facebook"
	local json = require "json"

	function fbUtils:login()
		local function listener( event )
			local access_token
			if ( "session" == event.type ) then
				if ( "login" == event.phase ) then
					facebook.request( "me" )
					access_token = event.token
					print( access_token )
				end
			elseif ( "request" == event.type ) then
				local response = event.response
				if ( not event.isError ) then
					print ("Not Error - Aeaeaeaeae")
					response = json.decode( event.response )
					local customerInfo = {
						name = response.name,
						email = response.email,
						password = access_token,
						role = "CUST"
					}
					local customerObject = {
						firstName = response.first_name,
						lastName = response.last_name,
					}
				end
			elseif ( "dialog" == event.type ) then
				print( "dialog", event.response )
			end
		end
		facebook.login( fbUtils.appId, listener,{"publish_stream"})
		return true
	end
	
	return fbUtils;
	
end