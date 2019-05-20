local composer = require( "composer" ) 	-- importação do composer
local scene = composer.newScene()		-- criação do composer

-- Faz transição para o game-template.lua
local function gotoGame()
	composer.gotoScene("game-template", {time=800, effect="zoomOutInFade"})
end

local function gotoMenu()
	composer.gotoScene("menu", {time=800, effect="crossFade"})
end

local json = require( "json" )															-- Importando as funcionalidades JSON em LUA
local scoresTable = {}																	-- Tabela que conterá os 10 maiores scores do jogo
local filePath = system.pathForFile( "scores.json", system.DocumentsDirectory )			-- Diretório onde será salvo o arquivo de maiores scores do jogo
																						-- ### CARREGANDO SCORES SALVOS ### --
local function loadScores()																-- Início da função
    local file = io.open( filePath, "r" )												-- Solicita a abertura do arquivo de scores em modo de leitura apenas
    if file then																		-- Verifica se o arquivo existe
		local contents = file:read( "*a" )												-- Despeja o conteúdo do arquivo na variável contents
		io.close( file )																-- Fecha o arquivo scores
        scoresTable = json.decode( contents )											-- Converte o JSON para uma tabela LUA
    end
    if ( scoresTable == nil or #scoresTable == 0 ) then									-- Se o arquivo não existir
        scoresTable = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }									-- Atribua dez valores 0 a variável para representar o que seria as dez maiores pontuações
    end
end

local function saveScores()																-- Início da função
    for i = #scoresTable, 11, -1 do														-- Loop em todos os Scores salvos na tabela de pontuação
        table.remove( scoresTable, i )													-- Removendo pontuações desnecessárias
	end																					
    local file = io.open( filePath, "w" )												-- Abre o arquivo de scores em modo de escrita que permite subescrever o que já existe
    if file then																		-- Se o arquivo estiver aberto
        file:write( json.encode( scoresTable ) )										-- Escreva as pontuações que estão na tabela de scores para o arquivo	
        io.close( file )																-- Fecha o arquivo	
    end																					
end	

-- Criação da cena
function scene:create( event )

    local sceneGroup = self.view
    
	--loadScores()																		-- Carrega as pontuações existentes
	--table.insert( scoresTable, composer.getVariable( "pontuacaoFinal" ) )				-- Insere a pontuação mais recente do jogador na tabela
	pontuacao = composer.getVariable( "pontuacaoFinal")		

	-- Carrega o game-template in back
	composer.loadScene( "game-template" )

	-- Tela menu
	local background = display.newImageRect( sceneGroup, "images/fundog.png", display.contentHeight * 1.8, display.contentWidth / 1.5)
	background.x = display.contentCenterX
    background.y = display.contentCenterY

    tituloText = display.newText("SCORES", display.contentCenterX, display.contentCenterY - 100, "Mario-Kart-DS", 36)
    pontuacaoText = display.newText( pontuacao, display.contentCenterX, display.contentCenterY, "Mario-Kart-DS", 36 )
	
end

scene:addEventListener( "create", scene )

return scene