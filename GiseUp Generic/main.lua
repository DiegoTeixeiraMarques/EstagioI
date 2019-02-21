display.setStatusBar(display.HiddenStatusBar)

-- Seed the random number generator
math.randomseed( os.time() )

local physics = require("physics")
physics.start()
physics.setGravity( 1, 1)

-- Definição de background
background = display.newImageRect( "fundo.png", 380, 2000 )
background.x = display.contentCenterX
background.y = display.contentCenterY
background.myName = "background"

nuvem = display.newImageRect( "nuvens.png", 100, 70 )
nuvem.x = 60
nuvem.y = 50
nuvem.myName = "nuvem"
nuvem.speed = 2

nuvem2 = display.newImageRect( "nuvens.png", 100, 70 )
nuvem2.x = 260
nuvem2.y = 500
nuvem2.myName = "nuvem2"
nuvem2.speed = 3

protetor = display.newImageRect("images/disc.png", 20, 20)
protetor.x = display.contentCenterX
protetor.y = display.contentCenterY + display.contentCenterY - 100
protetor.myName = "protetor"

--obst = display.newImageRect("images/playerone.png", 80, 80)
--obst2 = display.newImageRect("images/playertwo.png", 80, 80)
filhote = display.newImageRect("images/balao.png", 50, 90)
filhote.x = display.contentCenterX
filhote.y = display.contentCenterY + display.contentCenterY
filhote.myName = "filhote"





local function scrollView(self, event)
    if self.y > 700 then
    self.y = -50
    else
    self.y = self.y + self.speed
    end
end

nuvem.enterFrame = scrollView
nuvem2.enterFrame = scrollView
Runtime:addEventListener("enterFrame", nuvem)
Runtime:addEventListener("enterFrame", nuvem2)
print(display.contentCenterY)


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


physics.addBody( protetor, "static", {radius=30, bounce = 0.5} )
physics.addBody( filhote, "static", {radius=10, bounce = 0.5} )

local function create()
    local obst = display.newImageRect( "images/playerone.png", 40, 40 )
    --local obst2 = display.newImageRect( "images/playertwo.png", 40, 40 )
    --obst2.y = display.contentCenterY + 600
    --obst2.x = display.contentCenterX + 600
	--table.insert( asteroidsTable, newAsteroid )
	physics.addBody( obst, "dynamic", { radius=20, bounce=0.8} )
    obst.myName = "obst"
    --physics.addBody( obst2, "dynamic", { radius=20, bounce=0.8} )
    --obst2.myName = "obst"

	local whereFrom = math.random( 3 )
	if ( whereFrom == 1 ) then
		-- From the left
		obst.x = -60
		obst.y = math.random( 500 )
        obst:setLinearVelocity( math.random( 4,120 ), math.random( 20,60 ) )
        
	elseif ( whereFrom == 2 ) then
		-- From the top
		obst.x = math.random( display.contentWidth )
		obst.y = -60
		obst:setLinearVelocity( math.random(-40,40), math.random(40,120))
 	elseif (whereFrom == 3) then
 		-- From the right
        obst.x = display.contentWidth + 60
        obst.y = math.random(500)
        obst:setLinearVelocity( math.random(-120,-40), math.random(20,60) )
	end

	obst:applyTorque(math.random(-6,6))
end


local function reiniciar()
    display.remove(gameover)
    physics.start()
end

local function onCollision(event)
	obj1 = event.object1
	obj2 = event.object2

	if ( event.phase == "began" ) then
        if (obj1.myName == "filhote") then
            gameover = display.newImageRect("images/gameover.png", 160, 160)
            gameover.x = display.contentCenterX
            gameover.y = display.contentCenterY
            physics.pause()

            gameover:addEventListener( "touch", reiniciar )

    --elseif ( event.phase == "ended" ) then
        --print( obj2.myName )
        end
        print( obj1.myName .. " and " .. event.object2.myName )
        obj2:applyLinearImpulse( 0.1, 0.1 )
        obj2:applyForce( 12, 12, obj2.x, obj2.y )
    end

end


local function gameLoop()
        create()
end

protetor:addEventListener( "touch", dragShip )
Runtime:addEventListener( "collision", onCollision )

gameLoopTimer = timer.performWithDelay( 500, gameLoop, 0 )