local composer = require( "composer" ) 	-- importação do composer
local scene = composer.newScene()		-- criação do composer

-- Faz transição para o game-template.lua
local function gotoGame()
	composer.gotoScene("game-template", {time=800, effect="zoomOutInFade"})
end

-- Criação da cena
function scene:create( event )

	local sceneGroup = self.view

	-- Carrega o game-template in back
	composer.loadScene( "game-template" )

	-- Tela menu
	local background = display.newImageRect( sceneGroup, "images/menu_tela.png", display.contentHeight * 1.8, display.contentWidth / 1.5)
	background.x = display.contentCenterX
    background.y = display.contentCenterY

	-- Botões menu
    local botaoJogar = display.newImageRect( sceneGroup, "images/botao_jogar.png", 477 / 2, 165 / 2)
    botaoJogar.x = display.contentCenterX + 60
	botaoJogar.y = display.contentCenterY - 70

	local botaoScores = display.newImageRect( sceneGroup, "images/botao_scores.png", 477 / 2, 165 / 2)
    botaoScores.x = display.contentCenterX + 60
	botaoScores.y = display.contentCenterY + 50


	-- Funcionalidades dos botões
	botaoJogar:addEventListener("tap", gotoGame)
	
end

scene:addEventListener( "create", scene )

return scene