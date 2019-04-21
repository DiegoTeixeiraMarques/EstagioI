local composer = require( "composer" ) 	-- importação do composer
local scene = composer.newScene()		-- criação do composer

-- Faz transição para o game.lua
local function gotoGame()
	composer.gotoScene("game-template", {time=800, effect="crossFade"})
end

-- Criação da cena
function scene:create( event )
	local sceneGroup = self.view
	
	-- Tela menu
	local background = display.newImageRect( sceneGroup, "images/menu_tela.png", display.contentHeight * 1.8,display.contentWidth / 1.5)
	background.x = display.contentCenterX
    background.y = display.contentCenterY

	-- Botões menu
    local botaoJogar = display.newImageRect( sceneGroup, "images/botao_jogar.png", 250, 125)
    botaoJogar.x = display.contentCenterX + 50
	botaoJogar.y = display.contentCenterY - 100
	
	local botaoNivel = display.newImageRect( sceneGroup, "images/botao_nivel.png", 250, 125)
    botaoNivel.x = botaoJogar.x + 10
	botaoNivel.y = botaoJogar.y + 90
	
	local botaoScores = display.newImageRect( sceneGroup, "images/botao_scores.png", 250, 125)
    botaoScores.x = botaoJogar.x + 15
    botaoScores.y = botaoJogar.y + 180 


	-- Funcionalidades dos botões
	botaoJogar:addEventListener("tap", gotoGame)
	--botaoNivel:addEventListener("tap", gotoNivel)
	--botaoScores:addEventListener("tap", gotoScores)
end


-- show()
function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	if ( phase == "will" ) then
		-- ######### 
	elseif ( phase == "did" ) then
		-- #########
	end
end

-- hide()
function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	if ( phase == "will" ) then
		-- #########
	elseif ( phase == "did" ) then
		-- #########
	end
end

-- destroy()
function scene:destroy( event )
	local sceneGroup = self.view
	-- #########
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene