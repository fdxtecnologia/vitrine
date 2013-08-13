module(...,package.seeall);

function new(x,y,width,height)

    local fdxTFGroup = display.newGroup()
    local fdxTFContainer = display.newRect(x, y, width, height)
    local fdxTFText = display.newText(fdxTFGroup, "Busca", x, y,width,height,system.nativeFont,12)
    fdxTFText:setTextColor(200,200,200);
    
    --listener para o nativeTextField criado
    local function onTouchTextFieldListener(self, event)
        local phase = event.phase;
        if phase == "userInput" then
            native.setKeyboardFocus(self);
        elseif phase == "ended" or phase == "submitted"then
            native.setKeyboardFocus(nil);
            fdxTFText.text = event.target.text;
            self:removeSelf();
        end
        return true;
    end

    --listener para o container (fake)
    local function onTouchContainerListener(self, event)
        local phase = event.phase;
        if phase == "began" then
            local nativeTextField = native.newTextField(x, y, width, height);
            nativeTextField.userInput = onTouchTextFieldListener;
            nativeTextField:addEventListener("userInput", nativeTextField)
            fdxTFGroup:insert(nativeTextField)
            native.setKeyboardFocus(nativeTextField)
        end
        return true;
    end
    
    fdxTFContainer.touch = onTouchContainerListener;
    fdxTFContainer:addEventListener("touch", fdxTFContainer);

    fdxTFGroup:insert(fdxTFContainer)
    return fdxTFContainer
end
