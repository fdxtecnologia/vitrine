module(...,package.seeall);

--A variavél "typeOfPicker" pode ser = "date" ou "time" ou "period"

function new(typeOfPicker)

	local columnData;
	local widget = require("widget");
	local picker;

	--Touch handlers
	local function onSaveTouch(self, event)
		local phase = event.phase;

		if phase == "ended" then
			local event = {
                name = "save",
                type = "saved",
        	}
        	picker:dispatchEvent(event);
		end
		return true;
	end 

	if(typeOfPicker == "date") then

		local months = {"Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"};
		local days = {};
		local years = {};
		local date = os.date("*t");
		local initialYear = 1970;

		local todaysDayIndex;
		local todaysYearIndex;

		for i=1, 31 do
			days[i] = i;
			if(i == date.day) then
				todaysDayIndex = i;
			end
		end

		local j=1;

		while(initialYear + j <= date.year) do
			local year = initialYear + j;
			years[j] = initialYear + j;
			j = j + 1;
			if((initialYear + j) == date.year) then
				todaysYearIndex = j;
			end
		end 

		columnData = {

			{
				align = "right",
				width = display.contentWidth *0.10,
				startIndex = todaysDayIndex,
				labels = days,
			},
			{
				align = "center",
				width = display.contentWidth *0.33,
				startIndex = date.month,
				labels = months,
			},
			{
				align = "left",
				width = display.contentWidth *0.33,
				startIndex = todaysYearIndex,
				labels = years,
			},

		};   

		print("Entour if Date");

	elseif(typeOfPicker == "time") then

		local hours = {};
		local minutes = {};
		local period = {"AM","PM"};

		for i = 0, 60 do
			if i < 10 then
				minutes[i+1] = "0"..i;
			else
				minutes[i+1] = i;
			end
		end

		for j = 0, 12 do
			if j < 10 then
				hours[j+1] = "0"..j;
			else
				hours[j+1] = j;
			end
		end

		columnData = {
			{
				align = "right",
				width = display.contentWidth *0.10,
				startIndex = 1,
				labels = hours,
			},

			{
				align = "center",
				width = display.contentWidth *0.33,
				startIndex = 1,
				labels = minutes,
			},

			{
				align = "left",
				width = display.contentWidth*0.33,
				startIndex = 1,
				labels = period,
			},
		}

	elseif(typeOfPicker == "period") then

	elseif(typeOfPicker == "month") then
		local date = os.date("*t");
		local months = {"Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"};

		columnData = {

			{
				align = "center",
				width = display.contentWidth*0.55,
				startIndex = date.month,
				labels = months,
			},

		}; 
	
	elseif(typeOfPicker == "year") then
		local date = os.date("*t");
		local years = {};

		for k = 0, 20 do
			years[k+1] = date.year+k;
		end

		columnData = {

			{
				align = "center",
				width = display.contentWidth*0.55,
				startIndex = 1,
				labels = years,
			},

		}; 

	end

	local datePicker = display.newGroup();

	local menu = display.newGroup();
	local rect = display.newRect(0,0,display.contentWidth, display.contentHeight*0.15);
	local gBtnSave = display.newGroup();
	local btnSave = display.newCircle(gBtnSave,0,0,20);
	btnSave:setStrokeColor(100,245,150,255);
	btnSave.strokeWidth = 3;
	local lblSave = display.newText(gBtnSave,"Salvar", 0,0, native.systemFont, display.contentHeight*0.03);
	lblSave:setTextColor(100,245,150,255);
	lblSave:setReferencePoint(display.CenterReferencePoint);

	lblSave.x = 0;
	lblSave.y = 0;

	gBtnSave.x = rect.width*0.95;
	gBtnSave.y = rect.height*0.5;

	gBtnSave.touch = onSaveTouch;
	gBtnSave:addEventListener("touch",gBtnSave);

	menu.x = 0;
	menu.y = (-1)*display.contentHeight*0.15;

	menu:insert(rect);
	menu:insert(gBtnSave);

	picker = widget.newPickerWheel{

		top = display.contentHeight,
		overlayFrameWidth = display.contentWidth,
		font = native.systemFont,
		columns = columnData,
	};

	--datePicker:insert(rect);
	--datePicker:insert(picker);

	--datePicker.picker = picker;
	--datePicker.y = display.contentHeight;

	picker.menu = menu;

	return picker;
end