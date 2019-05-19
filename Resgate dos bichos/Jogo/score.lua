local composer = require( "composer" ) 	-- importação do composer
local scene = composer.newScene()		-- criação do composer

-- Faz transição para o game-template.lua
local function gotoGame()
	composer.gotoScene("game-template", {time=800, effect="zoomOutInFade"})
end

local function gotoMenu()
	composer.gotoScene("menu", {time=800, effect="crossFade"})
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
	
end

scene:addEventListener( "create", scene )

return scene