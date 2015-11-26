-- Inicializar composer/physicss
local composer = require("composer")
local scene = composer.newScene( )
local physics = require("physics")
physics.start()


-- Declarar/Inicializar variáveis/funções
local caminhoDiretorioEstilo = "resources/estilo/"
local fundo
local btRetornarMenu
local creditosTxt
local carregarCreditos = {}


-- Inicia a cena aqui
function scene:create(event)
  local sceneGroup = self.view
  carregarCreditos()
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


-- Cria grupo(s) para unir elementos da tela
function criarGrupos( )
  grupoCreditos = display.newGroup( )
  scene.view:insert(grupoCreditos)
end


-- Carregar imagens contidas no menu
function carregarCreditos( )
  fundo = display.newImageRect(caminhoDiretorioEstilo .. "fundo-telas.png", display.contentWidth, display.contentHeight)
  fundo.x = display.contentCenterX
  fundo.y = display.contentCenterY
  scene.view:insert(fundo)

  creditosTxt = display.newText("créditos", display.contentCenterX, display.contentCenterY - 150, "Origram", 40)
  scene.view:insert(creditosTxt)

  creditosTxt = display.newText("Desenvolvido por:", display.contentCenterX, display.contentCenterY - 100, "Origram", 18)
  scene.view:insert(creditosTxt)
  creditosTxt = display.newText("Gabriel Araújo", display.contentCenterX, display.contentCenterY - 80, "Origram", 16)
  scene.view:insert(creditosTxt)
  creditosTxt = display.newText("github.com/willgabriel7", display.contentCenterX, display.contentCenterY - 60, "Origram", 14)
  scene.view:insert(creditosTxt)
  creditosTxt = display.newText("gabriel.araujows@gmail.com", display.contentCenterX, display.contentCenterY - 40, "Origram", 14)
  scene.view:insert(creditosTxt)

  creditosTxt = display.newText("Design:", display.contentCenterX, display.contentCenterY - 10, "Origram", 18)
  scene.view:insert(creditosTxt)
  creditosTxt = display.newText("Gabriel Araújo", display.contentCenterX, display.contentCenterY + 10, "Origram", 16)
  scene.view:insert(creditosTxt)

  creditosTxt = display.newText("Recursos Externos:", display.contentCenterX, display.contentCenterY + 40, "Origram", 18)
  scene.view:insert(creditosTxt)
  creditosTxt = display.newText("Corona Labs - coronalabs.com", display.contentCenterX, display.contentCenterY + 60, "Origram", 16)
  scene.view:insert(creditosTxt)
  creditosTxt = display.newText("OpenGameArt - opengameart.org", display.contentCenterX, display.contentCenterY + 80, "Origram", 16)
  scene.view:insert(creditosTxt)
  creditosTxt = display.newText("Origram Font - behance.net/gallery/2818175/ORIGRAM-Free-Font", display.contentCenterX, display.contentCenterY + 100, "Origram", 16)
  scene.view:insert(creditosTxt)

  creditosTxt = display.newText("Em homenagem à Sadako Sasaki", display.contentCenterX, display.contentCenterY + 125, "Origram", 12)
  scene.view:insert(creditosTxt)

--[[  creditosTxt = display.newText("Fonte de Pesquisa:", display.contentCenterX, display.contentCenterY + 90, "Origram", 18)
  scene.view:insert(creditosTxt)
  creditosTxt = display.newText("Corona Labs - coronalabs.com", display.contentCenterX, display.contentCenterY +  110, "Origram", 16)
  scene.view:insert(creditosTxt)]]


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
