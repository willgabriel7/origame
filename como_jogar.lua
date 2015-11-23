-- Inicializar composer/physicss
local composer = require("composer")
local scene = composer.newScene( )
local physics = require("physics")
physics.start()


-- Declarar/Inicializar variáveis/funções
local caminhoDiretorioEstilo = "resources/estilo/"
local fundo
local btnRetornarMenu
local comoJogarTxt
local iconeDiferenciacao
local carregarCreditos = {}


-- Inicia a cena aqui
function scene:create(event)
  local sceneGroup = self.view
  carregarComoJogar()
end


-- Scene:show
function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase

  composer.removeScene("jogo")

  if (phase == "will") then
    -- Chama quando a cena está fora da tela
  elseif (phase == "did") then
    btnVoltar:addEventListener("touch", voltarMenu)
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
  display.remove(fundo)
end


-- Carregar imagens contidas no menu
function carregarComoJogar( )
  fundo = display.newImageRect(caminhoDiretorioEstilo .. "fundo-telas.png", display.contentWidth, display.contentHeight)
  fundo.x = display.contentCenterX
  fundo.y = display.contentCenterY
  scene.view:insert(fundo)

  comoJogarTxt = display.newText("Como Jogar", display.contentCenterX, display.contentCenterY - 150, "Origram", 40)
  scene.view:insert(comoJogarTxt)

  comoJogarTxt = display.newText("Você deverá fazer com que Ori salte sobre um dos", display.contentCenterX, display.contentCenterY - 100, "Origram", 18)
  scene.view:insert(comoJogarTxt)

  comoJogarTxt = display.newText("três Tsurus que vem em sua direção, tocando nele.", display.contentCenterX, display.contentCenterY - 80, "Origram", 18)
  scene.view:insert(comoJogarTxt)

  comoJogarTxt = display.newText("Mas fique atento pois o  Tsuru o qual Ori irá saltar", display.contentCenterX, display.contentCenterY - 40, "Origram", 18)
  scene.view:insert(comoJogarTxt)

  comoJogarTxt = display.newText("deve ser dirente do Tsuru onde ori está.", display.contentCenterX, display.contentCenterY - 20, "Origram", 18)
  scene.view:insert(comoJogarTxt)

  comoJogarTxt = display.newText("Essa diferença poderá ser a cor ou forma dos", display.contentCenterX, display.contentCenterY, "Origram", 18)
  scene.view:insert(comoJogarTxt)

  comoJogarTxt = display.newText("Tsurus, que será determinada pelo indicador", display.contentCenterX, display.contentCenterY + 20, "Origram", 18)
  scene.view:insert(comoJogarTxt)

  -- Exibi a regra de difereciação
  iconeDiferenciacao = display.newImageRect(caminhoDiretorioEstilo .. "icone-diferente.png", 30, 20)
  iconeDiferenciacao.x = display.contentCenterX + 207
  iconeDiferenciacao.y = display.contentCenterY + 20
  scene.view:insert(iconeDiferenciacao)

  comoJogarTxt = display.newText("Quanto mais rápido a escolha do Tsuru o qual Ori irá", display.contentCenterX, display.contentCenterY + 60, "Origram", 18)
  scene.view:insert(comoJogarTxt)
  comoJogarTxt = display.newText("saltar mais pontos você ganhará!", display.contentCenterX, display.contentCenterY + 80, "Origram", 18)
  scene.view:insert(comoJogarTxt)

  btnVoltar = display.newImageRect(caminhoDiretorioEstilo .. "botao-voltar.png", 60, 60)
  btnVoltar.x = display.contentCenterX
  btnVoltar.y = display.contentCenterY + 170
  scene.view:insert(btnVoltar)
end


-- Configuração de transição entre cenas
local transicaoSubMenuConfig = {
	effect = "fade", time = 550
}


-- Função que chama cena para retorno ao jogo
function voltarMenu( )
  composer.removeScene("creditos")
	composer.gotoScene("jogo", transicaoSubMenuConfig)
end


-- Listener Setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)


return scene
