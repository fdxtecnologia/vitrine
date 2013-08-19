module(...,package.seeall);
saver = require( "scripts.Utils.dataSaver" );

function new(parentGroup)
	
	local checkOut  = {};

	--Definitions
	local cart = saver.loadValue("cart");
	local qtyPages = 0;

	--Grupo fristStep
	local fristStep = display.newGroup();
	local fristStepBackground = display.newRect(0,0,display.contentWidth,display.contentHeight);
	fristStepBackground:setFillColor(100,245,150,255);
	local fristStepTitle = display.newText("Primeiro Passo",0,0,native.systemFont,display.contentHeight*0.07);
	fristStepTitle:setReferencePoint(display.CenterReferencePoint);
	fristStepTitle.x = display.contentWidth*0.5;
	fristStepTitle.y = display.contentWidth*0.05;

	fristStep:insert(fristStepBackground);
	fristStep:insert(fristStepTitle);

	fristStep.x = 0;
	fristStep.y = 0;

	qtyPages = qtyPages +1;

	--Group secondStep
	local secondStep = display.newGroup();
	local secondStepBackground = display.newRect(0, 0, display.contentWidth, display.contentHeight);
	secondStepBackground:setFillColor(100,250,150,255);
	local secondStepTitle = display.newText("Segundo Passo",0,0,native.systemFont,display.contentHeight*0.07);
	secondStepTitle:setReferencePoint(display.CenterReferencePoint);
	secondStepTitle.x = display.contentWidth*0.5;
	secondStepTitle.y = display.contentWidth*0.05;

	secondStep:insert(secondStepBackground);
	secondStep:insert(secondStepTitle);

	secondStep.x = fristStepBackground.width + display.contentWidth*0.05;
	secondStep.y = 0;

	qtyPages = qtyPages +1;

	--Group lastStep
	local lastStep = display.newGroup();
	local lastStepBackground = display.newRect(0, 0, display.contentWidth,display.contentHeight);
	lastStepBackground:setFillColor(100,255,150,255);
	local lastStepTitle = display.newText("Finalize o pedido",0,0,native.systemFont,display.contentHeight*0.07);
	lastStepTitle:setReferencePoint(display.CenterReferencePoint);
	lastStepTitle.x = display.contentWidth*0.5;
	lastStepTitle.y = display.contentWidth*0.05;

	lastStep:insert(lastStepBackground);
	lastStep:insert(lastStepTitle);

	lastStep.x = secondStepBackground.width + display.contentWidth*0.05;
	lastStep.y = 0;

	qtyPages = qtyPages +1;

	--Insert into de SceneGroup
	parentGroup:insert(fristStep);
	parentGroup:insert(secondStep);
	parentGroup:insert(lastStep);

	--Page control
	local pageControl = require("scripts.fdxPageControl").new(parentGroup,display.contentWidth*0.5,display.contentHeight*0.98,qtyPages,"horizontal");
	--

	return checkOut;

end