module(...,package.seeall);

function new(x,y,width,height)

 local fdxTFGroup = display.newGroup()
 local fdxTFContainer = display.newRect(x, y, width, height)
 local fdxTFValue = ""

 --listener para o nativeTextField criado
 local function onTouchTextFieldListener(self, event)
  local phase = event.phase;
  if phase == "userInput" then
   native.setKeyboardFocus(self);
  elseif phase == "ended" then
   native.setKeyboardFocus(nil);
   self:removeSelf();
  end
 end


 --listener para o container (fake)
 local function onTouchContainerListener(self, event)
  local phase = event.phase;
	if phase == "began" then
   local nativeTextField = native.newTextField(x, y, width, height);
   nativeTextField.userInput = onTouchTextFieldListener;
   nativeTextField:addEventListener("userInput", nativeTextField)
   fdxTFGroup:insert(nativeTextField)
  end
  return true;
 end

 fdxTFContainer.touch = onTouchContainerListener
 fdxTFContainer:addEventListener("touch", fdxTFContainer)

 fdxTFGroup:insert(fdxTFContainer)
 return fdxTFContainer
end
