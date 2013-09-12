module(...,package.seeall);
saver = require( "scripts.Utils.dataSaver" );
local storyboard = require( "storyboard" );

function new(parentGroup)
	
	local checkOut  = {};
	local widget = require("widget");

	--Definitions
	local cart = saver.loadValue("cart");
	local qtyPages = 0;

	--Handler functions
	local function onTfDataEntregaTouch(self,event)
		local picker = self.datePicker;
		local phase = event.phase;

		if(phase == "began") then
			self.parent:setReferencePoint(display.CenterReferencePoint);
			if(picker.isOpen == false) then
				picker.isOpen = true;
				picker.startY = picker.y;
				picker.menu.startY = picker.menu.y;
				transition.to(picker,{time = 100, y = display.contentHeight*0.5});
				transition.to(picker.menu,{time = 100, y = 0});
			end
		elseif(phase == "ended") then

		end
		return true;
	end

	local function onTfHoraPreferencial1Touch(self,event)

		local picker = self.hourPicker;
		local phase = event.phase;

		if(phase=="began") then
			if(picker.isOpen == false) then
				picker.isOpen = true;
				picker.isHour1 = true;
				picker.isHour2 = false;
				picker.startY = picker.y;
				picker.menu.startY = picker.menu.y;
				self.parent.startY = self.parent.y;
				transition.to(self.parent, {time = 100, y = self.parent.startY - display.contentHeight*0.1});
				transition.to(picker,{time = 100, y = display.contentHeight*0.5});
				transition.to(picker.menu,{time = 100, y = 0});
			end
		end
		return true;
	end

	local function onTfHoraPreferencial2Touch(self,event)

		local picker = self.hourPicker;
		local phase = event.phase;

		if(phase=="began") then
			if(picker.isOpen == false) then
				picker.isOpen = true;
				picker.isHour1 = false;
				picker.isHour2 = true;
				picker.startY = picker.y;
				picker.menu.startY = picker.menu.y;
				self.parent.startY = self.parent.y;
				transition.to(self.parent, {time = 100, y = self.parent.startY - display.contentHeight*0.1});
				transition.to(picker,{time = 100, y = display.contentHeight*0.5});
				transition.to(picker.menu,{time = 100, y = 0});
			end
		end
		return true;
	end

	local function onTfValidaMesTouch(self,event)
		local picker = self.monthPicker;
		local phase = event.phase;

		if(phase == "began") then
			self.parent:setReferencePoint(display.CenterReferencePoint);
			if(picker.isOpen == false) then
				picker.isOpen = true;
				picker.startY = picker.y;
				picker.menu.startY = picker.menu.y;
				self.parent.startY = self.parent.y;
				transition.to(self.parent, {time = 100, y = self.parent.startY - display.contentHeight*0.1});
				transition.to(picker,{time = 100, y = display.contentHeight*0.5});
				transition.to(picker.menu,{time = 100, y = 0});
			end
		elseif(phase == "ended") then

		end
		return true;
	end

	local function onTfValidaAnoTouch(self,event)
		local picker = self.yearPicker;
		local phase = event.phase;

		if(phase == "began") then
			self.parent:setReferencePoint(display.CenterReferencePoint);
			if(picker.isOpen == false) then
				picker.isOpen = true;
				picker.startY = picker.y;
				picker.menu.startY = picker.menu.y;
				self.parent.startY = self.parent.y;
				transition.to(self.parent, {time = 100, y = self.parent.startY - display.contentHeight*0.1});
				transition.to(picker,{time = 100, y = display.contentHeight*0.5});
				transition.to(picker.menu,{time = 100, y = 0});
			end
		elseif(phase == "ended") then

		end
		return true;
	end

	local function onNextBtnTouchFristStep(self,event)

		local phase = event.phase;

		if(phase == "ended") then
			self.parent:setReferencePoint(display.TopLeftReferencePoint);
			transition.to(self.parent,{time = 300, x = (-1)*self.parent.width});
			transition.to(self.parent.secondStep, {time = 300, x = 0});
			transition.to(self.parent.lastStep, {time = 300, x = display.contentWidth});
			self.parent.pageControl:setPage(self.parent.pageControl:getCurrentPage() + 1);
		end
		return true;
	end

	local  function onNextBtnTouchSecondStep(self,event)
		local phase = event.phase;

		if(phase == "ended") then
			self.parent:setReferencePoint(display.TopRightReferencePoint);
			transition.to(self.parent,{time = 300, x=0});
			self.parent.fristStep:setReferencePoint(display.TopRightReferencePoint);
			transition.to(self.parent.fristStep, {time=300, x = (-1)*self.parent.width });
			transition.to(self.parent.lastStep, {time=300, x = 0});
			self.parent.pageControl:setPage(self.parent.pageControl:getCurrentPage() + 1);
		end
		return true;
	end

	local function onSaveDate(self,event)
		local type = event.type;

		if type == "saved" then
			self.fristStep:setReferencePoint(display.CenterReferencePoint);
			self.isOpen = false;
			transition.to(self,{time = 100, y = display.contentHeight});
			transition.to(self.menu,{time = 100, y = self.menu.startY});
			local values = self:getValues();
			self.textDate.text = values[1].value.."/ "..values[2].value.."/ "..values[3].value;
		end
		return true;
	end

	local function onSaveYear(self,event)
		local type = event.type;

		if type == "saved" then
			self.secondStep:setReferencePoint(display.CenterReferencePoint);
			self.isOpen = false;
			transition.to(self,{time = 100, y = display.contentHeight});
			transition.to(self.menu,{time = 100, y = self.menu.startY});
			transition.to(self.secondStep, {time = 100, y = self.secondStep.y + display.contentHeight*0.1});
			local values = self:getValues();
			self.textYear.text = values[1].value;
		end
		return true;
	end

	local function onSaveTime(self,event)
		local type = event.type;

		if type == "saved" then
			self.fristStep:setReferencePoint(display.CenterReferencePoint);
			self.isOpen = false;
			transition.to(self,{time = 100, y = display.contentHeight});
			transition.to(self.menu,{time = 100, y = self.menu.startY});
			local values = self:getValues();
			if self.isHour1 == true then
				self.textTime1.text = values[1].value..":"..values[2].value.." "..values[3].value;
			elseif self.isHour2 == true then
				self.textTime2.text = values[1].value..":"..values[2].value.." "..values[3].value;
			end
			transition.to(self.fristStep, {time = 100, y = self.fristStep.y + display.contentHeight*0.1});
		end
		return true;
	end

	local function onSaveMonth(self,event)
		local type = event.type;

		if type == "saved" then
			self.secondStep:setReferencePoint(display.CenterReferencePoint);
			self.isOpen = false;
			transition.to(self,{time = 100, y = display.contentHeight});
			transition.to(self.menu,{time = 100, y = self.menu.startY});
			transition.to(self.secondStep, {time = 100, y = self.secondStep.y + display.contentHeight*0.1});
			local values = self:getValues();
			self.textMonth.text = values[1].value;
		end
		return true;
	end

	local function onConfirmBtnTouch(self,event)
		local phase = event.phase 
		local customer = {
			firstName = "Andre",
			lastName = "Luis"
		}

		local payment = require("scripts.checkout.PaymentClass").new()

		local order = require("scripts.order.OrderClass").new(customer, cart.products, payment)
			

		if "ended" == phase then
			local json = require("json");
			local cJson = require("scripts.Utils.JSONHandler").new()
			local result
			local body = json.encode(order)
			print("Requisição: "..body)
			local function callbackPlaceOrder(event)
				if(event.isError) then
					print("Erro ao enviar o pedido")
				else
					result = json.decode(event.response)
				end
			end
			cJson:getJSONWithParams(PLACE_ORDER,cJson:buildParams(body),callbackPlaceOrder);
		end
		return true;
	end

	local function onBtnBackThirdStep(self,event)

		local phase = event.phase;

		if phase == "ended" then
			self.parent:setReferencePoint(display.TopLeftReferencePoint);
			transition.to(self.parent,{time = 300, x=display.contentWidth});
			self.parent.fristStep:setReferencePoint(display.TopRightReferencePoint);
			transition.to(self.parent.fristStep, {time=300, x = 0 });
			self.parent.secondStep:setReferencePoint(display.TopLeftReferencePoint);
			transition.to(self.parent.secondStep, {time=300, x = 0});
			self.parent.pageControl:setPage(self.parent.pageControl:getCurrentPage() - 1);
		end
		return true;
	end

	local function onBackBtnTouchSecondStep(self,event)
		local phase = event.phase;

		if phase == "ended" then
			self.parent:setReferencePoint(display.TopLeftReferencePoint);
			transition.to(self.parent,{time = 300, x=display.contentWidth});
			self.parent.fristStep:setReferencePoint(display.TopLeftReferencePoint);
			transition.to(self.parent.fristStep, {time=300, x = 0 });
			self.parent.lastStep:setReferencePoint(display.TopLeftReferencePoint);
			transition.to(self.parent.secondStep, {time=300, x = display.contentWidth*2});
			self.parent.pageControl:setPage(self.parent.pageControl:getCurrentPage() - 1);
		end
		return true;
	end

	local function onBackToShoppingTouch(self,event)
		local phase = event.phase;

		if phase == "ended" then
			storyboard.gotoScene("scripts.home.HomeScene");
		end
		return true;
	end

	--Botão voltar ao supermercado
	local gBtnBackToShopping = display.newGroup();
	local btnBackToShopping = display.newCircle(0,0,20);
	btnBackToShopping:setFillColor(0,0,0,0);
	btnBackToShopping:setStrokeColor(255,255,255);
	btnBackToShopping.strokeWidth = 3;

	gBtnBackToShopping.x = display.contentWidth*0.06;
	gBtnBackToShopping.y = display.contentHeight*0.9;

	local cartImage = display.newImage("images/cart.png");
	cartImage.width = display.contentWidth*0.05;
	cartImage.height = display.contentHeight*0.07;
	cartImage.x = 0;
	cartImage.y = btnBackToShopping.height*0.03;

	gBtnBackToShopping:insert(btnBackToShopping);
	gBtnBackToShopping:insert(cartImage);

	gBtnBackToShopping.touch = onBackToShoppingTouch;
	gBtnBackToShopping:addEventListener("touch", gBtnBackToShopping);

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
	
	--Formulário Primeiro Passo
	local tfEndereco = require("scripts.fdxTextField").new(display.contentWidth*0.37, display.contentHeight*0.2, display.contentWidth*0.5,display.contentHeight*0.08,"Endereço","center");
	local lblEndereco = display.newText("Endereço:",display.contentWidth*0.2,display.contentHeight*0.2, native.systemFont,display.contentHeight*0.06);
	fristStep:insert(tfEndereco);
	fristStep:insert(lblEndereco);
	
	local datePicker = require("scripts.fdxDatePicker").new("date");
	print("Backgroud Frame: ",datePicker.overlayFrame);
	datePicker.isOpen = false;
	datePicker.save = onSaveDate;
	datePicker.fristStep = fristStep;
	datePicker:addEventListener("save",datePicker);

	local tfDataEntrega = display.newRect(display.contentWidth*0.37,display.contentHeight*0.35,display.contentWidth*0.5,display.contentHeight*0.08);
	tfDataEntrega.datePicker = datePicker;
	local tfDataEntregaContent = display.newText("Hoje", 0, 0, native.systemFont, display.contentHeight*0.06);
	tfDataEntregaContent:setReferencePoint(display.CenterReferencePoint);
	tfDataEntregaContent.x = tfDataEntrega.x;
	tfDataEntregaContent.y = tfDataEntrega.y;
	tfDataEntregaContent:setTextColor(0,0,0);
	datePicker.textDate = tfDataEntregaContent;
	local lblDataEntrega = display.newText("Data:",display.contentWidth*0.2,display.contentHeight*0.35, native.systemFont,display.contentHeight*0.06);
	fristStep:insert(tfDataEntrega);
	fristStep:insert(lblDataEntrega);
	fristStep:insert(tfDataEntregaContent);

	tfDataEntrega.touch = onTfDataEntregaTouch;
	tfDataEntrega:addEventListener("touch",tfDataEntrega);

	local hourPicker = require("scripts.fdxDatePicker").new("time");
	hourPicker.isOpen = false;
	hourPicker.save = onSaveTime;
	hourPicker.fristStep = fristStep;
	hourPicker:addEventListener("save",hourPicker);

	local tfHoraPreferencia1 = display.newRect(display.contentWidth*0.37, display.contentHeight*0.5,display.contentWidth*0.2,display.contentHeight*0.08);
	tfHoraPreferencia1.hourPicker = hourPicker;
	local hourNow = os.date("%l")..":"..os.date("%M").." "..os.date("%p");
	local tfHoraPreferencia1Content = display.newText(hourNow,0,0,native.systemFont,display.contentHeight*0.06);
	tfHoraPreferencia1Content:setReferencePoint(display.CenterReferencePoint);
	tfHoraPreferencia1Content.x = tfHoraPreferencia1.x;
	tfHoraPreferencia1Content.y = tfHoraPreferencia1.y;
	tfHoraPreferencia1Content:setTextColor(0,0,0);
	hourPicker.textTime1 = tfHoraPreferencia1Content;
	fristStep:insert(tfHoraPreferencia1);
	fristStep:insert(tfHoraPreferencia1Content);

	local tfHoraPreferencia2 = display.newRect(display.contentWidth*0.67, display.contentHeight*0.5,display.contentWidth*0.2,display.contentHeight*0.08);
	tfHoraPreferencia2.hourPicker = hourPicker;
	local tfHoraPreferencia2Content = display.newText("8:00 PM", 0,0, native.systemFont,display.contentHeight*0.06);
	tfHoraPreferencia2Content:setReferencePoint(display.CenterReferencePoint);
	tfHoraPreferencia2Content.x = tfHoraPreferencia2.x;
	tfHoraPreferencia2Content.y = tfHoraPreferencia2.y;
	tfHoraPreferencia2Content:setTextColor(0,0,0);
	hourPicker.textTime2 = tfHoraPreferencia2Content;
	fristStep:insert(tfHoraPreferencia2);
	fristStep:insert(tfHoraPreferencia2Content);

	local lblHourEntrega = display.newText("Hora:", display.contentWidth*0.2,display.contentHeight*0.5,native.systemFont,display.contentHeight*0.06);
	local lblUntilHour = display.newText("a", display.contentWidth*0.61,display.contentHeight*0.5, native.systemFont,display.contentHeight*0.06);
	fristStep:insert(lblHourEntrega);
	fristStep:insert(lblUntilHour);

	tfHoraPreferencia1.touch = onTfHoraPreferencial1Touch;
	tfHoraPreferencia1:addEventListener("touch",tfHoraPreferencia1);

	tfHoraPreferencia2.touch = onTfHoraPreferencial2Touch;
	tfHoraPreferencia2:addEventListener("touch",tfHoraPreferencia2);

	local gBtnNextStep = display.newGroup();
	local btnNextStep = display.newRoundedRect(gBtnNextStep,0,0,display.contentWidth*0.2, display.contentHeight*0.1,10);
	local lblNextStep = display.newText(gBtnNextStep,"Continuar >", 0,0, native.systemFont,display.contentHeight*0.06);
	lblNextStep:setReferencePoint(display.CenterReferencePoint);
	lblNextStep.x = btnNextStep.x;
	lblNextStep.y = btnNextStep.y;
	btnNextStep:setFillColor(50,30,220,0);
	gBtnNextStep:setReferencePoint(display.TopRightReferencePoint);
	gBtnNextStep.x = display.contentWidth*0.98;
	gBtnNextStep.y = display.contentHeight*0.04;
	fristStep:insert(gBtnNextStep);

	gBtnNextStep.touch = onNextBtnTouchFristStep;
	gBtnNextStep:addEventListener("touch",gBtnNextStep);

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


	--Formulário Segundo Passo
	local tfNumCartao = require("scripts.fdxTextField").new(display.contentWidth*0.4, display.contentHeight*0.2, display.contentWidth*0.5,display.contentHeight*0.08,"Numero cartão","center");
	local lblNumCartao = display.newText("Número do cartão:",display.contentWidth*0.08,display.contentHeight*0.2, native.systemFont,display.contentHeight*0.06);
	secondStep:insert(tfNumCartao);
	secondStep:insert(lblNumCartao);

	local tfNumCVV = require("scripts.fdxTextField").new(display.contentWidth*0.5, display.contentHeight*0.35, display.contentWidth*0.4,display.contentHeight*0.08,"Código de segurança","center");
	local lblNumCVV = display.newText("Código de segurança:",display.contentWidth*0.08,display.contentHeight*0.35, native.systemFont,display.contentHeight*0.06);
	secondStep:insert(tfNumCVV);
	secondStep:insert(lblNumCVV);

	local monthPicker = require("scripts.fdxDatePicker").new("month");
	monthPicker.isOpen = false;
	monthPicker.save = onSaveMonth;
	monthPicker.secondStep = secondStep;
	monthPicker:addEventListener("save",monthPicker);

	local tfValidadeMes = display.newRect(display.contentWidth*0.4, display.contentHeight*0.5,display.contentWidth*0.2,display.contentHeight*0.08);
	tfValidadeMes.monthPicker = monthPicker;
	local tfValidaMesContent = display.newText("Mês",0,0,native.systemFont,display.contentHeight*0.06);
	tfValidaMesContent:setReferencePoint(display.CenterReferencePoint);
	tfValidaMesContent.x = tfValidadeMes.x;
	tfValidaMesContent.y = tfValidadeMes.y;
	tfValidaMesContent:setTextColor(0,0,0);
	monthPicker.textMonth = tfValidaMesContent;
	secondStep:insert(tfValidadeMes);
	secondStep:insert(tfValidaMesContent);

	local yearPicker = require("scripts.fdxDatePicker").new("year");
	yearPicker.isOpen = false;
	yearPicker.save = onSaveYear;
	yearPicker.secondStep = secondStep;
	yearPicker:addEventListener("save",yearPicker);

	local tfValidadeAno = display.newRect(display.contentWidth*0.7, display.contentHeight*0.5,display.contentWidth*0.2,display.contentHeight*0.08);
	tfValidadeAno.yearPicker = yearPicker;
	local tfValidaAnoContent = display.newText("Ano", 0,0, native.systemFont,display.contentHeight*0.06);
	tfValidaAnoContent:setReferencePoint(display.CenterReferencePoint);
	tfValidaAnoContent.x = tfValidadeAno.x;
	tfValidaAnoContent.y = tfValidadeAno.y;
	tfValidaAnoContent:setTextColor(0,0,0);
	yearPicker.textYear = tfValidaAnoContent;
	secondStep:insert(tfValidadeAno);
	secondStep:insert(tfValidaAnoContent);

	local lblValidade = display.newText("Validade:", display.contentWidth*0.08,display.contentHeight*0.5,native.systemFont,display.contentHeight*0.06);
	local lblSlash = display.newText("/", display.contentWidth*0.64,display.contentHeight*0.5, native.systemFont,display.contentHeight*0.06);
	secondStep:insert(lblValidade);
	secondStep:insert(lblSlash);

	local tfTitular = require("scripts.fdxTextField").new(display.contentWidth*0.4, display.contentHeight*0.65, display.contentWidth*0.5,display.contentHeight*0.08,"Titular","center");
	local lblTitular = display.newText("Titular:",display.contentWidth*0.08,display.contentHeight*0.65, native.systemFont,display.contentHeight*0.06);
	secondStep:insert(tfTitular);
	secondStep:insert(lblTitular);

	tfValidadeMes.touch = onTfValidaMesTouch;
	tfValidadeMes:addEventListener("touch",tfValidadeMes);

	tfValidadeAno.touch = onTfValidaAnoTouch;
	tfValidadeAno:addEventListener("touch",tfValidadeAno);

	local gBtnNextStep = display.newGroup();
	local btnNextStep = display.newRoundedRect(gBtnNextStep,0,0,display.contentWidth*0.2, display.contentHeight*0.1,10);
	local lblNextStep = display.newText(gBtnNextStep,"Continuar >", 0,0, native.systemFont,display.contentHeight*0.06);
	lblNextStep:setReferencePoint(display.CenterReferencePoint);
	lblNextStep.x = btnNextStep.x;
	lblNextStep.y = btnNextStep.y;
	btnNextStep:setFillColor(50,30,220,0);
	gBtnNextStep:setReferencePoint(display.TopRightReferencePoint);
	gBtnNextStep.x = display.contentWidth*0.98;
	gBtnNextStep.y = display.contentHeight*0.04;
	secondStep:insert(gBtnNextStep);

	local gBtnBackSecondStep = display.newGroup();
	local btnBackSecondStep = display.newRoundedRect(gBtnBackSecondStep,0,0,display.contentWidth*0.2, display.contentHeight*0.1,10);
	local lblBack = display.newText(gBtnBackSecondStep,"< Voltar", 0,0, native.systemFont,display.contentHeight*0.06);
	lblBack:setReferencePoint(display.CenterReferencePoint);
	lblBack.x = btnBackSecondStep.x;
	lblBack.y = btnBackSecondStep.y;
	btnBackSecondStep:setFillColor(50,30,220,0);
	gBtnBackSecondStep:setReferencePoint(display.TopLeftReferencePoint);
	gBtnBackSecondStep.x = display.contentWidth*0.02;
	gBtnBackSecondStep.y = display.contentHeight*0.04;
	secondStep:insert(gBtnBackSecondStep);

	gBtnNextStep.touch = onNextBtnTouchSecondStep;
	gBtnNextStep:addEventListener("touch",gBtnNextStep);

	gBtnBackSecondStep.touch = onBackBtnTouchSecondStep;
	gBtnBackSecondStep:addEventListener("touch",gBtnBackSecondStep);		

	--Group lastStep
	local lastStep = display.newGroup();
	local lastStepBackground = display.newRect(0, 0, display.contentWidth,display.contentHeight);
	lastStepBackground:setFillColor(100,255,150,255);
	local lastStepTitle = display.newText("Comfirme o pedido",0,0,native.systemFont,display.contentHeight*0.07);
	lastStepTitle:setReferencePoint(display.CenterReferencePoint);
	lastStepTitle.x = display.contentWidth*0.5;
	lastStepTitle.y = display.contentWidth*0.05;

	lastStep:insert(lastStepBackground);
	lastStep:insert(lastStepTitle);

	lastStep.x = secondStepBackground.width + display.contentWidth*0.05;
	lastStep.y = 0;

	qtyPages = qtyPages +1;

	local finalTotal=0;

	--Table View para confirmação do produto
	local function onRowTouch(event)
		-- body
	end

	local function onRowRender(event)
		local phase = event.phase;
		local row = event.row;
		local product = cart.products[row.index];

		local image = display.newImage("images/produtos/"..product.sku..".jpg");
		image.width = display.contentHeight*0.15;
		image.height = display.contentHeight*0.15;
		image:setReferencePoint(display.TopLeftReferencePoint);

		image.x = display.contentWidth*0.05;
		image.y = display.contentHeight*0.03;

		local desc = display.newText(product.title,display.contentWidth*0.2,display.contentHeight*0.05, native.systemFont, display.contentHeight*0.04);
		desc:setTextColor(0,0,0);

		local qty = display.newText("Quantidade: "..product.quantity, display.contentWidth*0.2, display.contentHeight*0.11, native.systemFont, display.contentHeight*0.04);
		qty:setTextColor(0,0,0);

		finalTotal = finalTotal + product.totalPrice;

		local price = display.newText("R$ "..product.totalPrice, display.contentWidth*0.85, display.contentHeight*0.07, native.systemFont, display.contentHeight*0.04);
		price:setTextColor(0,0,0);

		row:insert(price);
		row:insert(qty);

		row:insert(desc);

		row:insert(image);

		print("Product INDEX : " , product)
	end

	local function tableViewListener(event)

	end

	local Mask = require("scripts.Utils.mask");

	local OPTIONS_LIST_WIDTH = display.contentWidth;
	local OPTIONS_LIST_HEIGHT = display.contentHeight*0.6;

	local tableViewConfirm = widget.newTableView{

		top = display.contentHeight*0.15,
		width = OPTIONS_LIST_WIDTH,
		height = OPTIONS_LIST_HEIGHT,
		listener = tableViewListener,
		onRowRender = onRowRender,
		onRowTouch = onRowTouch,
	}

	Mask.applyMask({
		object = tableViewConfirm,
		width = OPTIONS_LIST_WIDTH,
		height = OPTIONS_LIST_HEIGHT
	});

	local rowHeight = display.contentHeight*0.20;

	for i=1,#cart.products do
        tableViewConfirm:insertRow
        {
            isCategory = isCategory,
            rowHeight = rowHeight,
            rowColor = rowColor,
            lineColor = lineColor,
       	} 
    end

   	local totalText = display.newText("Total: R$ "..finalTotal,0, 0, native.systemFont,display.contentHeight*0.06);
   	totalText:setReferencePoint(display.CenterReferencePoint);

   	local gBtnDone = display.newGroup();
	local btnDone = display.newRoundedRect(gBtnDone,0,0,display.contentWidth*0.2, display.contentHeight*0.1,10);
	local lblDone = display.newText(gBtnDone,"Confirmar", 0,0, native.systemFont,display.contentHeight*0.06);
	lblDone:setReferencePoint(display.CenterReferencePoint);
	lblDone.x = btnDone.x;
	lblDone.y = btnDone.y;
	btnDone:setFillColor(50,30,220,0);
	gBtnDone:setReferencePoint(display.TopRightReferencePoint);
	gBtnDone.x = display.contentWidth*0.98;
	gBtnDone.y = display.contentHeight*0.04;
	lastStep:insert(gBtnDone);

	local gBtnBackThirdStep = display.newGroup();
	local btnBackThirdStep = display.newRoundedRect(gBtnBackThirdStep,0,0,display.contentWidth*0.2, display.contentHeight*0.1,10);
	local lblBack = display.newText(gBtnBackThirdStep,"< Voltar", 0,0, native.systemFont,display.contentHeight*0.06);
	lblBack:setReferencePoint(display.CenterReferencePoint);
	lblBack.x = btnBackThirdStep.x;
	lblBack.y = btnBackThirdStep.y;
	btnBackThirdStep:setFillColor(50,30,220,0);
	gBtnBackThirdStep:setReferencePoint(display.TopLeftReferencePoint);
	gBtnBackThirdStep.x = display.contentWidth*0.02;
	gBtnBackThirdStep.y = display.contentHeight*0.04;
	lastStep:insert(gBtnBackThirdStep);

	gBtnDone.touch = onConfirmBtnTouch;
	gBtnDone:addEventListener("touch",gBtnDone);

	gBtnBackThirdStep.touch = onBtnBackThirdStep;
	gBtnBackThirdStep:addEventListener("touch",gBtnBackThirdStep);

   	totalText.x = display.contentWidth*0.5;
   	totalText.y = display.contentHeight*0.85;

	lastStep:insert(totalText);

	lastStep:insert(tableViewConfirm);

	--Insert into de SceneGroup
	parentGroup:insert(fristStep);
	parentGroup:insert(secondStep);
	parentGroup:insert(lastStep);
	parentGroup:insert(gBtnBackToShopping);

	fristStep.secondStep = secondStep;
	fristStep.lastStep = lastStep;
	secondStep.fristStep = fristStep;
	secondStep.lastStep = lastStep;
	lastStep.fristStep = fristStep;
	lastStep.secondStep = secondStep;

	--Page control
	local pageControl = require("scripts.fdxPageControl").new(parentGroup,display.contentWidth*0.5,display.contentHeight*0.98,qtyPages,"horizontal");

	fristStep.pageControl = pageControl;
	secondStep.pageControl = pageControl;
	lastStep.pageControl = pageControl;
	--

	return checkOut;

end