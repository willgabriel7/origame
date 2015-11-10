display.setStatusBar( display.HiddenStatusBar )

--------------------------------------------------------------------------------
-- Configuração de transição para menu
--------------------------------------------------------------------------------
local configTransicaoMenu = {
	effect = "fade", time = 1600
}
--------------------------------------------------------------------------------

local composer = require ("composer")
composer.gotoScene("inicio", configTransicaoMenu)


--------------------------------------------------------------------------------
-- Variáveis globais
--------------------------------------------------------------------------------
distance = 0
tsurusSaltados = 0
