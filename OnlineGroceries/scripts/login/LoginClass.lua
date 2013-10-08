module(...,package.seeall);
local saver = require("scripts.Utils.dataSaver");

function new()
    local login = {};

    local JSONHandler = require("scripts.Utils.JSONHandler").new();
    local json = require("json");

    local function onFbEvent( self,event )
       local typeE = event.type;

       if typeE == "logged" then
            print("Logado com access Token", event.data);
       elseif typeE == "requested" then
            local storyboard  = require("storyboard");
            storyboard.gotoScene("scripts.home.HomeScene");
       elseif typeE == "error" then
            print("Um erro ocorreu: ",event.data);
       end
       return true;
    end

    local function onLogWithFBTouch(self,event)
        local phase = event.phase;

        if phase == "ended" then
            local fbUtils = require("scripts.Utils.FacebookUtils").new()
            local response = fbUtils:login();

            Runtime.fbEvent = onFbEvent;
            Runtime:addEventListener("fbEvent", Runtime);

            print ("Response: "..tostring(response))
            if(response == nil) then
                local customerObject = {
                    firstName = "Sand",
                    lastName = "Box",
                }
                saver.saveValue("customer",customerObject);
            end
            local storyboard  = require("storyboard");
            if(response == nil) then
                storyboard.gotoScene("scripts.checkout.CheckoutScene");
            end
        end
        return true;
    end

    local function onLoginTouch(self,event)
        local phase = event.phase;

        if phase == "ended" then

            local body = "login="..self.email.text.."&password="..self.senha.text;--Params para a requisição //Ex. "<var>=<value>&<var2>=<value2>&.."
            local params = JSONHandler:buildParams(body);

            local function callBackLogin(event)
                if(event.isError) then

                    print("ERRO ", result);
                else

                    print("LOGIN EFETUADO");
                end
            end

            JSONHandler:getJSONWithParams(LOGIN,params,callBackLogin);
        end

        return true;
    end

    local function onSignUpTouch(self,event)
        local phase = event.phase;

        if phase == "ended" then

            print("Nome :", self.tfNomeUp.text);

            local customer = { customer ={
                    firstName = self.tfNomeUp.text,
                    lastName = "",
                    user = {
                        name = self.tfEmailUp.text,
                        email = self.tfEmailUp.text,
                        password = self.tfSenhaUp.text, 
                    },
                }
            };

            local body = JSONHandler:encode(customer);

            local params = JSONHandler:buildParams(body);

            local function callBackSignUp(event)
                if(event.isError) then
                    print("Erro ao enviar o pedido");
                else
                    result = JSONHandler:decode(event.response);
                    print("SIGNUP FEITO ",resut);
                end
            end

            JSONHandler:getJSONWithParams(SIGNUP_CUSTOMER,params,callBackSignUp);

        end

        return true;
    end

    
    function login:buildForm(parentGroup)

        saver.saveValue("customer",nil);
        local customerData = saver.loadValue("customer");

        if(customerData == nil) then

            local bg = display.newRect(0,0,display.contentWidth,display.contentHeight);
            bg:setFillColor(0,0,0);

            local title = display.newText("Login", 0, 0, native.systemFont, display.contentHeight*0.09);
            title:setReferencePoint(display.CenterReferencePoint);
            title.x = display.contentWidth/2;
            title.y = display.contentHeight*0.08;

            local tfEmail = require("scripts.fdxTextField").new(display.contentWidth*0.05,display.contentHeight*0.2, display.contentWidth*0.4,display.contentHeight*0.08,"E-Mail","center");
            local tfSenha = require("scripts.fdxTextField").new(display.contentWidth*0.05,display.contentHeight*0.35, display.contentWidth*0.4,display.contentHeight*0.08,"Senha","center","password");

            local gBtnLogin = display.newGroup();
            local btnLogin = display.newRect(gBtnLogin,0,0, display.contentWidth*0.3, display.contentHeight*0.08);
            btnLogin:setFillColor(30,200,50);
            local lblLogin = display.newText("Entrar",0,0,native.systemFont, display.contentHeight*0.06);
            lblLogin:setReferencePoint(display.CenterReferencePoint);
            lblLogin.x = btnLogin.width/2;
            lblLogin.y = btnLogin.height/2;

            gBtnLogin:insert(lblLogin);
            gBtnLogin.x = display.contentWidth*0.1;
            gBtnLogin.y = display.contentHeight*0.5;

            local lblOr = display.newText("Ou", 0,0,native.systemFont, display.contentHeight*0.06);
            lblOr:setReferencePoint(display.CenterReferencePoint);
            lblOr.x = display.contentWidth*0.25;
            lblOr.y = display.contentHeight*0.7;

            local btnLogWithFB = display.newImage("images/btnFConnect.png");
            btnLogWithFB.width = btnLogWithFB.width*((display.contentWidth*0.1)/100);
            btnLogWithFB.height = btnLogWithFB.height*((display.contentWidth*0.1)/100);
            btnLogWithFB.x = display.contentWidth*0.25;
            btnLogWithFB.y = display.contentHeight*0.88;

            local divLineVertical = display.newLine(display.contentWidth/2,display.contentHeight,display.contentWidth/2,display.contentHeight*0.17);

            local lblSignUpTitle = display.newText("Ainda não é cadastrado?",display.contentWidth*0.55,display.contentHeight*0.17,native.systemFont,display.contentHeight*0.06);

            local tfNomeUp = require("scripts.fdxTextField").new(display.contentWidth*0.55,display.contentHeight*0.3, display.contentWidth*0.4,display.contentHeight*0.08,"Nome","center");
            local tfEmailUp = require("scripts.fdxTextField").new(display.contentWidth*0.55,display.contentHeight*0.45, display.contentWidth*0.4,display.contentHeight*0.08,"E-Mail","center");
            local tfSenhaUp = require("scripts.fdxTextField").new(display.contentWidth*0.55,display.contentHeight*0.6, display.contentWidth*0.4,display.contentHeight*0.08,"Senha","center","password");
            local tfConfirmUp = require("scripts.fdxTextField").new(display.contentWidth*0.55,display.contentHeight*0.75, display.contentWidth*0.4,display.contentHeight*0.08,"Corfirma Senha","center","password");

            local gBtnSignUp = display.newGroup();
            local btnSignUp = display.newRect(gBtnSignUp,0,0, display.contentWidth*0.3, display.contentHeight*0.08);
            btnSignUp:setFillColor(30,200,50);

            local lblSignUp = display.newText("Cadastrar",0,0,native.systemFont,display.contentHeight*0.06);
            lblSignUp:setReferencePoint(display.CenterReferencePoint);
            lblSignUp.x = btnSignUp.width/2;
            lblSignUp.y = btnSignUp.contentHeight/2;

            gBtnSignUp:insert(lblSignUp);

            gBtnSignUp.x = display.contentWidth*0.6;
            gBtnSignUp.y = display.contentHeight*0.88;

            btnLogWithFB.touch = onLogWithFBTouch;
            btnLogWithFB:addEventListener("touch");

            gBtnSignUp.tfNomeUp = tfNomeUp;
            gBtnSignUp.tfEmailUp = tfEmailUp;
            gBtnSignUp.tfSenhaUp = tfSenhaUp;
            gBtnSignUp.tfConfirmUp = tfConfirmUp;
            gBtnSignUp.touch = onSignUpTouch;
            gBtnSignUp:addEventListener("touch", gBtnSignUp);


            gBtnLogin.email = tfEmail;
            gBtnLogin.senha = tfSenha;
            gBtnLogin.touch = onLoginTouch;
            gBtnLogin:addEventListener("touch",gBtnLogin);

            parentGroup:insert(bg);
            parentGroup:insert(title);
            parentGroup:insert(tfEmail);
            parentGroup:insert(tfSenha);
            parentGroup:insert(gBtnLogin);
            parentGroup:insert(lblOr);
            parentGroup:insert(btnLogWithFB);
            parentGroup:insert(divLineVertical);
            parentGroup:insert(lblSignUpTitle);
            parentGroup:insert(tfNomeUp);
            parentGroup:insert(tfEmailUp);
            parentGroup:insert(tfSenhaUp);
            parentGroup:insert(tfConfirmUp);
            parentGroup:insert(gBtnSignUp);

        else
            local storyboard  = require("storyboard");
            storyboard.gotoScene("scripts.checkout.CheckoutScene");
        end
    end
        
    return login
end
