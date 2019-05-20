
local composer = require( "composer" ) -- importação do composer
local scene = composer.newScene()      -- criação do composer

local physics = require("physics")     -- Importando bliblioteca physics do Corona
physics.start()                        -- Startando a física no jogo
physics.setGravity( 0, 0)              -- Setando gravidade 0 para evitar que objetos flutuem na tela

system.activate("multitouch")          -- Estabelecendo jogabilidade multitouch para os controles
math.randomseed( os.time() )           -- Estabelecendo o clock do próprio dispositivo para efetuar os cálculos de números randômicos    

-- Cordenadas da tela
xTela = display.contentCenterX         -- Centro da tela eixo X
yTela = display.contentCenterY         -- Centro da tela eixo Y
tamTela = display.contentHeight        -- Tamanho da tela
larTela = display.contentWidth         -- Largura da tela

-- Grupos do jogo
backGroup = display.newGroup()         -- Grupo "back" onde fica o backGround, os caçadores e objetos do jogo
cenarioGroup = display.newGroup()      -- Contém o grupo "back" dentro dele
menuGroup = display.newGroup()         -- Contem as informações do jogo: vidas, tempo, chaves ...
controlesGroup = display.newGroup()    -- Contem os botões de controle do jogo

-- Variáveis de jogo
local velocity = 4                     -- Difine a velocidade do player de jogo
local lives = 3                        -- Quantidade de vidas quando inicia o jogo
local passosX = 0                      -- Variável para controlar a movimentação do player no eixo X
local passosY = 0                      -- Variável para controlar a movimentação do player no eixo Y
local qtdChave = 0                     -- Informa a quantiade de chaves já coletadas no jogo
local cacadores = {}                   -- Tabela para adicionar todos os caçadores gerados e enviar para o arquivo "gerador.lua" fazer a movimentação deles
local tempo = 500
local pontuacao = 0
animal = 0

-- Quantidade de objetos do cenário
local numChave = 7                     -- Quantidade de chaves criadas no início do jogo
local numArvore = 60                   -- Quantidade de árvoes criadas no início do jogo
local numJaula = 7                     -- Quantidade de jaulas criadas no início do jogo
local numCacador = 30                  -- Quantidade de caçadores criados no início do jogo


-- ########


-- Sprite do caçador
local sheetData={width=48, height=48, numFrames=96 }                            -- Máscara para sprite
local sheet = graphics.newImageSheet("images/protetor.png", sheetData)          -- Pega o sprite completo do personagem, todas as direções de acordo com a máscara
local sequenceData = {
    { name = "right", frames = { 25, 26, 27, 28, 29, 30, 31, 32, 33 }, time = 800, loopCount = 0 }, -- Sprite para direita
    { name = "left", frames = { 13, 14, 15, 16, 17, 18, 19, 20, 21 } , time = 800, loopCount = 0 }, -- Sprite para esquerda
    { name = "up", frames = { 37, 38, 39, 40, 41, 42, 43, 44, 45 } , time = 800, loopCount = 0 },   -- Sprite para cima
    { name = "down", frames = { 1, 2, 3, 4, 5, 6, 7, 8, 9 } , time = 800, loopCount = 0 },          -- Sprite para baixo
}

-- Sprite do player
local sheetData2={width=47, height=48, numFrames=12}                            -- Máscara para sprite
local sheet2 = graphics.newImageSheet("images/joepngp.png", sheetData2)         -- Pega o sprite completo do personagem, todas as direções de acordo com a máscara
local sequenceData2 = {
    { name = "idleDown", start = 10, count = 1, time = 0, loopCount = 1 },      -- Parado para baixo
    { name = "idleLeft", start = 1, count = 1, time = 0, loopCount = 1 },       -- Parado para esquerda
    { name = "idleRight", start = 4, count = 1, time = 0, loopCount = 1 },      -- Parado para direita
    { name = "idleUp", start = 7, count = 1, time = 0, loopCount = 1 },         -- Parado para cima
    { name = "moveDown", start = 11, count = 2, time = 300, loopCount = 0 },    -- Movendo para baixo
    { name = "moveLeft", start = 1, count = 3, time = 300, loopCount = 0 },     -- Movendo para esquerda
    { name = "moveRight", start = 4, count = 3, time = 300, loopCount = 0 },    -- Movendo para direita
    { name = "moveUp", start = 8, count = 2, time = 300, loopCount = 0 }        -- Movendo para cima	
}

-- Sprite dos animais
local sequenceData3 = {
    { name = "right", frames = { 25, 26, 27 }, time = 800, loopCount = 0 }, -- Sprite para direita
    { name = "left", frames = { 13, 14, 15 } , time = 800, loopCount = 0 }, -- Sprite para esquerda
    { name = "up", frames = { 37, 38, 39 } , time = 800, loopCount = 0 },   -- Sprite para cima
    { name = "down", frames = { 1, 2, 3 } , time = 800, loopCount = 0 },          -- Sprite para baixo
}

-- Folhas de sprite dos animais
local sheetAraraAzul = graphics.newImageSheet("images/arara-azul.png", sheetData)
local sheetLoboGuara = graphics.newImageSheet("images/lobo-guara.png", sheetData)
local sheetMacacoAranha = graphics.newImageSheet("images/macaco-aranha.png", sheetData)
local sheetOncaPintada = graphics.newImageSheet("images/onça-pintada.png", sheetData)
local sheetGuaruba = graphics.newImageSheet("images/arara-azul.png", sheetData)
local sheetMicoLeaoDourado = graphics.newImageSheet("images/macaco-aranha.png", sheetData)
local sheetTartarugaOliva = graphics.newImageSheet("images/tartaruga-oliva.png", sheetData)


-- ########


-- Gera número randômico para representar a posição do objeto no campo de jogo
local function gerarNumero()
    local X = math.random( leftX, rightX )              -- Gera um número para o eixo X que está compreendido dentro da largura do cenário de jogo
    local Y = math.random( upY, downY )                 -- Gera um número para o eixo Y que está compreendido dentro da altura do cenário de jogo
    return X, Y                                         -- Retorna os dois números gerados de forma randômica
end

-- Valida se a posição gerada para um objeto já está ocupada
local function validacao(X, Y)                                                                              -- Recebe as cordenadas para validação
    local valid = true                                                                                      -- Cria uma variável booleana para retonar um feedback
    for j = 1,  #bosque, 1 do                                                                               -- Percorre a tabela "bosque" e verifica se já tem um objeto na posição X, Y informada
        if (X <= bosque[j].x + bosque[j].width) and (X >= bosque[j].x - bosque[j].width)
            and (Y <= bosque[j].y + bosque[j].height) and (Y >= bosque[j].y - bosque[j].height) then
            valid = false                                                                                   -- Atribui "false" a variável "valid" se a posição X, Y não estiver ocupada
        end
    end
    return valid                                                                                            -- Retorna uma feedback, true: representa posição já ocupada, false: representa posição livre
end

-- Função para coletar a chave após contato
local function pegarChave()
    qtdChave = qtdChave + 1                             -- qtdChave é a variável que acumula a quantidade de chaves já coletadas
    --chaveText.text = "chaves: " .. qtdChave             -- Atualiza a informação no menu de jogo
    player.chave = true                                 -- Atribui uma chvae ao jogador e evita que colete outra até que libere uma jaula
end

-- Perde vida
local function perderVida()

    if lives == 3 then
        core1:removeSelf()
    elseif lives == 2 then
        core2:removeSelf()
    elseif lives == 1 then
        core3:removeSelf()
    end
    
    lives = lives - 1

end

-- Ações de toque nos controles
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
    pontuacao = pontuacao + tempo	
    -- Cria variável acessivel para outra cena
	composer.setVariable( "pontuacaoFinal", pontuacao )		
	-- Redireciona para tela de Scores									
    composer.gotoScene( "score", { time=800, effect="crossFade" } )					
end

-- Função chamada após contato com caçador
local function restorePlayer()
	player.isBodyActive = false
	transition.to(player, {alpha=1, time=1000, 
		onComplete = 
		function()
			player.isBodyActive = true
			died = false
		end})
end

-- Movimentação de cenário
local update = function()
    x , y = player:localToContent(0 , 0)
    player.x = player.x + passosX
    player.y = player.y + passosY
    x, y = display.contentCenterX - x, display.contentCenterY - y
    backGroup.x, backGroup.y = backGroup.x + x, backGroup.y + y
    player:play() -- executa a animação do personagem principal

end

local cronometro = function()
    tempo = tempo - 1
    tempoText.text = tempo

    if tempo <= 0 then
        endgame()
    end
end

-- ########


-- Criando cercado no cenário
local function criarCercado()
    -- Em cima
    for i = 1, 38, 1 do
        cerca = display.newImageRect( backGroup, "images/cerca.png", 60, 60 )
        cerca.x, cerca.y, cerca.myName = leftX + i * 65 , upY, "cerca"
        physics.addBody( cerca, "static", {radius=30, bounce = 20, density = 20} )
        table.insert(bosque, cerca)
    end
    -- Lado esquerdo
    for i = 1, 38, 1 do
        cerca = display.newImageRect( backGroup, "images/cerca.png", 60, 60 )
        cerca.x, cerca.y, cerca.myName = leftX, upY + i * 65, "cerca"
        physics.addBody( cerca, "static", {radius=50, bounce = 20, density = 20} )
        table.insert(bosque, cerca)
    end
    -- Em baixo
    for i = 1, 38, 1 do
        cerca = display.newImageRect( backGroup, "images/cerca.png", 60, 60 )
        cerca.x, cerca.y, cerca.myName = leftX + i * 65 , downY, "cerca"
        physics.addBody( cerca, "static", {radius=50, bounce = 20, density = 20} )
        table.insert(bosque, cerca)
    end
    -- Lado direito
    for i = 1, 38, 1 do
        cerca = display.newImageRect( backGroup, "images/cerca.png", 60, 60 )
        cerca.x, cerca.y, cerca.myName = rightX, upY + i * 65, "cerca"
        physics.addBody( cerca, "static", {radius=50, bounce = 20, density = 20} )
        table.insert(bosque, cerca)
    end
end

-- Cria caçadores no cenário
local function gerarCacador()
    local qtd = 1
    while qtd <= numCacador do    
        X, Y = gerarNumero()
        valid = validacao(X, Y)
        if valid then
            cacador = display.newSprite(sheet, sequenceData)
            cacador.x, cacador.y, cacador.myName = X, Y, "cacador"
            backGroup:insert(cacador)
            physics.addBody( cacador, "dynamic", {radius=15, bounce = 5, density = 50} )
            qtd = qtd + 1
            -- adiciona cacadores a uma tabela para movimentá-los
            table.insert(cacadores, cacador)
        end
    end
end

-- Cria árvores no cenário
local function gerarArvore()
    local qtd = 1                                                                           -- Variável qtd serve para controlar o ponto de parada do loop de criação das árvores
    while qtd <= numArvore do    
        X, Y = gerarNumero()                                                                -- Chama a função para gerar as cordenadas que ficará a árvore
        valid = validacao(X, Y)                                                             -- Valida de as cordenadas geradas estão livres
        if valid then                                                                       -- Se as cordenadas forem validadas com retorno "true" gera a árvore na posição X, Y
            arvore = display.newImageRect( backGroup, "images/arvore2.png", 146, 160 )
            arvore.x, arvore.y, arvore.myName = X, Y, "arvore"
            physics.addBody( arvore, "static", {radius=50, bounce = 20, density = 50} )
            table.insert(bosque, arvore)
            qtd = qtd + 1
        end
    end
end

-- Cria chaves no cenário
local function gerarChave()
    local qtd = 1                                                                          -- Variável qtd serve para controlar o ponto de parada do loop de criação das chaves
    while qtd <= numChave do    
        X, Y = gerarNumero()                                                               -- Chama a função para gerar as cordenadas que ficará a chave
        valid = validacao(X, Y)                                                            -- Valida de as cordenadas geradas estão livres
        if valid then                                                                      -- Se as cordenadas forem validadas com retorno "true" gera a chave na posição X, Y
            chave = display.newImageRect( backGroup, "images/chave.png", 24, 24 )
            chave.x, chave.y, chave.myName = X, Y, "chave"
            physics.addBody( chave, "static", {radius=5, bounce = 20, density = 50} )
            table.insert(bosque, chave)
            qtd = qtd + 1
        end
    end
end

-- Cria jaulas no cenário
local function gerarJaula()
    local qtd = 1
    while qtd <= numJaula do    
        X, Y = gerarNumero()
        valid = validacao(X, Y)
        if valid then
            jaula = display.newImageRect( backGroup, "images/jaula.png", 50, 50 )
            jaula.x, jaula.y, jaula.myName, jaula.number = X, Y, "jaula", qtd
            physics.addBody( jaula, "static", {radius=18, bounce = 20, density = 50} )
            table.insert(bosque, jaula)
            qtd = qtd + 1
        end
    end
end


-- Colisões ----------------------------------------------------------------
local function onCollision(event)
    obj1 = event.object1 
    obj2 = event.object2

    if ( event.phase == "began" ) then

        -- Colisão Player e Chave
        if (obj1.myName == "joe" and obj2.myName == "chave") then

            if obj1.chave == false then
                pegarChave()
                obj2:removeSelf()
            end   

        elseif (obj1.myName == "joe" and obj2.myName == "cacador" or obj1.myName == "cacador" and obj2.myName == "joe" ) then
            
            -- Perde vida
            perderVida()
            player.alpha = 0.3
            timer.performWithDelay( 500, restorePlayer )
            
            if lives <= 0 then
                endGame()
            end
    
        elseif (obj1.myName == "joe" and obj2.myName == "jaula") then
            
            if obj1.chave == true then
                
                if obj2.number == 1 then
                    animal = display.newSprite(sheetAraraAzul, sequenceData3)
                    araraAzul.alpha = 1
                elseif obj2.number == 2 then 
                    animal = display.newSprite(sheetLoboGuara, sequenceData3)
                    loboGuara.alpha = 1
                elseif obj2.number == 3 then 
                    animal = display.newSprite(sheetMacacoAranha, sequenceData3)
                    macacoAranha.alpha = 1
                elseif obj2.number == 4 then 
                    animal = display.newSprite(sheetOncaPintada, sequenceData3)
                    oncaPintada.alpha = 1
                elseif obj2.number == 5 then 
                    animal = display.newSprite(sheetGuaruba, sequenceData3)
                    guaruba.alpha = 1
                elseif obj2.number == 6 then 
                    animal = display.newSprite(sheetMicoLeaoDourado, sequenceData3)
                    micoLeaoDourado.alpha = 1
                elseif obj2.number == 7 then 
                    animal = display.newSprite(sheetTartarugaOliva, sequenceData3)
                    tartarugaOliva.alpha = 1
                end
                   
                animal.x, animal.y = obj2.x, obj2.y
                local H = math.random( 1, 4 )
                local lado = {"right", "left", "up", "down"}
                animal:setSequence(lado[H])
                backGroup:insert(animal)
                animal:play()

                if lado[H] == "right" then
                    transition.to(animal, { time = 3000, delay = 0, x = animal.x + 500, transition = easing.linear, onComplete = function() animal:removeSelf() end})
                elseif lado[H] == "left" then
                    transition.to(animal, { time = 3000, delay = 0, x = animal.x - 500, transition = easing.linear, onComplete = function() animal:removeSelf() end})
                elseif lado[H] == "up" then
                    transition.to(animal, { time = 3000, delay = 0, y = animal.y - 500, transition = easing.linear, onComplete = function() animal:removeSelf() end})
                elseif lado[H] == "down" then
                    transition.to(animal, { time = 3000, delay = 0, y = animal.y + 500, transition = easing.linear, onComplete = function() animal:removeSelf() end})
                end

                obj2:removeSelf()
                player.chave = false
                numJaula = numJaula - 1

                pontuacao = pontuacao + 100  -- Animal liberado = +100 pontos

                if numJaula <= 0 then
                    endgame()
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
    local phase = event.phase

    background = display.newImageRect( backGroup, "images/fundog.png", 3000, 3000 ) -- Definição de background
    background.x, background.y, background.myName = xTela, yTela, "background"
    menu = display.newImageRect(menuGroup, "images/menu2.png", tamTela * 3, 500)
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
      
    -- Criando vidas do menu
    core1 = display.newImageRect(menuGroup, "images/coracao.png", 32, 30)
    core1.x =  xTela - 220
    core1.y = yTela / 4 - 10
    core2 = display.newImageRect(menuGroup, "images/coracao.png", 32, 30)
    core2.x =  xTela - 240
    core2.y = yTela / 4 - 10
    core3 = display.newImageRect(menuGroup, "images/coracao.png", 32, 30)
    core3.x =  xTela - 260
    core3.y = yTela / 4 - 10

    -- Criando animais do menu
    tartarugaOliva = display.newImageRect(menuGroup, "images/tartarugaOliva.png", 50, 50)
    tartarugaOliva.x = xTela - 150
    tartarugaOliva.y = yTela / 4 - 10
    tartarugaOliva.alpha = 0.2
    
    araraAzul = display.newImageRect(menuGroup, "images/araraAzul.png", 50, 50)
    araraAzul.x = xTela - 100
    araraAzul.y = yTela / 4 - 10
    araraAzul.alpha = 0.2

    loboGuara = display.newImageRect(menuGroup, "images/loboGuara.png", 50, 45)
    loboGuara.x = xTela - 50
    loboGuara.y = yTela / 4 - 10
    loboGuara.alpha = 0.2

    macacoAranha = display.newImageRect(menuGroup, "images/macacoAranha.png", 50, 50)
    macacoAranha.x = xTela
    macacoAranha.y = yTela / 4 - 5
    macacoAranha.alpha = 0.2

    oncaPintada = display.newImageRect(menuGroup, "images/oncaPintada.png", 40, 50)
    oncaPintada.x = xTela + 50
    oncaPintada.y = yTela / 4 -10
    oncaPintada.alpha = 0.2

    guaruba = display.newImageRect(menuGroup, "images/guaruba.png", 50, 50)
    guaruba.x = xTela + 100
    guaruba.y = yTela / 4 - 10
    guaruba.alpha = 0.2

    micoLeaoDourado = display.newImageRect(menuGroup, "images/micoLeaoDourado.png", 50, 50)
    micoLeaoDourado.x = xTela + 150
    micoLeaoDourado.y = yTela / 4 - 10
    micoLeaoDourado.alpha = 0.2

    -- Atribuindo os grupos
    cenarioGroup:insert(backGroup)
    sceneGroup:insert(backGroup)
    sceneGroup:insert(cenarioGroup)
    sceneGroup:insert(menuGroup)
    sceneGroup:insert(controlesGroup)

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
    gerarCacador()
    gerarArvore()
    gerarChave()
    gerarJaula()
    trilhasonora = audio.loadSound( "audio/musicBack.mp3" )
    tempoText = display.newText( menuGroup, tempo, xTela + 245, yTela / 4 - 10, "Mario-Kart-DS", 36 )
    
    bolha:addEventListener("touch", menuStatus)

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

    if ( phase == "will" ) then
		-- Definindo som de fundo
        audio.play( trilhasonora, { channel=1, loops=-1 } )	
       
    elseif ( phase == "did" ) then

        Runtime:addEventListener("enterFrame", update)  -- Enterframe evento disparado o tempo todo
        Runtime:addEventListener( "collision", onCollision )
        cronometroJogo = timer.performWithDelay( 1000, cronometro, 0 )

        --Importa o arquivo que faz os caçadores se movimentarem
        movimento = require( "gerador" )

        -- Função importada para movimentar os caçadores
        movimentoCacador(cacadores)
        
        --Evita perder vida logo no início do jogo
        restorePlayer()

	end
end


-- hide()
function scene:hide( event )
	local sceneGroup = self.view
    local phase = event.phase
    if ( phase == "will" ) then
		timer.cancel( cronometroJogo )
	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
        Runtime:removeEventListener( "collision", onCollision )
        Runtime:removeEventListener("enterFrame", update)  -- Enterframe evento disparado o tempo todo
		physics.pause()
		audio.stop( 1 )
        composer.removeScene("game-template")
	end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    
    audio.dispose( trilhasonora )

end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
