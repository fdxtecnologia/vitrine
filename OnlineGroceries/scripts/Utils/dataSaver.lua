module(..., package.seeall)

json = require ("json");

function saveValue(key, value)
	--temp variable
	local app
	local path = system.pathForFile( "data.txt", system.DocumentsDirectory )
	--open file
	local file = io.open( path, "r" )
	if file then
		-- read all contents of file into a string
		local contents = file:read( "*a" )
		--decode json
		app = json.decode(contents)
		io.close( file )	-- close the file after using it
		--if file was empty
		if(not app.data) then
			app.data = {}
		end
		--store value in table
		app.data[key] = value
		--encode table to json
		contents = json.encode(app)
		--open file
		local file = io.open( path, "w" )
		--store json string in file
		file:write( contents )
		--close file
		io.close( file )
	else
		--if file doesn't exist
		--create default structure
		app = {data = {}}
		--store value
		app.data[key] = value
		--encode in json
		local contents = json.encode(app)
		--create file
		local file = io.open( path, "w" )
		--save json string in file
		file:write( contents )
		--close file
		io.close( file )
	end
end
function loadValue(key)
	--temp variable
	local app
	-- create a file path for corona i/o
	local path = system.pathForFile( "data.txt", system.DocumentsDirectory )
	--open file
	local file = io.open( path, "r" )
	if file then
		--read contents
		local contents = file:read( "*a" )
		--decode json
		app = json.decode(contents)
		if(not app.data) then app.data = {}; end
		--return value
		return app.data[key]
	end
	--if doesn't exist
	return nil
end
function save( filename, dataTable )
	filename = filename..".json"
	--encode table into json string
	local jsonString = json.encode( dataTable )
	-- create a file path for corona i/o
	local path = system.pathForFile( filename, system.ResourceDirectory )
	-- io.open opens a file at path. Creates one if doesn't exist
	local file = io.open( path, "w" )
	if file then
		--write json string into file
	   file:write( jsonString )
	   -- close the file after using it
	   io.close( file )
	end
end

function load( filename )
	filename = filename..".json"
	-- set default base dir if none specified
	local base = system.ResourceDirectory

	-- create a file path for corona i/o
	local path = system.pathForFile( filename, base )

	-- will hold contents of file
	local contents

	-- io.open opens a file at path. returns nil if no file found
	local file = io.open( path, "r" )
	if file then
		-- read all contents of file into a string
		contents = file:read( "*a" )
		-- close the file after using it
		io.close( file )
		--return decoded json string
		return json.decode( contents )
	else
		--or return nil if file didn't ex
		return nil
	end
end

