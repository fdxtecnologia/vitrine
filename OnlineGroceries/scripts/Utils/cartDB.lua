require("sqlite3");

local path = system.pathForFile("data.db",system.DocumentsDirectory);
local db = sqlite3.open(path);

