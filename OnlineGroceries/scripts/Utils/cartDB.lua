module(...,package.seeall);
require("sqlite3");
json = require("json");

function new()

	local DB = {};

	local db;

	function DB:initDB()
		local path = system.pathForFile("data.db",system.DocumentsDirectory);
		db = sqlite3.open(path);

		if(db == nil) then
			print("Não foi possível iniciar o Banco de Dados Local");
		else
			local cartTableSetup = [[CREATE TABLE IF NOT EXISTS carts (id INTEGER PRIMARY KEY autoincrement, listProdJSON, SaveDate, customer_id);]]
			db:exec(cartTableSetup);
		end
	end

	function DB:insertIntoCart(cart)

		local cartJson = json:encode(cart.products);

		local date = os.date("*t");

		local strDate = date.year.."-"..date.month.."-"..date.day;

		--MUDAR QUANDO O LOGIN ESTIVER PRONTO
		local curtomer_id = 1

		local insertQuery = [[INSERT INTO test VALUES (NULL, 'cartJson','strDate', curtomer_id); ]];
	end

	return DB;
end

