local composer = require("composer")

-- Desabilita a barra de Status
display.setStatusBar(display.HiddenStatusBar)

-- Reserve channel 1 para música de fundo
audio.reserveChannels( 1, 2 )

-- Intensidade do volume do som
audio.setVolume( 0.5, { channel = 1, 2 } )

-- Vai para o menu
composer.gotoScene("menu", {time=800, effect="crossFade"})