module(...,package.seeall);

function new(x,y,width,height,placeholder,align)

    local fakeTFGroup = display.newGroup();
    local fdxTFContainer = display.newRect(x, y, width, height);
    local fdxTFText = display.newText(placeholder, x+display.contentWidth*0.02, y,width,height,system.nativeFont,height*0.8);
    local isShowingNative = false;
    fdxTFText:setTextColor(200,200,200);

    fakeTFGroup:insert(fdxTFContainer);
    fakeTFGroup:insert(fdxTFText);

    --listener para o nativeTextField criado
    local function onTouchTextFieldListener(self, event)
        local phase = event.phase;
        if phase == "userInput" then
          display.getCurrentStage():setFocus(self);
        elseif phase=="submitted" then
          fdxTFText.text = self.text;
          native.setKeyboardFocus(nil);
          display.getCurrentStage():setFocus(nil);
          isShowingNative = false;
        elseif phase == "ended" then
          native.setKeyboardFocus(nil);
          if(self.text == "") then
            fdxTFText.text = placeholder;
            fdxTFText:setTextColor(200,200,200);
          else
            fdxTFText.text = self.text;
            fdxTFText:setTextColor(0,0,0);
          end
          display.getCurrentStage():setFocus(nil);
          self:removeSelf();
          isShowingNative = false;
        elseif phase == "editing" then
          print("Letra"..event.newCharacters);
          local eventLetters = {
            name = "letters",
            type = "editing",
            newCharacters = event.newCharacters,
            oldText = event.oldText,
            text = event.text
          }
          fakeTFGroup:dispatchEvent(eventLetters);
        end
        return true;
    end

    --listener para o container (fake)
    local function onTouchContainerListener(self, event)
        local phase = event.phase;
        if isShowingNative == false then
          if phase == "began" then
            display.getCurrentStage():setFocus(self);
            local nativeTextField = native.newTextField(x, y, width, height);
            nativeTextField.userInput = onTouchTextFieldListener;
            nativeTextField.align = align;
            nativeTextField.font = native.newFont( native.systemFontBold, height*1.1 )
            nativeTextField:addEventListener("userInput", nativeTextField);
            fakeTFGroup:insert(nativeTextField);
            native.setKeyboardFocus(nativeTextField);
            isShowingNative = true;
          elseif phase == "ended" then
            display.getCurrentStage():setFocus(nil);
          end
        end
        return true;
    end
    
    fakeTFGroup.touch = onTouchContainerListener;
    fakeTFGroup:addEventListener("touch", fakeTFGroup);

    return fakeTFGroup;
end
