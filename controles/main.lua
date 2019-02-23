local physics = require("physics")
physics.start()
physics.setGravity( 0, 0)
system.activate("multitouch")
--system.deactivate () 

xTela = display.contentCenterX
yTela = display.contentCenterY
tamTela = display.contentHeight
larTela = display.contentWidth

-- Criando grupos
backGroup = display.newGroup()
cenarioGroup = display.newGroup()
--moveGroup = display.newGroup()

-- Alinhando os grupos em tela
--backGroup.x = xTela
--backGroup.y = yTela
--cenarioGroup.x = xTela
--cenarioGroup.y = yTela
--moveGroup.x = xTela
--moveGroup.y = yTela

-- Atribuindo os grupos
--backGroup:insert(cenarioGroup)
cenarioGroup:insert(backGroup)
--moveGroup:insert(backGroup)

--moveGroup:insert(personGroup)

largura = 1.3 -- Espaço entre o player e as bordas da tela

print(xTela, yTela, tamTela, larTela)
display.setStatusBar(display.HiddenStatusBar)



-- Definição de background
background = display.newImageRect( backGroup, "images/fundog.png", 2000, 2000 )
background.x = xTela
background.y = yTela
background.myName = "background"
background.x = xTela
background.y = yTela







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
player.x = xTela - 150
player.y = yTela
player:setSequence("idleDown")
player.myName = "player"
cenarioGroup:insert(player)
physics.addBody( player, "dynamic", {radius=50, bounce = 20} )

-- Criação da árvore
arvore = display.newImageRect( backGroup, "images/arvore2.png", 146, 147 )
arvore.x = xTela
arvore.y = yTela
arvore.myName = "arvore"
physics.addBody( arvore, "static", {radius=50, bounce = 20, density = 20} )





-- Atribuindo botões -------------------------------------------------------------------------------

local passosX = 0
local passosY = 0
local velocity = 10


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

-- Debug de posição e controle de velocidade
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

-- Movimentação de cenário ------------------------------------------------

local update = function()
    --print(player.width * .5)

    player.x = player.x + passosX
    player.y = player.y + passosY
    


    --- Teste de tela ----



    -- Lado esquerdo
    if player.x <= player.width and player.y <=player.height then
        backGroup.x =  - player.x
        backGroup.y = - player.y
    end
--[[
    -- Lado direito
    if player.x >= larTela - player.width then
        cenarioGroup.x =  - player.x
    end

     -- Lado superior
     if player.y <= player.height then
        cenarioGroup.y = player.height
    end

    -- Lado inferior
    
    if player.y >= tamTela - player.height then
        cenarioGroup.y = player.height
     
    end
--]]
------------------------ Fim teste -------------------------------------------



    -- Evita que o player saia da tela
    --[[
    -- Lado esquerdo
    if player.x <= player.width * largura then
        player.x = player.width * largura

        -- Verifica se a tela de jogo chegou ao fim
        if backGroup.x < 1400 then
            --moveGroup.x = moveGroup.x - passosX    
            backGroup.x =  backGroup.x - passosX
            --cenarioGroup.x =  cenarioGroup.x - passosX
        end

    -- Lado direito
    elseif player.x >= larTela - player.width * largura then
        player.x = larTela - player.width * largura

        -- Verifica se a tela de jogo chegou ao fim
        if backGroup.x > -900 then
            --moveGroup.x = moveGroup.x - passosX  
            backGroup.x =  backGroup.x - passosX
            --cenarioGroup.x =  cenarioGroup.x - passosX
        end

    end

    -- Lado superior
    if player.y <= player.height * largura then
        player.y = player.height * largura
        
        -- Verifica se a tela de jogo chegou ao fim
        if backGroup.y < 1400 then
            --moveGroup.y = moveGroup.y - passosY  
            backGroup.y = backGroup.y - passosY
            --cenarioGroup.y =  cenarioGroup.y - passosY
            
        end

    -- Lado inferior
    elseif player.y >= tamTela - player.height * largura then
        player.y = tamTela - player.height * largura

        -- Verifica se a tela de jogo chegou ao fim
        if backGroup.y > -900 then
            --moveGroup.y = moveGroup.y - passosY  
            backGroup.y = backGroup.y - passosY
            --cenarioGroup.y =  cenarioGroup.y - passosY
        end
        
    end
    
    --]]

    --background.x =  background.x - passosX
    --background.y = background.y - passosY

    player:play() -- executa a animação

end

------------------------------------------------------------------


-- Colisões --------------------------------------------------------------------------------

local function onCollision(event)
	obj1 = event.object1
	obj2 = event.object2

	if ( event.phase == "began" ) then
        print("Colisão inicial: " .. obj1.myName .. " e " .. obj2.myName)
        obj2:applyForce( 12, 12, obj2.x, obj2.y )

	elseif ( event.phase == "ended" ) then
        print("Colisão final: " .. obj1.myName .. " e " .. obj2.myName)
			
	end

        print("Encerramento: " .. obj1.myName .. " e " .. obj2.myName)
end



--velocityText = display.newText("Velocidade: " .. velocity, xTela, yTela / 4, native.systemFont, 36)

local function limitedocampo(e)
    
    --personGroup:toBack()
    if e.phase == "began" then

        print(" ----------------------------------------------- ")
        print("Cenario Grupo X, Y: " .. cenarioGroup.x .. " - " .. cenarioGroup.y)
        print("BackGroup X, Y: " .. backGroup.x .. " - " .. backGroup.y)
        --print("MoveGroup X, Y: " .. moveGroup.x .. " - " .. moveGroup.y)
        print("Background X, Y: " .. background.x .. " - " .. background.y)
        print("Arvore X, Y: " .. arvore.x .. " - " .. arvore.y)
        print("Player X, Y: " .. player.x .. " - " .. player.y)
        
        

        --print("Arvore X, Y: " .. arvore.x .. " - " .. arvore.y)
        --print("Arvore X, Y: " .. arvore.x .. " - " .. arvore.y)

        print(" ----------------------------------------------- ")

        --[[
        if velocity < 15 then
            velocity = velocity + 1
        else
            velocity = 1
        end
        --]]
    end
        
    --velocityText.text = "Velocidade: " .. velocity
        
end

bolha:addEventListener("touch", limitedocampo)

Runtime:addEventListener("enterFrame", update)  -- Enterframe evento disparado o tempo todo

Runtime:addEventListener( "collision", onCollision )









