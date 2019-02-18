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

-- Definição de background
background = display.newImageRect( "images/green.png", 360, 580 )
background.x = display.contentCenterX
background.y = display.contentCenterY

-- Definição de player 1
playerone = display.newImageRect( "images/playerone.png", 80, 80 )
playerone.x = display.contentCenterX
playerone.y = display.contentHeight - 100

-- Definição de player 2
playertwo = display.newImageRect( "images/playertwo.png", 80, 80 )
playertwo.x = display.contentCenterX
playertwo.y = display.contentHeight - 380

-- Definição do disco de jogo
disc = display.newImageRect( "images/disc.png", 40, 40)
disc.x = display.contentCenterX
disc.y = display.contentCenterY


-- Adicionando física aos objetos
physics.addBody( playerone, {radius=80, isSensor = true} )
physics.addBody( playertwo, {radius=80, isSensor = true} )
physics.addBody( disc, {radius=40, isSensor = true} )


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

playerone:addEventListener( "touch", dragShip )
playertwo:addEventListener( "touch", dragShip2 )
