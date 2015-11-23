local composer = require("composer")
local scene = composer.newScene()
local caminhoDiretorioEstilo = "resources/estilo/"
local fundo
local titulo1
local titulo2
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
  fundo = display.newImage(caminhoDiretorioEstilo .. "fundo-telas.png", display.contentWidth, display.contentHeight)
  fundo.x = display.contentCenterX
  fundo.y = display.contentCenterY
  scene.view:insert(fundo)

  titulo1 = display.newText('ori', display.contentCenterX - 90, display.contentCenterY, "Origram", 70)
  titulo1:setFillColor(244/255,67/255,54/255)
  scene.view:insert(titulo1)
  titulo2 = display.newText('game', display.contentCenterX + 42, display.contentCenterY, "Origram", 70)
  scene.view:insert(titulo2)
end


local configTransitionMenu = {
  effect = "fade", time = 1000
}


function carregaMenu()
  composer.removeScene("initial_screen")
  composer.gotoScene("jogo", configTransitionMenu)
end


-- Listener Setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)


return scene
