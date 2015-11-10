--------------------------------------------------------------------------------
-- Inicializar composer/physicss
--------------------------------------------------------------------------------
local composer = require("composer")
local scene = composer.newScene( )
local physics = require("physics")
--physics.setDrawMode("hybrid")
physics.start()
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Declarar/Inicializar variáveis/funções
--------------------------------------------------------------------------------
local diretorioImagens = "resources/estilo/preto/"
local gameOverTxt
local btnJogarNovamente
local btnIrParaMenu
local distanciaPercorridaTxt
local resultadoTxt
local adicionarresultado = {}
local carregarFimDeJogo = {}
local jogarNovamente = {}
local irParaMenu = {}
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Inicia a cena aqui
-- Ex:adicionar objetos display para "sceneGroup", adicionar touch Listeners,etc
--------------------------------------------------------------------------------
function scene:create(event)
  local sceneGroup = self.view
  carregarFimDeJogo()
--[[  calcularresultado()
  criarGrupos()]]

  resultadoTxt = display.newText('FIM DE JOGO ', display.contentCenterX, display.contentCenterY - 90, native.systemFontBold, 20)
  scene.view:insert(resultadoTxt)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Scene:show
--------------------------------------------------------------------------------
function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase

  composer.removeScene("jogo")

  if (phase == "will") then
    -- Chama quando a cena está fora da tela
  elseif (phase == "did") then
    btnJogarNovamente:addEventListener("touch", jogarNovamente)
    btnIrParaMenu:addEventListener("touch", irParaMenu)
  end
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Scene:hide
--------------------------------------------------------------------------------
function scene:hide(event)
  local sceneGroup = self.view
  local phase = event.phase

  if (phase == "will") then
    -- Chama quando a cena está na cena
    -- Inserir código para "pausar" a cena
    -- Ex: stop timers, stop animation, stop audio, etc
  elseif (phase == "did") then
    --gameOver()
    -- Chama imediatamente quando a cena está fora da tela
  end
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Scene:destroy
--------------------------------------------------------------------------------
function scene:destroy(event)
  local sceneGroup = self.view

  display.remove(background)
  if (cce) then
    timer.cancel(cce)
    cce = nil
  end
  if (cce2) then
    timer.cancel(cce2)
    cce2 = nil
  end
  --display.remove(gameOverTxt)
  -- Chamado antes da remoção de vista da cena ("sceneGroup")
  -- Código para "limpar" a cena
  -- ex: remover obejtos display, save state, cancelar transições e etc
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Cria grupo(s) para unir elementos da tela
--------------------------------------------------------------------------------
function criarGrupos( )
  grupoGameOver = display.newGroup( )
  --scene.view:insert(grupoFoguete)
  scene.view:insert(grupoGameOver)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Carregar imagens contidas no menu
--------------------------------------------------------------------------------
function carregarFimDeJogo( )
  background = display.newImageRect(diretorioImagens .. "fundo.png", display.contentWidth, display.contentHeight)
  background.x = display.contentCenterX
  background.y = display.contentCenterY
  scene.view:insert(background)

  btnJogarNovamente = display.newImage(diretorioImagens .. "nova_chance.png")
  btnJogarNovamente.x = display.contentCenterX - 70
  btnJogarNovamente.y = display.contentCenterY + 80
  scene.view:insert(btnJogarNovamente)

  btnIrParaMenu = display.newImage(diretorioImagens .. "menu.png")
  btnIrParaMenu.x = display.contentCenterX + 70
  btnIrParaMenu.y = display.contentCenterY + 80
  scene.view:insert(btnIrParaMenu)

  distanciaPercorridaTxt = display.newText('Distância Percorrida: ' .. distance .. "m", display.contentCenterX, display.contentCenterY - 20, native.systemFontBold, 20)
  scene.view:insert(distanciaPercorridaTxt)

  TsurusSaltadosTxt = display.newText('Tsurus Saltados: ' .. tsurusSaltados, display.contentCenterX, display.contentCenterY, native.systemFontBold, 20)
  scene.view:insert(TsurusSaltadosTxt)
end
--------------------------------------------------------------------------------


-- Configuração de transição entre cenas
--------------------------------------------------------------------------------
local configTransicaoJogoSubMenu = {
	effect = "fade", time = 400
}
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Função que chama cena para retorno ao jogo
--------------------------------------------------------------------------------
function jogarNovamente( )
  composer.removeScene("fim_de_jogo")
	composer.gotoScene("jogo", configTransicaoJogoSubMenu)
  distancia = 0
  tsurusSaltados = 0
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Função que chama cena para retorno ao jogo
--------------------------------------------------------------------------------
function irParaMenu( )
  composer.removeScene("fim_de_jogo")
	composer.gotoScene("menu", configTransicaoJogoSubMenu)
  distancia = 0
  tsurusSaltados = 0
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Listener Setup
--------------------------------------------------------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
--------------------------------------------------------------------------------

return scene
