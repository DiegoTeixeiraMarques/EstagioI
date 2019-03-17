display.setStatusBar(display.HiddenStatusBar)



-- Reserve channel 1 for background music
audio.reserveChannels( 1 )

-- Reduce the overall volume of the channel
audio.setVolume( 0.5, { channel=1 } )
trilhasonora = audio.loadSound( "audio/trilha.mp3" )
audio.play(trilhasonora)

-- Seed the random number generator
math.randomseed( os.time() )

local physics = require("physics")
physics.start()
physics.setGravity( 0, 0)

-- Definição de background
background = display.newImageRect( "images/grama.png", 1000, 1000 )
background.x = display.contentCenterX
background.y = display.contentCenterY
background.myName = "background"
background.speed = 3

pontos = 0
pontosText = display.newText( pontos, display.contentCenterX, display.contentCenterY - 200, native.systemFont, 36 )

--[[
arvores = display.newImageRect("images/arvores.png", 300, 300)
arvores.x = display.contentCenterX
arvores.y = display.contentCenterY
arvores.myName = "arvores"
--]]



--[[
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

protetor = display.newImageRect("images/disc.png", 60, 60)
protetor.x = display.contentCenterX
protetor.y = display.contentCenterY + display.contentCenterY - 100
protetor.myName = "protetor"
--]]

--obst = display.newImageRect("images/playerone.png", 80, 80)
--obst2 = display.newImageRect("images/playertwo.png", 80, 80)
--filhote = display.newImageRect("images/balao.png", 50, 90)
--filhote.x = display.contentCenterX
--filhote.y = display.contentCenterY + display.contentCenterY
--filhote.myName = "filhote"



-- Teste de Sprite

local sheetData = {
	width = 96,
	height = 96,
	numFrames = 96,
	sheetContentWidth = 1152,
	sheetContentHeight = 768 }

local sheetData2 = {
	width = 100,
	height = 100,
	numFrames = 16,
	sheetContentWidth = 400,
	sheetContentHeight = 400 }

local sequenceData = {
	{ name = "normalRun", start = 37, count = 3, time = 4000 },
	{ name = "fastRun", start = 1, count = 96, time = 30000 }
}

-- Sapo
local sapo = graphics.newImageSheet("images/sapo.png", sheetData)
local sapo = display.newSprite( sapo, sequenceData )
sapo.x = display.contentWidth / 2 
sapo.y = display.contentCenterX + 310
--sapo:rotate(270)
sapo.timeScale = 5.0
sapo:setSequence()
sapo:play()
sapo.myName = "filhote"



--[[
-- Tigre
local tigre = graphics.newImageSheet("images/tigre.png", sheetData)
local tigre = display.newSprite( tigre, sequenceData )
tigre.x = sapo.x + 60
tigre.y = display.contentCenterX + 310
--tigre:rotate(270)
tigre.timeScale = 5.0
tigre:setSequence()
tigre:play()

-- Galinha
local galinha = graphics.newImageSheet("images/galinha.png", sheetData)
local galinha = display.newSprite( galinha, sequenceData )
galinha.x = tigre.x + 60
galinha.y = display.contentCenterX + 310
--foca:rotate(270)
galinha.timeScale = 5.0
galinha:setSequence()
galinha:play()

-- Ema
local ema = graphics.newImageSheet("images/ema.png", sheetData)
local ema = display.newSprite( ema, sequenceData )
ema.x = sapo.x - 70
ema.y = display.contentCenterX + 310
--ema:rotate(270)
ema.timeScale = 5.0
ema:setSequence()
ema:play()

-- Foca
local foca = graphics.newImageSheet("images/foca.png", sheetData)
local foca = display.newSprite( foca, sequenceData )
foca.x = sapo.x - 140
foca.y = display.contentCenterX + 310
--ema:rotate(270)
foca.timeScale = 5.0
foca:setSequence()
foca:play()

--]]

-- Guerreiro
--local guerreiro = graphics.newImageSheet("images/guerreiro.png", sheetData2)
--local guerreiro = display.newSprite( guerreiro, sequenceData )
--guerreiro.x = sapo.x
--guerreiro.y = display.contentCenterX + 140
--ema:rotate(270)
--guerreiro.timeScale = 5.0
--guerreiro:setSequence("fastRun")
--guerreiro:play()



-- Tigre Pequeno
--local tigrep = graphics.newImageSheet("images/tigrep.png", sheetData2)
--local tigrep = display.newSprite( tigrep, sequenceData )
--tigrep.x = sapo.x - 70
--tigrep.y = display.contentCenterX + 310
--tigrep:rotate(270)
--tigrep.timeScale = 5.0
--tigrep:setSequence()
--tigrep:play()

-- Protetor
local prot = graphics.newImageSheet("images/protetor.png", sheetData)
local prot = display.newSprite( prot, sequenceData )
prot.x = sapo.x
prot.y = display.contentCenterX + 140
--ema:rotate(270)
prot.timeScale = 5.0
prot:setSequence()
prot:play()
prot.myName = "protetor"


local function updateText()
	pontosText.text = pontos
end



local function scrollView(self, event)
    if self.y > 400 then
    self.y = display.contentCenterY
    else
    self.y = self.y + self.speed
    end
end

--nuvem.enterFrame = scrollView
--nuvem2.enterFrame = scrollView
--Runtime:addEventListener("enterFrame", nuvem)
--Runtime:addEventListener("enterFrame", nuvem2)
--print(display.contentCenterY)

--background.enterFrame = scrollView
background.enterFrame = scrollView
--Runtime:addEventListener("enterFrame", background)
Runtime:addEventListener("enterFrame", background)


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


physics.addBody( prot, "static", {radius=50, bounce = 0.5} )
physics.addBody( sapo, "static", {radius=20, bounce = 0.5} )

local function create()
	-- Monstro
	local obst = graphics.newImageSheet("images/monstros.png", sheetData)
	local obst = display.newSprite( obst, sequenceData )
	obst.x = sapo.x - 140
	obst.y = display.contentCenterX + 310
	--ema:rotate(270)
	obst.timeScale = 5.0
	obst:setSequence("fastRun")
	obst:play()
	obst.myName = "monstro"
    --local obst = display.newImageRect( "images/playerone.png", 40, 40)
    --local obst2 = display.newImageRect( "images/playertwo.png", 40, 40 )
    --obst2.y = display.contentCenterY + 600
    --obst2.x = display.contentCenterX + 600
	--table.insert( asteroidsTable, newAsteroid )
	physics.addBody( obst, "dynamic", { radius=20, bounce=0.2} )
    obst.myName = "obst"
    --physics.addBody( obst2, "dynamic", { radius=20, bounce=0.8} )
    --obst2.myName = "obst"

	local whereFrom = math.random( 3 )
	if ( whereFrom == 1 ) then
		-- From the left
		obst.x = math.random( 500 )
		obst.y = display.contentCenterY - display.contentCenterY 
        obst:setLinearVelocity( math.random( 90,160 ), math.random( 60,160 ) )
        
	elseif ( whereFrom == 2 ) then
		-- From the top
		obst.x = math.random( display.contentWidth )
		obst.y = display.contentCenterY - display.contentCenterY 
		obst:setLinearVelocity( math.random(-40,40), math.random(40,120))
 	elseif (whereFrom == 3) then
 		-- From the right
        obst.x = display.contentWidth + 60
        obst.y = display.contentCenterY - display.contentCenterY 
        obst:setLinearVelocity( math.random(-120,-40), math.random(20,60) )
	end
	--print(display.contentHeight)
	--obst:applyTorque(math.random(-6,6))
end


local function reiniciar()
    display.remove(gameover)
	physics.start()
	pontos = 0
	updateText()
	
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
			
		elseif (obj1.myName == "protetor" and obj2.myName == "filhote"
				or obj2.myName == "protetor" and obj1.myName == "filhote")  then
    --elseif ( event.phase == "ended" ) then
		--print( obj2.myName )
		
			print("empurrao")
		elseif (obj1.myName == "protetor" and obj2.myName == "obst"
		or obj2.myName == "obst" and obj1.myName == "protetor") then
		
		
        	
        	obj2:applyLinearImpulse( 0.5, 0.5 )
			obj2:applyForce( 12, 12, obj2.x, obj2.y )
			pontos = pontos + 1
			updateText()
		end
		print( obj1.myName .. " and " .. obj2.myName )
	end

end


local function gameLoop()
        create()
end

prot:addEventListener( "touch", dragShip )
Runtime:addEventListener( "collision", onCollision )


gameLoopTimer = timer.performWithDelay( 100, gameLoop, 0 )
