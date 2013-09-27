module(...,package.seeall);
local saver = require("scripts.Utils.dataSaver");

function new()

	local userTab = display.newGroup();
	local customer = saver.loadValue("customer");
	local numRows = saver.loadValue("numRows");

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
	local photo = display.newCircle(display.contentWidth/2,display.contentHeight*0.12, 30);
	photo:setFillColor(0,0,0);

	local lblName = display.newText(customer.firstName.." "..customer.lastName, 0,0, native.systemFont, display.contentHeight*0.08);
	lblName:setTextColor(0,0,0);
	lblName:setReferencePoint(display.CenterReferencePoint);
	lblName.x = display.contentWidth/2;
	lblName.y = display.contentHeight*0.27;

	local divLine = display.newLine(userTab,2,display.contentHeight*0.33,display.contentWidth-topTab.width,display.contentHeight*0.33);
	divLine:setColor(0,0,0);

	local settingsLbl = display.newText("Configurações",2,display.contentHeight*0.35,native.systemFont, display.contentHeight*0.04);
	settingsLbl:setTextColor(0,0,0);
	userTab:insert(settingsLbl);

	local lblNumRows = display.newText("Numero de linhas:",2, display.contentHeight*0.4, native.systemFont, display.contentHeight*0.06);
	lblNumRows:setTextColor(0,0,0);
	userTab:insert(lblNumRows);

	local divLine = display.newLine(userTab,2,display.contentHeight*0.51,display.contentWidth-topTab.width,display.contentHeight*0.51);
	divLine:setColor(0,0,0);

	--Botões numero de linhas

	local gBtn1Row = display.newGroup();
	local btn1Row = display.newCircle(0,0, 15);
	local lbl1Text = display.newText("1",0,0,native.systemFont, display.contentHeight*0.055);
	lbl1Text:setReferencePoint(display.CenterReferencePoint);
	lbl1Text.x = btn1Row.x;
	lbl1Text.y = btn1Row.y;
	lbl1Text:setTextColor(0,0,0);
	btn1Row:setStrokeColor(0,0,0);
	btn1Row.strokeWidth = 2;

	gBtn1Row.x = display.contentWidth*0.65;
	gBtn1Row.y = display.contentHeight*0.43;
	gBtn1Row.btn1Row = btn1Row;
	gBtn1Row.lbl1Text = lbl1Text;
	gBtn1Row:insert(btn1Row);
	gBtn1Row:insert(lbl1Text);

	local gBtn2Row = display.newGroup();
	local btn2Row = display.newCircle(0,0, 15);
	local lbl2Text = display.newText("2",0,0,native.systemFont, display.contentHeight*0.055);
	lbl2Text:setReferencePoint(display.CenterReferencePoint);
	lbl2Text.x = btn2Row.x;
	lbl2Text.y = btn2Row.y;
	lbl2Text:setTextColor(0,0,0);
	btn2Row:setStrokeColor(0,0,0);
	btn2Row.strokeWidth = 2;

	gBtn2Row.x = display.contentWidth*0.75;
	gBtn2Row.y = display.contentHeight*0.43;
	gBtn2Row.btn2Row = btn2Row;
	gBtn2Row.lbl2Text = lbl2Text;
	gBtn2Row:insert(btn2Row);
	gBtn2Row:insert(lbl2Text);

	local gBtn3Row = display.newGroup();
	local btn3Row = display.newCircle(0,0, 15);
	local lbl3Text = display.newText("3",0,0,native.systemFont, display.contentHeight*0.055);
	lbl3Text:setReferencePoint(display.CenterReferencePoint);
	lbl3Text.x = btn3Row.x;
	lbl3Text.y = btn3Row.y;
	lbl3Text:setTextColor(0,0,0);
	btn3Row:setStrokeColor(0,0,0);
	btn3Row.strokeWidth = 2;

	gBtn3Row.x = display.contentWidth*0.85;
	gBtn3Row.y = display.contentHeight*0.43;
	gBtn3Row.btn3Row = btn3Row;
	gBtn3Row.lbl3Text = lbl3Text;
	gBtn3Row:insert(btn3Row);
	gBtn3Row:insert(lbl3Text);

	userTab:insert(gBtn2Row);
	userTab:insert(gBtn1Row);
	userTab:insert(gBtn3Row);
	userTab:insert(lblName);
	userTab:insert(photo);

	if(numRows == 1) then

		gBtn1Row.btn1Row:setFillColor(0,0,0);
		gBtn1Row.lbl1Text:setTextColor(255,255,255);

		gBtn2Row.btn2Row:setFillColor(255,255,255);
		gBtn2Row.lbl2Text:setTextColor(0,0,0);

		gBtn3Row.btn3Row:setFillColor(255,255,255);
		gBtn3Row.lbl3Text:setTextColor(0,0,0);

	elseif(numRows == 2) then

		gBtn2Row.btn2Row:setFillColor(0,0,0);
		gBtn2Row.lbl2Text:setTextColor(255,255,255);

		gBtn1Row.btn1Row:setFillColor(255,255,255);
		gBtn1Row.lbl1Text:setTextColor(0,0,0);

		gBtn3Row.btn3Row:setFillColor(255,255,255);
		gBtn3Row.lbl3Text:setTextColor(0,0,0);

	elseif(numRows == 3) then

		gBtn3Row.btn3Row:setFillColor(0,0,0);
		gBtn3Row.lbl3Text:setTextColor(255,255,255);

		gBtn1Row.btn1Row:setFillColor(255,255,255);
		gBtn1Row.lbl1Text:setTextColor(0,0,0);

		gBtn2Row.btn2Row:setFillColor(255,255,255);
		gBtn2Row.lbl2Text:setTextColor(0,0,0);

	end

	local function onBtn1Touch(self,event)
		local phase = event.phase;

		if(phase == "began") then

			gBtn1Row.btn1Row:setFillColor(0,0,0);
			gBtn1Row.lbl1Text:setTextColor(255,255,255);

			gBtn2Row.btn2Row:setFillColor(255,255,255);
			gBtn2Row.lbl2Text:setTextColor(0,0,0);

			gBtn3Row.btn3Row:setFillColor(255,255,255);
			gBtn3Row.lbl3Text:setTextColor(0,0,0);

			saver.saveValue("numRows",1);

		elseif(phase == "ended") then



		end
		return true;
	end

	local function onBtn2Touch(self,event)
		local phase = event.phase;

		if(phase == "began") then

			gBtn2Row.btn2Row:setFillColor(0,0,0);
			gBtn2Row.lbl2Text:setTextColor(255,255,255);

			gBtn1Row.btn1Row:setFillColor(255,255,255);
			gBtn1Row.lbl1Text:setTextColor(0,0,0);

			gBtn3Row.btn3Row:setFillColor(255,255,255);
			gBtn3Row.lbl3Text:setTextColor(0,0,0);

			saver.saveValue("numRows",2);

		elseif(phase == "ended") then

		end
		return true;
	end

	local function onBtn3Touch(self,event)
		local phase = event.phase;

		if(phase == "began") then

			gBtn3Row.btn3Row:setFillColor(0,0,0);
			gBtn3Row.lbl3Text:setTextColor(255,255,255);

			gBtn1Row.btn1Row:setFillColor(255,255,255);
			gBtn1Row.lbl1Text:setTextColor(0,0,0);

			gBtn2Row.btn2Row:setFillColor(255,255,255);
			gBtn2Row.lbl2Text:setTextColor(0,0,0);

			saver.saveValue("numRows",3);

		elseif(phase == "ended") then

		end

		return true;
	end

	gBtn1Row.touch = onBtn1Touch;
	gBtn1Row:addEventListener("touch", gBtn1Row);

	gBtn2Row.touch = onBtn2Touch;
	gBtn2Row:addEventListener("touch", gBtn2Row);

	gBtn3Row.touch = onBtn3Touch;
	gBtn3Row:addEventListener("touch", gBtn3Row);

	return userTab;
end