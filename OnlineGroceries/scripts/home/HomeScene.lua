local storyboard = require( "storyboard" );
local scene = storyboard.newScene();

----------------------------------------------------------------------------------
-- 
--      NOTE:
--      
--      Code outside of listener functions (below) will only be executed once,
--      unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------


-- local forward references should go here --


---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
        local group = self.view
        display.setStatusBar( display.HiddenStatusBar );
        -----------------------------------------------------------------------------

        --      CREATE display objects and add them to 'group' here.
        --      Example use-case: Restore 'group' from previously saved state.

        -----------------------------------------------------------------------------

end


-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
        local group = self.view
        -----------------------------------------------------------------------------

        --      This event requires build 2012.782 or later.

        -----------------------------------------------------------------------------

end

-- local function onBtn1Touch(self,event)

--     local phase = event.phase;

--     if phase == "began" then
--         self.cHome:buildCenario(self.listProds, self.group,2);
--     end
-- end

-- local function onBtn2Touch(self,event)

--     local phase = event.phase;

--     if phase == "began" then
--         self.cHome:buildCenario(self.listProds, self.group,3);
--     end

-- end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
        local group = self.view;
        local cJson = require("scripts.Utils.JSONHandler").new();
        local cHome = require("scripts.home.HomeClass").new();
        local json = require("json");
        local body = "marketId=3";--Params para a requisição //Ex. "<var>=<value>&<var2>=<value2>&.."
        local listProds;
        local path = system.pathForFile( "products.json");

        local file = io.open( path, "r" )

        local jsonStr
        for line in file:lines() do
            jsonStr = line
        end
        
        
        listProds= json.decode(jsonStr);

        -- local gBtnCols = display.newGroup();

        -- local btn1 = display.newRect(gBtnCols,0,0,100,100);
        -- btn1:setFillColor(100,123,0,255);
        -- btn1.cHome = cHome;
        -- btn1.listProds = listProds;
        -- btn1.group = group;
        -- btn1.touch = onBtn1Touch;
        -- btn1:addEventListener("touch",btn1);

        -- local btn2 = display.newRect(gBtnCols,100,0,100,100);
        -- btn2:setFillColor(50,100,0,255);
        -- btn2.cHome = cHome;
        -- btn2.listProds = listProds;
        -- btn2.group = group;
        -- btn2.touch = onBtn2Touch
        -- btn2:addEventListener("touch",btn2);

        -- group:insert(gBtnCols);
        -- gBtnCols.x = display.contentWidth*0.5;
        -- gBtnCols.y = display.contentHeight*0.5;



        cHome:buildCenario(listProds, group,2);
        
--        --Entra quando JSON é carregado
--        local function loaded(event)
--            if(event.isError) then
--                print("JSON LOADING ERROR");
--            else
--                listProds= json.decode(event.response);
--                print(event.response);
--                cHome:buildCenario(listProds, group);
--            end
--        end
--        a
--        cJson:getJSONWithParams(LIST_ALL_PRODS_MK,cJson:buildParams(body),loaded);     
        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)

        -----------------------------------------------------------------------------

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view
        self.view = nil;
        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)

        -----------------------------------------------------------------------------

end


-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      This event requires build 2012.782 or later.

        -----------------------------------------------------------------------------

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. remove listeners, widgets, save state, etc.)

        -----------------------------------------------------------------------------

end


-- Called if/when overlay scene is displayed via storyboard.showOverlay()
function scene:overlayBegan( event )
        local group = self.view
        local overlay_name = event.sceneName  -- name of the overlay scene

        -----------------------------------------------------------------------------

        --      This event requires build 2012.797 or later.

        -----------------------------------------------------------------------------

end


-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
        local group = self.view
        local overlay_name = event.sceneName  -- name of the overlay scene

        -----------------------------------------------------------------------------

        --      This event requires build 2012.797 or later.

        -----------------------------------------------------------------------------

end



---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "willEnterScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "didExitScene" event is dispatched after scene has finished transitioning out
scene:addEventListener( "didExitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-- "overlayBegan" event is dispatched when an overlay scene is shown
scene:addEventListener( "overlayBegan", scene )

-- "overlayEnded" event is dispatched when an overlay scene is hidden/removed
scene:addEventListener( "overlayEnded", scene )

---------------------------------------------------------------------------------

return scene

