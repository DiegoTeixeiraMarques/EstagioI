local physics = require("physics")
physics.start() physics.setGravity( 0, 0) system.activate("multitouch") display.setStatusBar(display.HiddenStatusBar) -- Configurações de jogo
local easyMeasure = require "plugin.easyMeasure"

xTela, yTela, tamTela, larTela = display.contentCenterX, display.contentCenterY, display.contentHeight,display.contentWidth -- Cordenadas da tela
backGroup = display.newGroup() -- Criando grupos
cenarioGroup = display.newGroup()
cenarioGroup:insert(backGroup) -- Atribuindo os grupos

background = display.newImageRect( backGroup, "images/fundog.png", 2000, 2000 ) -- Definição de background
background.x, background.y, background.myName = xTela, yTela, "background"

-- Definindo som de fundo
audio.setVolume( 0.3, { channel=1 } )
trilhasonora = audio.loadSound( "audio/The Superiority.mp3" )
audio.play(trilhasonora)

local colision = false -- Variável para detecção de colisão
local velocity = 5
local passosX = 0
local passosY = 0

velocityText = display.newText("Velocidade: " .. velocity, xTela, yTela / 4, native.systemFont, 36)

-- Sprite Fantasma -------------------------------------------------
local sheetData={width=48, height=48, numFrames=96 }  -- Máscara para sprite
local sheet = graphics.newImageSheet("images/protetor.png", sheetData)                                -- Pega o sprite completo do personagem, todas as direções de acordo com a máscara
local sequenceData = {
    { name = "idleDown", start = 9, count = 1, time = 0, loopCount = 1 },   -- parado para baixo
    { name = "idleLeft", start = 21, count = 1, time = 0, loopCount = 1 },   -- parado para esquerda
    { name = "idleRight", start = 33, count = 1, time = 0, loopCount = 1 },   -- parado para direita
    { name = "idleUp", start = 45, count = 1, time = 0, loopCount = 1 },   -- parado para cima
    { name = "moveDown", start = 1, count = 8, time = 300, loopCount = 0 },   -- movendo para baixo
    { name = "moveLeft", start = 13, count = 8, time = 300, loopCount = 0 },   -- movendo para esquerda
    { name = "moveRight", start = 25, count = 8, time = 300, loopCount = 0 },   -- movendo para direita
    { name = "moveUp", start = 37, count = 8, time = 300, loopCount = 0 }   -- movendo para cima	
}

-- Sprite Joe -------------------------------------------------
local sheetData2={width=47, height=48, numFrames=12} --sheetContentWidth=610, sheetContentHeight=825 }  -- Máscara para sprite
local sheet2 = graphics.newImageSheet("images/joepngp.png", sheetData2)                                -- Pega o sprite completo do personagem, todas as direções de acordo com a máscara
local sequenceData2 = {
    { name = "idleDown", start = 10, count = 1, time = 0, loopCount = 1 },   -- parado para baixo
    { name = "idleLeft", start = 1, count = 1, time = 0, loopCount = 1 },   -- parado para esquerda
    { name = "idleRight", start = 4, count = 1, time = 0, loopCount = 1 },   -- parado para direita
    { name = "idleUp", start = 7, count = 1, time = 0, loopCount = 1 },   -- parado para cima
    { name = "moveDown", start = 11, count = 2, time = 300, loopCount = 0 },   -- movendo para baixo
    { name = "moveLeft", start = 1, count = 3, time = 300, loopCount = 0 },   -- movendo para esquerda
    { name = "moveRight", start = 4, count = 3, time = 300, loopCount = 0 },   -- movendo para direita
    { name = "moveUp", start = 8, count = 2, time = 300, loopCount = 0 }   -- movendo para cima	
}

-- Joe

local player = display.newSprite(sheet2, sequenceData2)
player.x, player.y, player.myName = xTela, yTela, "player"
player:setSequence("idleDown")
backGroup:insert(player)
physics.addBody( player, "dynamic", {radius=40, bounce = 20} )


-- Jogador
--[[
local player = display.newSprite(sheet, sequenceData)
player.x, player.y, player.myName = xTela, yTela, "player"
player:setSequence("idleDown")
backGroup:insert(player)
physics.addBody( player, "dynamic", {radius=40, bounce = 20} )
--]]
-- Criação da árvore
for i = 2, 10, 2 do
    -- Criação da árvore
    arvore = display.newImageRect( backGroup, "images/arvore2.png", 146, 160 )
    arvore.x, arvore.y, arvore.myName = xTela + i * 100, yTela + 250, "arvore"
    physics.addBody( arvore, "static", {radius=50, bounce = 20, density = 20} )
end

for i = 2, 10, 2 do
    -- Criação da árvore
    arvore = display.newImageRect( backGroup, "images/arvore2.png", 146, 160 )
    arvore.x, arvore.y, arvore.myName = xTela + i * 100, yTela + 500, "arvore"
    physics.addBody( arvore, "static", {radius=50, bounce = 20, density = 20} )
end


-- Atribuindo botões -------------------------------------------------------------------------------
local buttons = {}
buttons[1] = display.newImageRect( "images/botao.png", 60, 50) -- Cima
buttons[1].x, buttons[1].y, buttons[1].rotation, buttons[1].myName = xTela / 2  - 70, yTela * 2 - 115, - 90, "up"
buttons[2] = display.newImageRect( "images/botao.png", 60, 50) -- Baixo
buttons[2].x, buttons[2].y, buttons[2].rotation, buttons[2].myName  = buttons[1].x, buttons[1].y + 80, 90, "down"
buttons[3] = display.newImageRect("images/botao.png", 60, 50) -- Esquerda
buttons[3].x, buttons[3].y, buttons[3].rotation, buttons[3].myName  = buttons[1].x - 50, buttons[1].y + 40, 180, "left"
buttons[4] = display.newImageRect( "images/botao.png", 60, 50) -- Direita
buttons[4].x, buttons[4].y, buttons[4].myName = buttons[3].x + 100, buttons[3].y, "right"
bolha = display.newImageRect( "images/bolha.png", 80, 80 )
bolha.x, bolha.y, bolha.myName = buttons[1].x + tamTela + 90, buttons[2].y - 30, "bolha"
----------------------------------------------------------------------------------------------------

-- Ações de toque nos controles --------------------------------------------------------------------
local touchFunction = function(e)
    local eventName = e.phase
    local direction = e.target.myName
    if eventName == "began" or eventName =="moved" then
        if direction == "up" then
            player:setSequence("moveUp")
            passosY = - velocity
            passosX = 0           -- Evita que o personagem ande na diagonal
        elseif direction == "down" then
            player:setSequence("moveDown")
            passosY = velocity
            passosX = 0           -- Evita que o personagem ande na diagonal
        elseif direction == "right" then
            player:setSequence("moveRight")    
            passosX = velocity
            passosY = 0           -- Evita que o personagem ande na diagonal
        elseif direction == "left" then
            player:setSequence("moveLeft")    
            passosX = - velocity
            passosY = 0           -- Evita que o personagem ande na diagonal
        end
    else
    -- Para nao ficar patinando é preciso setar o movimento em que o player está parado e zerar os passos
        if e.target.myName == "up" then
            player:setSequence("idleUp")
        elseif e.target.myName == "down" then
            player:setSequence("idleDown")
        elseif e.target.myName == "right" then
            player:setSequence("idleRight")
        elseif e.target.myName == "left" then
            player:setSequence("idleLeft")
        end
        passosX = 0
        passosY = 0
    end   
end

buttons[1]:addEventListener("touch", touchFunction)
buttons[2]:addEventListener("touch", touchFunction)
buttons[3]:addEventListener("touch", touchFunction)
buttons[4]:addEventListener("touch", touchFunction)


-- Movimentação de cenário ------------------------------------------------
local update = function()
       
    x , y = player:localToContent(0 , 0)
    player.x = player.x + passosX
    player.y = player.y + passosY
    --backGroup.x = backGroup.x - passosX
    --backGroup.y = backGroup.y - passosY

    --if colision then
        x, y = display.contentCenterX - x, display.contentCenterY - y
		backGroup.x, backGroup.y = backGroup.x + x, backGroup.y + y
    --end
    player:play() -- executa a animação
  
end
----------------------------------------------------------------------------

local function atualizaVelocidade()
    velocityText.text = "Velocidade: " .. velocity
end


-- Colisões ----------------------------------------------------------------
local function onCollision(event)
    obj1 = event.object1 
    obj2 = event.object2
    --colision = true
    --cenarioGroup.x = player.x - 240
    --cenarioGroup.y = player.y - 160
    posicao = obj1:setSequence()
	if ( event.phase == "began" ) then
        print("Colisão inicial: " .. obj1.myName .. " e " .. obj2.myName)
	elseif ( event.phase == "ended" ) then
        print("Colisão final: " .. obj1.myName .. " e " .. obj2.myName)	
	end
    
    print("Encerramento: " .. obj1.myName .. " e " .. obj2.myName)
end

-- DEBUG DE POSIÇÔES
local function limitedocampo(e)
    
    if e.phase == "began" then
        local X, Y = player:localToContent(0, 0)
        print(" ----------------------------------------------- ")
        print("Cenario Grupo X, Y: " .. cenarioGroup.x .. " - " .. cenarioGroup.y)
        print("BackGroup X, Y: " .. backGroup.x .. " - " .. backGroup.y)
        --print("MoveGroup X, Y: " .. moveGroup.x .. " - " .. moveGroup.y)
        print("Background X, Y: " .. background.x .. " - " .. background.y)
        print("Arvore X, Y: " .. arvore.x .. " - " .. arvore.y)
        print("Player X, Y: " .. player.x .. " - " .. player.y)
        print("Local to Content Player X, Y: " .. X .. " - " .. Y)
       
        print("To content PLayer: " .. x .." - " .. y)
        print(" ----------------------------------------------- ")

        velocity = velocity + 1
        
        atualizaVelocidade()
        
    end       
end

bolha:addEventListener("touch", limitedocampo)
Runtime:addEventListener("enterFrame", update)  -- Enterframe evento disparado o tempo todo
Runtime:addEventListener( "collision", onCollision )




--crate1.collision = onLocalCollision
--crate1:addEventListener( "collision" )




