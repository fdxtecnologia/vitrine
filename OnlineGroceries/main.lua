local storyboard = require("storyboard");
local Urls = require("scripts.Utils.Urls");
DB = require("scripts.Utils.DB").new();
inMemDB = require("scripts.Utils.InMemDB").new();

function main()
    
   	-- storyboard.gotoScene("scripts.home.HomeScene");
    --storyboard.gotoScene("scripts.checkout.CheckoutScene");
    storyboard.gotoScene("scripts.home.HomeScene");

      
end

inMemDB:initDB();
DB:initDB();
main();
