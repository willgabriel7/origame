display.setStatusBar( display.HiddenStatusBar )


-- Configuração de transição para menu
local transicaoInicioConfig = {
	effect = "fade", time = 1600
}


local composer = require ("composer")
composer.gotoScene("jogo", transicaoInicioConfig)


-- Variáveis globais
distancia = 0
totalTsurusSaltados = 0
pontuacao = 0
isJogarNovamente = false
