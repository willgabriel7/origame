-- Inicializar composer/physicss
local composer = require("composer")
local scene = composer.newScene( )
local physics = require("physics")
physics.start()


-- Declarar/Inicializar variáveis/funções
local caminhoDiretorioEstilo = "resources/estilo/"
local caminhoDiretorioImagens = "resources/images/"
local caminhoDiretorioSom = "resources/sons/"
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

  local somFimDeJogo = audio.loadStream(caminhoDiretorioSom .. "oriental.wav" )
  audio.play(somFimDeJogo, {loops = -1, channel = 1, fadeout=1000})
  audio.setVolume( 0.50 , { channel=1 })
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
  audio.stop(1)
end


-- Carregar imagens contidas no menu
function carregarFimDeJogo( )
  fundo = display.newImageRect(caminhoDiretorioEstilo .. "fundo-telas.png", display.contentWidth, display.contentHeight)
  fundo.x = display.contentCenterX
  fundo.y = display.contentCenterY
  scene.view:insert(fundo)

  btnJogarNovamente = display.newImageRect(caminhoDiretorioEstilo .. "botao-jogar-novamente.png", 60, 60)
  btnJogarNovamente.x = display.contentCenterX - 70
  btnJogarNovamente.y = display.contentCenterY + 170
  scene.view:insert(btnJogarNovamente)

  btnIrParaMenu = display.newImageRect(caminhoDiretorioEstilo .. "botao-menu.png", 60, 60)
  btnIrParaMenu.x = display.contentCenterX + 70
  btnIrParaMenu.y = display.contentCenterY + 170
  scene.view:insert(btnIrParaMenu)

  resultadoTxt = display.newText('Obrigada!', display.contentCenterX, display.contentCenterY - 150, "Origram", 40)
  scene.view:insert(resultadoTxt)

  resultadoTxt = display.newText('Graças a sua ajuda consegui saltar todo o bando de Tsurus e assim chegar', display.contentCenterX, display.contentCenterY - 100, "Origram", 18)
  scene.view:insert(resultadoTxt)

  resultadoTxt = display.newText('a tempo de salvar minha aldeia das Traças devoradoras de papel.', display.contentCenterX, display.contentCenterY - 80, "Origram", 18)
  scene.view:insert(resultadoTxt)

  oriFrente = display.newImageRect(caminhoDiretorioImagens .. "ori-frente.png", 100, 150)
  oriFrente.x = display.contentCenterX
  oriFrente.y = display.contentCenterY + 10
  scene.view:insert(oriFrente)


  totalPontosTxt = display.newText("Pontuação Final:  " .. pontuacao , display.contentCenterX - 200 , display.contentCenterY + 110, "Origram", 16)
  scene.view:insert(totalPontosTxt)

  totalTsurusSaltadosTxt = display.newText("Tsurus Saltados:  " .. totalTsurusSaltados, display.contentCenterX, display.contentCenterY + 110, "Origram", 16)
  scene.view:insert(totalTsurusSaltadosTxt)

  distanciaPercorridaTxt = display.newText("Distância Percorrida: " .. distancia .. "m", display.contentCenterX + 200, display.contentCenterY + 110 , "Origram", 16)
  scene.view:insert(distanciaPercorridaTxt)
end


-- Configuração de transição entre cenas
local transicaoJogarNovamenteConfig = {
	effect = "fade", time = 400,  params = { jogarNovamente = true }
}


-- Função que chama cena para retorno ao jogo
function jogarNovamente()
  isJogarNovamente = true
  pontuacao = 0
  distancia = 0
  totalTsurusSaltados = 0

  composer.removeScene("fim_de_jogo")
	composer.gotoScene("jogo", transicaoJogarNovamenteConfigs)
end


-- Função que chama cena para retorno ao jogo
function irParaMenu()
  composer.removeScene("fim_de_jogo")
  jogarNovamente = false
	composer.gotoScene("jogo", transicaoJogarNovamenteConfig)
--  distancia = 0
--  totalTsurusSaltados = 0
end


-- Listener Setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)


return scene
