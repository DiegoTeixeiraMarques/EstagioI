local physics = require("physics")
physics.start()
physics.setGravity( 0, 0)
xTela = display.contentCenterX
yTela = display.contentCenterY
tamTela = display.contentHeight
larTela = display.contentWidth
backGroup = display.newGroup()
buttonGroup = display.newGroup()

local largura = 1.3 -- Espaço entre o player e as bordas da tela

print(xTela, yTela, tamTela, larTela)
display.setStatusBar(display.HiddenStatusBar)



-- Definição de background
background = display.newImageRect( backGroup, "images/fundog.png", 1505, 1506 )
background.x = display.contentCenterX
background.y = display.contentCenterY
background.myName = "background"




-- Sprite -------------------------------------------------
local sheetData={width=96, height=96, numFrames=96, sheetContentWidth=1152, sheetContentHeight=768 }  -- Máscara para sprite

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

local player = display.newSprite(sheet, sequenceData)
player.x = xTela
player.y = yTela

player:setSequence("idleUp")





------------------------------------------------------------





-- Atribuindo botões -------------------------------------------------------------------------------

local passosX = 0
local passosY = 0
local velocity = 3


local buttons = {}
buttons[1] = display.newImageRect( "images/botao.png", tamTela*12/100, larTela*12/100) -- Cima
buttons[1].x = xTela / 2 
buttons[1].y = yTela * 2 - 70
buttons[1].rotation = - 90
buttons[1].myName = "up"


buttons[2] = display.newImageRect( "images/botao.png", tamTela*12/100, larTela*12/100) -- Baixo
buttons[2].x = buttons[1].x
buttons[2].y = buttons[1].y + 80
buttons[2].rotation = 90
buttons[2].myName = "down"


buttons[3] = display.newImageRect("images/botao.png", tamTela*12/100, larTela*12/100) -- Esquerda
buttons[3].x = buttons[1].x - 50
buttons[3].y = buttons[1].y + 40
buttons[3].rotation = 180
buttons[3].myName = "left"


buttons[4] = display.newImageRect( "images/botao.png", tamTela*12/100, larTela*12/100) -- Direita
buttons[4].x = buttons[3].x + 100
buttons[4].y = buttons[3].y
buttons[4].myName = "right"


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

    if player.x <= player.width * largura then
        player.x = player.width * largura
        background.x =  background.x - passosX
         
    elseif player.x >= larTela - player.width * largura then
        player.x = larTela - player.width * largura
        background.x =  background.x - passosX
    
    end

    if player.y <= player.height * largura then
        player.y = player.height * largura
        background.y = background.y - passosY
        
    elseif player.y >= tamTela - player.height * largura then
        player.y = tamTela - player.height * largura
        background.y = background.y - passosY
        
    end
    
    --background.x =  background.x - passosX
    --background.y = background.y - passosY

    player:play() -- executa a animação

end

Runtime:addEventListener("enterFrame", update)  -- Enterframe evento disparado o tempo todo









