local physics = require("physics")
physics.start() physics.setGravity( 0, 0) system.activate("multitouch") display.setStatusBar(display.HiddenStatusBar) -- Configurações de jogo
local easyMeasure = require "plugin.easyMeasure"
math.randomseed( os.time() )

-- Definindo som de fundo
audio.setVolume( 0.3, { channel=1 } )
trilhasonora = audio.loadSound( "audio/The Superiority.mp3" )
audio.play(trilhasonora)

