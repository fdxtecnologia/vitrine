module(...,package.seeall);

function new()
	
	local checkout = {}
	
	function checkout:buildCheckout(group, cart)
		local widget = require ("widget")
		widget.setTheme("widget_theme_android")
		checkout.payment = require("scripts.checkout.PaymentClass").new()
		checkout.shippingValue = 0
		checkout.orderTotal = cart.total
		
		
		local titleGroup = display.newGroup()
		local titleBar = display.newRect(titleGroup, 0, display.statusBarHeight, display.contentWidth, 50);
		titleBar:setFillColor(140, 140, 140)
		titleBar:setStrokeColor(180, 180, 180)
		local title = display.newText("Finalizar Compra", (titleBar.contentWidth * 0.5) - 80, 30, native.systemFontBold, 16)
		title:setTextColor(255,255,255)
		titleGroup:insert(title)
		
		--Conteudo
		local baseTop = titleBar.contentHeight + display.statusBarHeight;
		
		local content = widget.newScrollView({
			top = baseTop,
			left = 0,
			width = display.contentWidth,
			height = display.contentHeight - (titleGroup.contentHeight + display.statusBarHeight),
			scrollHeight = 3000,
			horizontalScrollDisabled = true,
			backgroundColor = {125,125,125,255}
		})
		content:toBack()

		--Endereço de entrega
		local labelEndereco = display.newText(content, "Endereço", 10, 10, native.systemFont, 16);
		labelEndereco:setTextColor(0,0,0);
		content:insert(labelEndereco);
		--local textFieldSearch = require("scripts.fdxTextField").new((display.contentWidth*0.5)-(display.contentWidth*0.25),display.contentHeight*0.02,display.contentWidth*0.5,display.contentHeight*0.05,"Busca","center");
		local inputEndereco = require("scripts.fdxTextField").new(10,30,display.contentWidth-50,30,"Endereço","center");
		content:insert(inputEndereco);

		--Horário
		local labelHorario = display.newText(content, "Horário de Entrega", 10, 80, native.systemFont, 16)
		labelHorario:setTextColor(0,0,0)
		content:insert(labelHorario)
		--Botao de Picker do horário
		local function handleButtonHorario( event )
			local phase = event.phase 
			
			if "ended" == phase then
				--Subir Picker
				print( "You pressed and released a button!" )
			end
		end
		
		
		local botaoHorario = widget.newButton({
			left = 10,
			top = 110,
			width = display.contentWidth - 30,
			height = 30,
			label = "Manhã  >",
			onEvent = handleButtonHorario,
			labelAlign = "left",
		})
		content:insert(botaoHorario)
		
		local labelTotal = display.newText("Total: R$ 235,90", 10, 150, system.nativeFont, 16)
		labelTotal:setTextColor(0,0,0)
		content:insert(labelTotal)
		
		
		--Dados do pagamento
		local labelDadosPagamento = display.newText("Dados do pagamento",10,180,system.nativeBoldFont, 18)
		labelDadosPagamento:setTextColor(0,0,0)
		content:insert(labelDadosPagamento)
		
		--Numero do Cartao
		local labelNumCartao = display.newText("Número do Cartão de Crédito",10,210,system.nativeBoldFont, 16)
		labelNumCartao:setTextColor(0,0,0)
		content:insert(labelNumCartao);
		local inputNumCartao = require("scripts.fdxTextField").new(10,240,display.contentWidth-50,30,"Numero Cartão","center");
		--local inputNumCartao = native.newTextField( 10, 240, display.contentWidth - 50, 30 )
		content:insert(inputNumCartao)
		--Codigo Segurança
		local labelCVV = display.newText("Código de Segurança",10,270,system.nativeBoldFont, 16)
		labelCVV:setTextColor(0,0,0)
		content:insert(labelCVV);
		local inputCVV = require("scripts.fdxTextField").new(10,300,display.contentWidth-50,30,"Código de segurança","center");
		--local inputCVV = native.newTextField( 10, 300, display.contentWidth - 50, 30 )
		content:insert(inputCVV)
		--Validade
		local labelValidade = display.newText("Validade",10,330,system.nativeBoldFont, 16)
		labelValidade:setTextColor(0,0,0)
		content:insert(labelValidade)
		
		local labelValidadeMes = display.newText("MM",10,360,system.nativeBoldFont, 16)
		labelValidadeMes:setTextColor(0,0,0)
		local labelValidadeAno = display.newText("AA",50,360,system.nativeBoldFont, 16)
		labelValidadeAno:setTextColor(0,0,0);
		local inputValidadeMes = require("scripts.fdxTextField").new(10,380,30,30,"Mês","center");
		--local inputValidadeMes = native.newTextField( 10, 380, 30, 30 )
		local inputValidadeAno = require("scripts.fdxTextField").new(50,380,30,30,"Ano","center");
		--local inputValidadeAno = native.newTextField( 50, 380, 30, 30 )
		content:insert(labelValidadeMes)
		content:insert(labelValidadeAno)
		content:insert(inputValidadeMes)
		content:insert(inputValidadeAno)
		
		-- Titular do Cartão
		local labelTitular = display.newText("Titular do Cartão",10,410,system.nativeBoldFont, 16)
		labelTitular:setTextColor(0,0,0);
		content:insert(labelTitular);
		local inputTitular = require("scripts.fdxTextField").new(10,440,display.contentWidth - 50,30,"Titular","center");
		--local inputTitular = native.newTextField( 10, 440, display.contentWidth - 50, 30 )
		content:insert(inputTitular);
		
		--Botao de Picker do horário
		local function handleButtonConcluir( event )
			local phase = event.phase 
			local customer = {
				firstName = "Andre",
				lastName = "Luis"
			}
			local products = {
				{
					idProduct = 1,
		            sku = "7891149103270",
		            quantity = 1,
		            price = 10.00,
		            totalPrice = 1 * 10.00,
		            title = "Vodka Smirnoff Raspberry 1L"
				}
			}

			local payment = require("scripts.checkout.PaymentClass").new()

			local order = require("scripts.order.OrderClass").new(customer, products, payment)
			

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
		end
				
		local botaoConcluir = widget.newButton({
			left = 10,
			top = 470,
			width = display.contentWidth - 30,
			height = 30,
			label = "Fechar Pedido!",
			onEvent = handleButtonConcluir,
			labelAlign = "center",
		})
		content:insert(botaoConcluir)
		
	end
	
	return checkout
end
