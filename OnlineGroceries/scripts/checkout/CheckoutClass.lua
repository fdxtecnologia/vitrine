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
            horizontalScrollDisabled = true
        })
        content:toBack()
        --Endereço de entrega
        local labelEndereco = display.newText(content, "Endereço", 10, 10, native.systemFont, 16)
        labelEndereco:setTextColor(0,0,0)
        content:insert(labelEndereco)
        local inputEndereco = native.newTextField( 10, 30, display.contentWidth - 50, 30 )
        content:insert(inputEndereco)
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
        content:insert(labelNumCartao)
        local inputNumCartao = native.newTextField( 10, 240, display.contentWidth - 50, 30 )
        content:insert(inputNumCartao)
        --Codigo Segurança
        local labelCVV = display.newText("Código de Segurança",10,270,system.nativeBoldFont, 16)
        labelCVV:setTextColor(0,0,0)
        content:insert(labelCVV)
        local inputCVV = native.newTextField( 10, 300, display.contentWidth - 50, 30 )
        content:insert(inputCVV)
        --Validade
        local labelValidade = display.newText("Validade",10,330,system.nativeBoldFont, 16)
        labelValidade:setTextColor(0,0,0)
        content:insert(labelValidade)
        
        local labelValidadeMes = display.newText("MM",10,360,system.nativeBoldFont, 16)
        labelValidadeMes:setTextColor(0,0,0)
        local labelValidadeAno = display.newText("AA",50,360,system.nativeBoldFont, 16)
        labelValidadeAno:setTextColor(0,0,0)
        local inputValidadeMes = native.newTextField( 10, 380, 30, 30 )
        local inputValidadeAno = native.newTextField( 50, 380, 30, 30 )
        content:insert(labelValidadeMes)
        content:insert(labelValidadeAno)
        content:insert(inputValidadeMes)
        content:insert(inputValidadeAno)
        
        -- Titular do Cartão
        local labelTitular = display.newText("Titular do Cartão",10,410,system.nativeBoldFont, 16)
        labelTitular:setTextColor(0,0,0)
        content:insert(labelTitular)
        local inputTitular = native.newTextField( 10, 440, display.contentWidth - 50, 30 )
        content:insert(inputTitular)
    end
    
    return checkout
end
