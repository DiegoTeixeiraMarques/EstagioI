-- Retirando statusBar da tela
display.setStatusBar( display.HiddenStatusBar )

-- Adicionando física ao jogo sem gravidade
local physics = require("physics")
physics.start()
physics.setGravity( 0, 0)

local background
local playerone
local playertwo
local disc
local bord

-- Definição de background
background = display.newImageRect( "images/green.png", 360, 580 )
background.x = display.contentCenterX
background.y = display.contentCenterY
background.myName = "background"



-- Definição da borda
bord1 = display.newImageRect( "images/bord1.png", 10, display.actualContentHeight )
bord1.x = display.actualContentWidth
bord1.y = display.contentCenterY
bord1.myName = "bord1"



-- Definição da borda
bord2 = display.newImageRect( "images/bord1.png", 10, display.actualContentHeight )
bord2.x = display.actualContentWidth - display.actualContentWidth 
bord2.y = display.contentCenterY
bord2.myName = "bord2"


-- Definição da borda
bord3 = display.newImageRect( "images/bord-deitada.png", 10, display.actualContentWidth )
bord3.x = display.contentCenterX
bord3.y = display.contentCenterY - 285
bord3:rotate( 270 )
bord3.myName = "bord3"


-- Definição da borda
bord4 = display.newImageRect( "images/bord-deitada.png", 10, display.actualContentHeight )
bord4.x = display.contentCenterX
bord4.y = display.contentCenterY + 285
bord4:rotate( 270 )
bord4.myName = "bord4"



-- Definição do disco de jogo
disc = display.newImageRect( "images/disc.png", 40, 40)
disc.x = display.contentCenterX
disc.y = display.contentCenterY
disc.myName = "disc"



-- Definição de player 1
playerone = display.newImageRect( "images/playerone.png", 80, 80 )
playerone.x = display.contentCenterX
playerone.y = display.contentHeight - 100
playerone.myName = "playerone"



-- Definição de player 2
playertwo = display.newImageRect( "images/playertwo.png", 80, 80 )
playertwo.x = display.contentCenterX
playertwo.y = display.contentHeight - 380
playertwo.myName = "playertwo"



-- Adicionando física aos objetos
physics.addBody( playerone, "static", {radius=38, bounce=2} )
physics.addBody( playertwo, "static", {radius=38, bounce=2} )
physics.addBody( disc, "dynamic", {radius=20, density = -5} )
physics.addBody( bord1, "static", {density = 10.0, bounce = 2 })
physics.addBody( bord2, "static", {density = 10.0, bouce = 2 })
physics.addBody( bord3, "static", {density = 10.0, bounce = 2 })
physics.addBody( bord4, "static", {density = 10.0, bounce = 2 })



local function dragShip( event )
	local playerone = event.target
	local phase = event.phase

	if ("began" == phase) then
		-- Set touch focus on the ship
		display.currentStage:setFocus( playerone )
		-- Store initial offset position
		playerone.touchOffsetX = event.x - playerone.x
		playerone.touchOffsetY = event.y - playerone.y

	elseif ("moved" == phase) then
		-- Move the ship to the new touch position
		playerone.x = event.x - playerone.touchOffsetX
		playerone.y = event.y - playerone.touchOffsetY

	elseif ("ended" == phase or "cancelled" == phase) then
	-- Release touch focus on the ship
	display.currentStage:setFocus(nil)
	end

	return true -- Prevents touch propagation to underlying objects
end



local function dragShip2( event )
	local playertwo = event.target
	local phase = event.phase

	if ("began" == phase) then
		-- Set touch focus on the ship
		display.currentStage:setFocus( playertwo )
		-- Store initial offset position
		playertwo.touchOffsetX = playertwo.x - playertwo.x
		playertwo.touchOffsetY = playertwo.y - playertwo.y

	elseif ("moved" == phase) then
		-- Move the ship to the new touch position
		playertwo.x = event.x - playertwo.touchOffsetX
		playertwo.y = event.y - playertwo.touchOffsetY

	elseif ("ended" == phase or "cancelled" == phase) then
	-- Release touch focus on the ship
	display.currentStage:setFocus(nil)
	end

	return true -- Prevents touch propagation to underlying objects
end

local function onCollision(event)
	obj1 = event.object1
	obj2 = event.object2

	if ( event.phase == "began" ) then
		--if () then
        print( obj1.myName .. " and " .. event.object2.myName )
        --obj2:applyLinearImpulse( 0.5, 1 )
        obj2:applyForce( 18, 18, obj2.x, obj2.y )
    --elseif ( event.phase == "ended" ) then
        --print( obj2.myName )
    end

end


playerone:addEventListener( "touch", dragShip )
playertwo:addEventListener( "touch", dragShip2 )

Runtime:addEventListener( "collision", onCollision )
