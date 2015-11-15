local composer = require("composer")
local scene = composer.newScene()
local cm
local carregaMenu = {}
local carregaFundo = {}


function scene:create(event)
  local sceneGroup = self.view
  carregaFundo()
end


function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase

  if (phase == "will") then
    -- Chama quando a cena está fora da cena
  elseif (phase == "did") then
    -- Chama quando a cena está na tela
    cm = timer.performWithDelay(2000, carregaMenu, 1)
  end
end


function scene:hide(event)
  local sceneGroup = self.view
  local phase = event.phase

  if (phase == "will") then
    -- Chama quando a cena está na cena
  elseif (phase == "did") then
    -- Chama imediatamente quando a cena está fora da tela
  end
end


function scene:destroy(event)
  local sceneGroup = self.view
  -- Chamado antes da remoção de vista da cena ("sceneGroup")
end


function carregaFundo()
  fundo = display.newImage("resources/estilo/preto/fundo_inicial.png", display.contentWidth, display.contentHeight)
  fundo.x = display.contentCenterX
  fundo.y = display.contentCenterY
  scene.view:insert(fundo)
end


local configTransitionMenu = {
  effect = "fade", time = 1000
}


function carregaMenu()
  composer.removeScene("initial_screen")
  composer.gotoScene("menu", configTransitionMenu)
end


-- Listener Setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)


return scene
