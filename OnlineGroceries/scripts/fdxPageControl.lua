module(...,package.seeall);

function new(parentGroup,x,y,qtyPage,orientation)

	local pageControl = {};

	local pageControlGroup = display.newGroup();

	local posX = 0;
	local posY = 0;

	local pages  = {};

	for i=1,qtyPage do
		local page = display.newCircle(posX,posY,display.contentWidth*0.005);
		page:setFillColor(0,0,0,180);
		table.insert(pages,page);
		posX = posX + page.width + display.contentWidth*0.005;
		pageControlGroup:insert(page);
	end

	local selectedCircle = display.newCircle(0,0,display.contentWidth*0.004);
	selectedCircle:setFillColor(125,125,125);

	function pageControl:setPage(page)
		local pageActualIndex = pages[page];
		selectedCircle.x = pageActualIndex.x;
		selectedCircle.y = pageActualIndex.y;
	end

	function pageControl:getCurrentPage()
		for j=1, #pages do
			if(selectedCircle.x == pages[j].x)then
				return j;
			end
		end
	end

	pageControlGroup:insert(selectedCircle);

	--pageControlGroup:setReferencePoint(display.TopLeftReferencePoint);

	pageControlGroup.x = x;
	pageControlGroup.y = y;

	parentGroup:insert(pageControlGroup);

	return pageControl;
end