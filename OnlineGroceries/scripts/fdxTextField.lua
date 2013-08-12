module(...,package.seeall);

function new(x,y,width,height)

	local fdxTextField = display.newGroup();
	local fakeTextField = display.newRect(0,0,width,height);
	fakeTextField.touch = onTouchFakeTextField;
	fdxTextField.x = x;
	fdxTextField.y = y;
	fdxTextField:insert(fakeTextField);

	local function onRealTextFieldTouch(self,event)

		local phase = event.phase;

		if phase == "userInput" then
			native.setKeyboardFocus(self);
		elseif phase == "ended" then
			native.setKeyboardFocus(nil);
			self:removeSelf();
		end
	end

	local function onTouchFakeTextField(self,event)

		local phase = event.phase;
		print("TOUCHH TEXT")
		if phase == "began" then
			print("HAHA");
			local realTextField = native.newTextField(self.x, self.y, self.width, self.height);
			realTextField.userInput = onRealTextFieldTouch;
			realTextField:addEventListener("userInput", realTextField);
			fdxTextField:insert(realTextField);
		end
	end

	fakeTextField:addEventListener("touch", fakeTextField);
	print("TEXT FIELD")
	return fdxTextField;
end
