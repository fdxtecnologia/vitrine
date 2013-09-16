module(...,package.seeall);
local saver = require("scripts.Utils.dataSaver");

function new()

	local userTab = display.newGroup();
	local customer = saver.loadValue("customer");

	print();

	--User tab Base

	local bgUserTab = display.newRect(userTab,0,0,display.contentWidth,display.contentHeight);

	local pullUserTab = display.newCircle(userTab,display.contentWidth, display.contentHeight*0.1, 25);
	pullUserTab:setFillColor(200, 200, 200, 255); 

	local topTab = display.newRect(0, 0, display.contentWidth*0.06, display.contentHeight);
    topTab:setFillColor(200, 200, 200, 255);
    topTab:setReferencePoint(display.TopRightReferencePoint);
    topTab.x = display.contentWidth;
    topTab.y = 0;

    userTab:insert(topTab);

	userTab.x = (-1)*display.contentWidth;

	--User tab content


	return userTab;
end