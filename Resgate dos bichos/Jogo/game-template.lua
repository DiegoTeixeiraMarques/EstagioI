
local composer = require( "composer" )
local scene = composer.newScene()


local physics = require("physics")
physics.start()
physics.setGravity( 0, 0) 
system.activate("multitouch") 
display.setStatusBar(display.HiddenStatusBar) -- Configurações de jogo
math.randomseed( os.time() )

xTela, yTela, tamTela, larTela = display.contentCenterX, display.contentCenterY, display.contentHeight,display.contentWidth -- Cordenadas da tela
-- Criando grupos
backGroup = display.newGroup() 
cenarioGroup = display.newGroup()
menuGroup = display.newGroup()
controlesGroup = display.newGroup()

-- Variaveis de jogo
local velocity = 5
local lives = 3
local passosX = 0
local passosY = 0
local qtdChave = 0
local cacadores = {}

-- Qtd de objetos do cenário
local numChave = 7
local numArvore = 60
local numJaula = 7
local numCacador = 50
-- -----------------------------------------------------------

-- Sprite Fantasma -------------------------------------------------
local sheetData={width=48, height=48, numFrames=96 }  -- Máscara para sprite
local sheet = graphics.newImageSheet("images/protetor.png", sheetData)                                -- Pega o sprite completo do personagem, todas as direções de acordo com a máscara
local sequenceData = {
    { name = "right", frames = { 25, 26, 27, 28, 29, 30, 31, 32, 33 }, time = 500, loopCount = 0 },
    { name = "left", frames = { 13, 14, 15, 16, 17, 18, 19, 20, 21 } , time = 500, loopCount = 0 },
    { name = "moveRight", start = 25, count = 9, time = 500, loopCount = 0 },
    { name = "moveDown", start = 13, count = 9, time = 500, loopCount = 0 },
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

-- Criando cenário
local function criarCercado()
    -- em cima
    for i = 1, 38, 1 do
        cerca = display.newImageRect( backGroup, "images/cerca.png", 60, 60 )
        cerca.x, cerca.y, cerca.myName = leftX + i * 65 , upY, "cerca"
        physics.addBody( cerca, "static", {radius=30, bounce = 20, density = 20} )
        table.insert(bosque, cerca)
    end
    -- lado esquerdo
    for i = 1, 38, 1 do
        cerca = display.newImageRect( backGroup, "images/cerca.png", 60, 60 )
        cerca.x, cerca.y, cerca.myName = leftX, upY + i * 65, "cerca"
        physics.addBody( cerca, "static", {radius=50, bounce = 20, density = 20} )
        table.insert(bosque, cerca)
    end
    -- em baixo
    for i = 1, 38, 1 do
        cerca = display.newImageRect( backGroup, "images/cerca.png", 60, 60 )
        cerca.x, cerca.y, cerca.myName = leftX + i * 65 , downY, "cerca"
        physics.addBody( cerca, "static", {radius=50, bounce = 20, density = 20} )
        table.insert(bosque, cerca)
    end
    -- lado direito
    for i = 1, 38, 1 do
        cerca = display.newImageRect( backGroup, "images/cerca.png", 60, 60 )
        cerca.x, cerca.y, cerca.myName = rightX, upY + i * 65, "cerca"
        physics.addBody( cerca, "static", {radius=50, bounce = 20, density = 20} )
        table.insert(bosque, cerca)
    end
end

-- Gerar numero randomico para representar a posição do objeto no campo de jogo
local function gerarNumero()
    local X = math.random( leftX, rightX )
    local Y = math.random( upY, downY )
    return X, Y
end

-- Validar se a posição do campo de jogo gerada nao tem outro objeto que ocupa
local function validacao(X, Y)
    local valid = true
    for j = 1,  #bosque, 1 do
        
        if (X <= bosque[j].x + bosque[j].width) and (X >= bosque[j].x - bosque[j].width)
            and (Y <= bosque[j].y + bosque[j].height) and (Y >= bosque[j].y - bosque[j].height) then
            valid = false
        end
    end
    return valid
end

local function gerarArvore()
    local qtd = 1
    while qtd <= numArvore do    
        X, Y = gerarNumero()
        valid = validacao(X, Y)
    
        if valid then
            arvore = display.newImageRect( backGroup, "images/arvore2.png", 146, 160 )
            arvore.x, arvore.y, arvore.myName = X, Y, "arvore"
            physics.addBody( arvore, "static", {radius=40, bounce = 20, density = 20} )
            table.insert(bosque, arvore)
            qtd = qtd + 1
        end
        
    end

end

local function gerarChave()
    local qtd = 1
    while qtd <= numChave do    
        X, Y = gerarNumero()
        valid = validacao(X, Y)
        if valid then
            chave = display.newImageRect( backGroup, "images/chave.png", 24, 24 )
            chave.x, chave.y, chave.myName = X, Y, "chave"
            physics.addBody( chave, "static", {radius=5, bounce = 20, density = -1} )
            table.insert(bosque, chave)
            qtd = qtd + 1
        end
    end
end

local function gerarJaula()
    local qtd = 1
    while qtd <= numJaula do    
        X, Y = gerarNumero()
        valid = validacao(X, Y)
        if valid then
            jaula = display.newImageRect( backGroup, "images/jaula.png", 50, 50 )
            jaula.x, jaula.y, jaula.myName = X, Y, "jaula"
            physics.addBody( jaula, "static", {radius=18, bounce = 20, density = 5} )
            table.insert(bosque, jaula)
            qtd = qtd + 1
        end
    end
end

local function gerarCacador()
    local qtd = 1
    while qtd <= numCacador do    
        X, Y = gerarNumero()
        valid = validacao(X, Y)
        if valid then
            cacador = display.newSprite(sheet, sequenceData)
            cacador.x, cacador.y, cacador.myName = X, Y, "cacador"
            local H = math.random( 1, 2 )
            local lado = {"right", "left"}
            cacador:setSequence(lado[H])
            cacador:play()
            backGroup:insert(cacador)
            physics.addBody( cacador, "dynamic", {radius=15, bounce = 5} )
            qtd = qtd + 1
            -- adiciona cacadores a uma tabela para movimenta-los
            table.insert(cacadores, cacador)
        end
    end
end

local function pegarChave()
    qtdChave = qtdChave + 1
    chaveText.text = "chaves: " .. qtdChave
    player.chave = true
end

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

-- Chamada após o gameOver
function endGame()	
    -- Redireciona para tela de menu
    Runtime:removeEventListener( "enterFrame", update )
    Runtime:removeEventListener( "collision", onCollision )
    physics.pause()
    audio.stop( trilhasonora )
    composer.removeScene("game")								
    composer.gotoScene("menu", { time=800, effect="crossFade" } )					
end

-- Movimentação de cenário ------------------------------------------------
local update = function()
    x , y = player:localToContent(0 , 0)
    player.x = player.x + passosX
    player.y = player.y + passosY
    x, y = display.contentCenterX - x, display.contentCenterY - y
    backGroup.x, backGroup.y = backGroup.x + x, backGroup.y + y
    player:play() -- executa a animação do personagem principal

    
    for j = 1,  #cacadores, 1 do
        local H = math.random( 1, 4 )
        if H == 1 then
            for i = 1, 30, 1 do
                cacadores[j].x = cacadores[j].x - 0.5
            end
        --elseif H == 2 then
            --for i = 1, 10, 1 do 
           --     cacadores[j].y = cacadores[j].y - 0.5
           -- end
        
        elseif H == 3 then
            for i = 1, 30, 1 do
                cacadores[j].x = cacadores[j].x + 0.5
            end
       --elseif H == 4 then
         --   for i = 1, 38, 1 do
          --      cacadores[j].y = cacadores[j].y + 0.5
          --  end
            
        end 
    end

    -- Decrement the number of seconds
    secondsLeft = secondsLeft - 1
    -- Time is tracked in seconds; convert it to minutes and seconds
    local minutes = math.floor( secondsLeft / 60 )
    -- Make it a formatted string
    local timeDisplay = string.format( "%02d", minutes )
    -- Update the text object
    clockText.text = timeDisplay

    if lives <= 0 then
        --msg = display.newText(sceneGroup, "Game Over", xTela , yTela, native.systemFont, 52)
        endGame()
    end
end


-- Colisões ----------------------------------------------------------------
local function onCollision(event)
    obj1 = event.object1 
    obj2 = event.object2
    print("Colisão inicial: " .. obj1.myName .. " e " .. obj2.myName)
    if ( event.phase == "began" ) then

        -- Colisão Player e Chave
        if (obj1.myName == "joe" and obj2.myName == "chave") then

            if obj1.chave == true then
                --msg.text = "Você já tem uma chave, libere uma jaula!", xTela , yTela, native.systemFont, 24)
                --transition.to(msg, { time=1500 })
            elseif obj1.chave == false then
                pegarChave()
                obj2:removeSelf()
            end
        
        elseif (obj1.myName == "cacador" and obj2.myName == "arvore" or obj1.myName == "cacador" and obj2.myName == "cerca" ) then
        
        -- Tabela com os movimentos possiveis do caçador
            local H = math.random( 1, 2 )
            local lado = {"right", "left"}
            obj1:setSequence(lado[H])

        elseif (obj1.myName == "joe" and obj2.myName == "cacador" or obj1.myName == "cacador" and obj2.myName == "joe" ) then
            -- Perde vida
            lives = lives - 1
            livesText.text = "vidas: " .. lives
    
        elseif (obj1.myName == "joe" and obj2.myName == "jaula" or obj1.myName == "jaula" and obj2.myName == "joe" ) then
            --display.remove(msg)
            if obj1.chave == true then
                obj2:removeSelf()
                player.chave = false
                numJaula = numJaula - 1
                if numJaula <= 0 then
                    local msg = display.newText("PARABENS, VOCE LIBEROU TODOS OS ANIMAIS!", xTela , yTela, "Mario-Kart-DS", 24)
                end
            end
        end
    end
end

function menuStatus(e)
    -- Fase final
    if e.phase == "began" then
        -- Se a tela estiver fora de visibilidade, recoloque ela na parte superior da tela do dispositivo
        if menuGroup.x == 3000 then
            menuGroup.x, menuGroup.y = xTela - xTela, yTela - yTela
            menuGroup:toFront()
        -- Senão coloque ela de uma forma não visivel para o jogador 
        else
            menuGroup.x, menuGroup.y = 3000, 3000
        end        
    end       
end

-- ##########################################

-- create()
function scene:create( event )

    local sceneGroup = self.view
    
    background = display.newImageRect( backGroup, "images/fundog.png", 3000, 3000 ) -- Definição de background
    background.x, background.y, background.myName = xTela, yTela, "background"
    menu = display.newImageRect(menuGroup, "images/menu2.png", tamTela * 2.5, 500)
    menu.x, menu.y = xTela, yTela - 55

    -- Atribuindo botões -------------------------------------------------------------------------------
    local buttons = {}
    buttons[1] = display.newImageRect( controlesGroup, "images/botao.png", 60, 50) -- Cima
    buttons[1].x, buttons[1].y, buttons[1].rotation, buttons[1].myName = xTela / 2  - 70, yTela * 2 - 115, - 90, "up"
    buttons[2] = display.newImageRect( controlesGroup, "images/botao.png", 60, 50) -- Baixo
    buttons[2].x, buttons[2].y, buttons[2].rotation, buttons[2].myName  = buttons[1].x, buttons[1].y + 80, 90, "down"
    buttons[3] = display.newImageRect( controlesGroup, "images/botao.png", 60, 50) -- Esquerda
    buttons[3].x, buttons[3].y, buttons[3].rotation, buttons[3].myName  = buttons[1].x - 50, buttons[1].y + 40, 180, "left"
    buttons[4] = display.newImageRect( controlesGroup, "images/botao.png", 60, 50) -- Direita
    buttons[4].x, buttons[4].y, buttons[4].myName = buttons[3].x + 100, buttons[3].y, "right"
    bolha = display.newImageRect(controlesGroup, "images/bolha.png", 80, 80 )
    bolha.x, bolha.y, bolha.myName = buttons[1].x + tamTela + 90, buttons[2].y - 30, "bolha"
    ----------------------------------------------------------------------------------------------------

     -- Cronometro contagem regressiva
     secondsLeft = 30000  -- 10 minutes * 60 seconds
     livesText = display.newText( menuGroup, "vidas: " .. lives, xTela - 180, yTela / 4 - 10, "Mario-Kart-DS", 36)
     chaveText = display.newText( menuGroup, "chaves: " .. qtdChave, xTela + 180, yTela / 4 - 10, "Mario-Kart-DS", 36)
     clockText = display.newText( menuGroup, "500", xTela, yTela / 4 - 10, "Mario-Kart-DS", 36 )

    -- Atribuindo os grupos
    cenarioGroup:insert(backGroup)
    sceneGroup:insert(backGroup)
    sceneGroup:insert(cenarioGroup)
    sceneGroup:insert(menuGroup)
    sceneGroup:insert(controlesGroup)

    -- Definindo som de fundo
    audio.setVolume( 0.3, { channel=1 } )
    trilhasonora = audio.loadSound( "audio/The Superiority.mp3" )
    audio.play(trilhasonora)

    -- Joe
    player = display.newSprite(sheet2, sequenceData2)
    player.x, player.y, player.myName = xTela, yTela, "joe"
    player:setSequence("idleDown")
    backGroup:insert(player)
    physics.addBody( player, "dynamic", {radius=18, bounce = 20} )
    player.chave = false

    leftX = xTela - background.width / 2 + 146 * 1.5
    rightX = xTela + background.width / 2 - 146 * 1.5
    upY = yTela - background.height / 2 + 160 * 1.5
    downY = yTela + background.height / 2 - 160 * 1.5
    bosque = {}

   
 
    -- Funcionalidades botoes
    buttons[1]:addEventListener("touch", touchFunction)
    buttons[2]:addEventListener("touch", touchFunction)
    buttons[3]:addEventListener("touch", touchFunction)
    buttons[4]:addEventListener("touch", touchFunction)

    criarCercado()
    gerarArvore()
    gerarChave()
    gerarJaula()
    gerarCacador()

    bolha:addEventListener("touch", menuStatus)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- #########

    elseif ( phase == "did" ) then
        
        Runtime:addEventListener("enterFrame", update)  -- Enterframe evento disparado o tempo todo
        --Runtime:addEventListener( "enterFrame", movimentoCacador )
        Runtime:addEventListener( "collision", onCollision )

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then
		

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view

end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
