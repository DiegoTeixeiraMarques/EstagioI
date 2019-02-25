math.randomseed( os.time() )
display.setStatusBar( display.HiddenStatusBar )

-- Variável global
local count = 0
local helloTable = {}
local backgroundverde = display.newImageRect( "backgroundverde.png")

-- Imagens estáticas
local background = display.newImageRect( "background.png", 400, 1000 )
background.x = display.contentCenterX
background.y = display.cotentCenterY
countText = display.newText("QTD: " .. count, display.contentCenterY, display.contentCenterX - 170, native.systemFont, 36)

local push = display.newImageRect( "push.png", 112, 112 )
push.x = display.contentCenterX
push.y = display.contentHeight - 50

-- Iniciando physics e gravidade do espaço
local physics = require("physics")
physics.start()
physics.setGravity( 0, 0 )

-- Atualiza count na tela
local function updateText()
	count = count + 1
	countText.text = "QTD: " .. count
end

-- Cria HelloWorld aleatoriamente na tela
local function createHello()
	updateText()
	local hello = display.newImageRect( "hello.png", 112, 112 )
	table.insert(helloTable, hello)
	physics.addBody( hello, "dynamic", { radius=50, bounce=0.3 } )

	local whereFrom = math.random( 3 )
	if ( whereFrom == 1 ) then
		-- From the left
		hello.x = -60
		hello.y = math.random( 500 )
		hello:setLinearVelocity( math.random( 4,120 ), math.random( 20,60 ) )
	elseif ( whereFrom == 2 ) then
		-- From the top
		hello.x = math.random( display.contentWidth )
		hello.y = -60
		hello:setLinearVelocity( math.random(-40,40), math.random(40,120))
 	elseif (whereFrom == 3) then
 		-- From the right
		hello.x = display.contentWidth + 60
		hello.y = math.random(500)
		hello:setLinearVelocity( math.random(-120,-40), math.random(20,60) )
	end

	hello:applyTorque(math.random(-6,6))

	if (count >= 10) then
		background = display.newImageRect( "backgroundverde.png", 800, 1000 )
		count = 0
	end
end

push:addEventListener( "tap", createHello)