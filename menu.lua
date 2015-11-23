-- Inicializar composer
local composer = require("composer")
local scene = composer.newScene()


-- Declarar/Inicializar variáveis/funções
local diretorioImagens = "resources/estilo/preto/"
local btnJogar
local btnCreditos
local btnSair
local jogar = {}
local creditos = {}
local carregarMenu = {}
local fecharApp = {}


-- Inicia a cena aqui
function scene:create(event)
  local sceneGroup = self.view
  carregarMenu()
end


-- Scene:show
function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase

  composer.removeScene("inicio")
  composer.removeScene("jogo")
  composer.removeScene("regras")

  if (phase == "will") then
    -- Chama quando a cena está fora da tela
  elseif (phase == "did") then
    btnJogar:addEventListener("touch", jogar)
    btnCreditos:addEventListener("touch", creditos)
    btnSair:addEventListener("touch", fecharApp)
  end
end


-- Scene:hide
function scene:hide(event)
  local sceneGroup = self.view
  local phase = event.phase

  if (phase == "will") then
    -- Chama quando a cena está na cena
    -- Inserir código para "pausar" a cena
    -- Ex: stop timers, stop animation, stop audio, etc
  elseif (phase == "did") then
    -- Chama imediatamente quando a cena está fora da tela
  end
end


-- Chamado quando cena atual é removida
function scene:destroy(event)
  local sceneGroup = self.view
  display.remove(fundo)
end


-- Carregar imagens contidas no menu
function carregarMenu( )
  background = display.newImageRect(diretorioImagens ..  "fundo_menu.png", display.contentWidth, display.contentHeight)
  background.x = display.contentCenterX
  background.y = display.contentCenterY
  scene.view:insert(background)

  btnJogar = display.newImage(diretorioImagens .. "jogar.png")
  btnJogar.x = display.contentCenterX
  btnJogar.y = display.contentCenterY - 20
  scene.view:insert(btnJogar)

  btnCreditos = display.newImage(diretorioImagens .. "creditos.png")
  btnCreditos.x = display.contentCenterX
  btnCreditos.y = display.contentCenterY + 30
  scene.view:insert(btnCreditos)

  btnSair = display.newImage(diretorioImagens .. "sair.png")
  btnSair.x = display.contentCenterX
  btnSair.y = display.contentCenterY +  80
  scene.view:insert(btnSair)
end


-- Fechar app
function fecharApp()
      composer.removeScene("menu")

       if(system.getInfo("platformName")=="Android") then
           native.requestExit()
       else
           os.exit()
      end
end


-- Configuração de transição entre cenas
local transicaoJogoConfig = {
	effect = "fade", time = 400
}


-- Configuração de transição entre cenas
local transicaoCreditosConfig = {
	effect = "fade", time = 550
}


-- Função que chama cena para início do jogo
function jogar( )
  composer.removeScene("menu")
	composer.gotoScene("jogo", transicaoJogoConfig)
end


-- Função que chama cena de créditos do jogo
function creditos( )
  composer.removeScene("menu")
	composer.gotoScene("creditos", transicaoCreditosConfig)
end


-- Listener Setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)


return scene
