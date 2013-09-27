module(...,package.seeall);
local saver = require("scripts.Utils.dataSaver");

function new()
	
	local fbUtils = display.newGroup();
	fbUtils.appId = "392039104231402"
	local facebook = require "facebook"
	local json = require "json"

	local function listener( event )
		local access_token;

		print("EVENT TYPE: ", event.type);

		if ( "session" == event.type ) then
			if ( "login" == event.phase ) then
				facebook.request( "me" )
				access_token = event.token
				print( "access token ",access_token );

			local eventT = {
				name = "fbEvent",
				type = "logged",
				data = event.token
			}
			Runtime:dispatchEvent( eventT );
			end
		elseif ( "request" == event.type ) then
			local response = event.response
			if ( not event.isError ) then
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
				saver.saveValue("customer",customerObject);
				local eventT = {
					name = "fbEvent",
					type = "requested",
					data = event.response
				}
				Runtime:dispatchEvent( eventT );
			else
				local eventT = {
					name = "fbEvent",
					type = "error",
					data = event.response
				}
				Runtime:dispatchEvent( eventT );
			end
		elseif ( "dialog" == event.type ) then
			print( "dialog", event.response)
		elseif(event.isError == true) then
			local eventT = {
				name = "fbEvent",
				type = "error",
				data = event.response
			}
			Runtime:dispatchEvent( eventT );
		end
	end

	function fbUtils:login()
		facebook.login( fbUtils.appId, listener,{"publish_stream"});
	end

	function fbUtils:getProfilePicture()

	end
	
	return fbUtils;
end