module(...,package.seeall);
local sqlite3=require("sqlite3");

function new()

	local inMemDB = {};
	local db;

	function inMemDB:initDB()

		db = sqlite3.open_memory();

		db:exec([[
			CREATE TABLE prodPosSession(id INTEGER PRIMARY KEY, posX, posY, nameProduct);
		]])
		db:errcode();
	end

	function inMemDB:insertIntoProdTable(posX, posY, nameProd)

		db:exec([[
			INSERT INTO prodPosSession VALUES(NULL, ']]..posX..[[',']]..posY..[[',']]..nameProd..[[');
		]]);
	end

	function inMemDB:searchByName(text,limit)
		print( "version " .. sqlite3.version() );
		local resultSet = {};

		local str = text.."%";

		local searchQueryStr;

		if(limit == 0) then
			searchQueryStr = [[SELECT * FROM prodPosSession WHERE nameProduct LIKE ']]..str..[[';]]
		else
			searchQueryStr = [[SELECT * FROM prodPosSession WHERE nameProduct LIKE ']]..str..[[' LIMIT ]]..limit..[[;]]
		end

		for row in db:nrows(searchQueryStr) do
			table.insert(resultSet,row);
		end
		print("ERRO:",db:error_message());
		return resultSet;
	end
	
	return inMemDB;
end