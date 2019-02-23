local physics = require("physics")
physics.start()
physics.setGravity( 0, 0)
xTela = display.contentCenterX
yTela = display.contentCenterY
tamTela = display.contentHeight
larTela = display.contentWidth
backGroup = display.newGroup()
buttonGroup = display.newGroup()
personGroup = display.newGroup()

largura = 1.3 -- Espaço entre o player e as bordas da tela

print(xTela, yTela, tamTela, larTela)
display.setStatusBar(display.HiddenStatusBar)



-- Definição de background
background = display.newImageRect( backGroup, "images/fundog.png", 3000, 3000 )
background.x = xTela
background.y = yTela
background.myName = "background"




-- Sprite -------------------------------------------------
local sheetData={width=96, height=96, numFrames=96, sheetContentWidth=1152, sheetContentHeight=768 }  -- Máscara para sprite

-- Player
local sheet = graphics.newImageSheet("images/protetor.png", sheetData)                                -- Pega o sprite completo do personagem, todas as direções de acordo com a máscara

-- Sequencia de movimentos
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

-- Jogador
local player = display.newSprite(sheet, sequenceData)
player.x = xTela
player.y = yTela
player:setSequence("idleDown")
personGroup:insert(player)
--[[
-- Intruso no campo
local intruso = display.newSprite(sheet, sequenceData)
intruso.x = xTela
intruso.y = yTela
intruso:setSequence("idleDown")
intruso.x = xTela
intruso.y = yTela + 100
backGroup:insert(intruso)
--]]
------------------------------------------------------------





-- Atribuindo botões -------------------------------------------------------------------------------

local passosX = 0
local passosY = 0
local velocity = 1


local buttons = {}
buttons[1] = display.newImageRect( "images/botao.png", 60, 50) -- Cima
buttons[1].x = xTela / 2  - 70
buttons[1].y = yTela * 2 - 115
buttons[1].rotation = - 90
buttons[1].myName = "up"


buttons[2] = display.newImageRect( "images/botao.png", 60, 50) -- Baixo
buttons[2].x = buttons[1].x
buttons[2].y = buttons[1].y + 80
buttons[2].rotation = 90
buttons[2].myName = "down"


buttons[3] = display.newImageRect("images/botao.png", 60, 50) -- Esquerda
buttons[3].x = buttons[1].x - 50
buttons[3].y = buttons[1].y + 40
buttons[3].rotation = 180
buttons[3].myName = "left"


buttons[4] = display.newImageRect( "images/botao.png", 60, 50) -- Direita
buttons[4].x = buttons[3].x + 100
buttons[4].y = buttons[3].y
buttons[4].myName = "right"

-- Debug de posição
bolha = display.newImageRect( "images/bolha.png", 80, 80 )
bolha.x = buttons[1].x + tamTela + 90
bolha.y = buttons[2].y - 30
bolha.myName = "bolha"


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

local j = 1
for j=1, #buttons do 
    buttons[j]:addEventListener("touch", touchFunction)
end



local update = function()
    --print(player.width * .5)

    player.x = player.x + passosX
    player.y = player.y + passosY
      
    
    -- Evita que o player saia da tela

    -- Lado esquerdo
    if player.x <= player.width * largura then
        player.x = player.width * largura

        -- Verifica se a tela de jogo chegou ao fim
        if background.x < 1400 then
            background.x =  background.x - passosX
        end

    -- Lado direito
    elseif player.x >= larTela - player.width * largura then
        player.x = larTela - player.width * largura

        -- Verifica se a tela de jogo chegou ao fim
        if background.x > -1100 then
            background.x =  background.x - passosX
        end

    end

    -- Lado superior
    if player.y <= player.height * largura then
        player.y = player.height * largura
        
        -- Verifica se a tela de jogo chegou ao fim
        if background.y < 1400 then
            background.y = background.y - passosY
        end

    -- Lado inferior
    elseif player.y >= tamTela - player.height * largura then
        player.y = tamTela - player.height * largura

        -- Verifica se a tela de jogo chegou ao fim
        if background.y > -900 then
            background.y = background.y - passosY
        end
        
    end
    
    

    --background.x =  background.x - passosX
    --background.y = background.y - passosY

    player:play() -- executa a animação

end

velocityText = display.newText("Velocidade: " .. velocity, xTela, yTela / 4, native.systemFont, 36)

local function limitedocampo(e)
    --print(background.x)
    --print(background.y)
    --background:toBack()
    if e.phase == "began" then

        if velocity < 15 then
            velocity = velocity + 1
        else
            velocity = 1
        end
    end
    velocityText.text = "Velocidade: " .. velocity

end

bolha:addEventListener("touch", limitedocampo)

Runtime:addEventListener("enterFrame", update)  -- Enterframe evento disparado o tempo todo









