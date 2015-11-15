-- Inicializar composer/physicss
local composer = require("composer")
local scene = composer.newScene( )
local physics = require("physics")
physics.start()


-- Declarar/Inicializar variáveis/funções
local caminhoDiretorioImagens = "resources/estilo/preto/"
local cce
local cce2
local btRetornarMenu
local creditosTxt
local carregarCreditos = {}
local criarGrupos = {}
local retornarSubMenu = {}


-- Inicia a cena aqui
function scene:create(event)
  local sceneGroup = self.view
  carregarCreditos()
end


-- Scene:show
function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase

  composer.removeScene("menu")

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
  display.remove(background)
end


-- Cria grupo(s) para unir elementos da tela
function criarGrupos( )
  grupoCreditos = display.newGroup( )
  scene.view:insert(grupoCreditos)
end


-- Carregar imagens contidas no menu
function carregarCreditos( )
  background = display.newImageRect(caminhoDiretorioImagens .. "fundo.png", display.contentWidth, display.contentHeight)
  background.x = display.contentCenterX
  background.y = display.contentCenterY
  scene.view:insert(background)

  creditosTxt = display.newText("CRÉDITOS", display.contentCenterX, display.contentCenterY - 90, native.systemFontBold, 20)
  scene.view:insert(creditosTxt)

  creditosTxt = display.newText("Desenvolvido por:", display.contentCenterX, display.contentCenterY - 30, native.systemFontBold, 15)
  scene.view:insert(creditosTxt)

  creditosTxt = display.newText("Gabriel Araújo", display.contentCenterX, display.contentCenterY, native.systemFontBold, 20)
  scene.view:insert(creditosTxt)

  btnVoltar = display.newImage(caminhoDiretorioImagens .. "voltar.png")
  btnVoltar.x = display.contentCenterX
  btnVoltar.y = display.contentCenterY + 80
  scene.view:insert(btnVoltar)
end


-- Configuração de transição entre cenas
local transicaoSubMenuConfig = {
	effect = "fade", time = 550
}


-- Função que chama cena para retorno ao jogo
function voltarMenu( )
  composer.removeScene("creditos")
	composer.gotoScene("menu", transicaoSubMenuConfig)
end


-- Listener Setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)


return scene
