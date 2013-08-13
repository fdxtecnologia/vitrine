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
		]])
		print("ERRO:",db:error_message());
	end

	function inMemDB:searchByName(str)
		print( "version " .. sqlite3.version() )

		for row in db:nrows("SELECT * FROM prodPosSession") do
			print(row.posX);
		end
	end
	
	return inMemDB;
end