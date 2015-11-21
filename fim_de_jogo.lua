-- Inicializar composer/physicss
local composer = require("composer")
local scene = composer.newScene( )
local physics = require("physics")
physics.start()


-- Declarar/Inicializar variáveis/funções
local caminhoDiretorioImagens = "resources/estilo/preto/"
local fimDeJogoTxt
local btnJogarNovamente
local btnIrParaMenu
local distanciaPercorridaTxt
local totalPontosTxt
local totalTsurusSaltadosTxt
local resultadoTxt
local adicionarresultado = {}
local carregarFimDeJogo = {}
local jogarNovamente = {}
local irParaMenu = {}


-- Inicia a cena aqui
function scene:create(event)
  local sceneGroup = self.view
  carregarFimDeJogo()

  resultadoTxt = display.newText('FIM DE JOGO!', display.contentCenterX, display.contentCenterY - 90, "Origram", 20)
  scene.view:insert(resultadoTxt)
end


-- Scene:show
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


-- Scene:hide
function scene:hide(event)
  local sceneGroup = self.view
  local phase = event.phase

  if (phase == "will") then
    -- Chama quando a cena está na cena
  elseif (phase == "did") then
    -- Chama imediatamente quando a cena está fora da tela
  end
end


-- Scene:destroy
function scene:destroy(event)
  local sceneGroup = self.view

--  display.remove(background)
  if (cce) then
    timer.cancel(cce)
    cce = nil
  end
  if (cce2) then
    timer.cancel(cce2)
    cce2 = nil
  end
end


-- Cria grupo(s) para unir elementos da tela
function criarGrupos( )
  grupoGameOver = display.newGroup( )
  scene.view:insert(grupoGameOver)
end

-- Carregar imagens contidas no menu
function carregarFimDeJogo( )
--[[  background = display.newImageRect(caminhoDiretorioImagens .. "fundo.png", display.contentWidth, display.contentHeight)
  background.x = display.contentCenterX
  background.y = display.contentCenterY
  scene.view:insert(background)

  btnJogarNovamente = display.newImage(caminhoDiretorioImagens .. "nova_chance.png")
  btnJogarNovamente.x = display.contentCenterX - 70
  btnJogarNovamente.y = display.contentCenterY + 80
  scene.view:insert(btnJogarNovamente)

  btnIrParaMenu = display.newImage(caminhoDiretorioImagens .. "menu.png")
  btnIrParaMenu.x = display.contentCenterX + 70
  btnIrParaMenu.y = display.contentCenterY + 80
  scene.view:insert(btnIrParaMenu)]]

  totalPontosTxt = display.newText('Pontuação Final: ' .. pontuacao, display.contentCenterX, display.contentCenterY  - 30, "Origram", 20)
  scene.view:insert(totalPontosTxt)

  totalTsurusSaltadosTxt = display.newText('Tsurus Saltados: ' .. totalTsurusSaltados, display.contentCenterX, display.contentCenterY, "Origram", 20)
  scene.view:insert(totalTsurusSaltadosTxt)

  distanciaPercorridaTxt = display.newText('Distância Percorrida: ' .. distancia .. "m", display.contentCenterX, display.contentCenterY + 30 , "Origram", 20)
  scene.view:insert(distanciaPercorridaTxt)


end


-- Configuração de transição entre cenas
local configTransicaoJogoSubMenu = {
	effect = "fade", time = 400
}


-- Função que chama cena para retorno ao jogo
function jogarNovamente( )
  composer.removeScene("fim_de_jogo")
	composer.gotoScene("jogo", configTransicaoJogoSubMenu)
  distancia = 0
  totalTsurusSaltados = 0
end


-- Função que chama cena para retorno ao jogo
function irParaMenu( )
  composer.removeScene("fim_de_jogo")
	composer.gotoScene("menu", configTransicaoJogoSubMenu)
  distancia = 0
  totalTsurusSaltados = 0
end


-- Listener Setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)


return scene
