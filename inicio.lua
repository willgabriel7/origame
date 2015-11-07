local composer = require("composer")
local scene = composer.newScene()
local lm
local loadMenu = {}
local loadBackground = {}
--------------------------------------------------------------------------------
function scene:create(event)
  local sceneGroup = self.view

  -- Inicia a cena aqui
  -- Ex: adicionar objetos display para "sceneGroup"

    loadBackground()
end

function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase

  if (phase == "will") then
    -- Chama quando a cena está fora da cena
  elseif (phase == "did") then
    -- Chama quando a cena está na tela
    -- Inserir código para fazer que a cena venha "viva"
    -- Ex: start times, begin animation, play audio, etc
    lm = timer.performWithDelay(2000, loadMenu, 1)

  end
end

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

function scene:destroy(event)
  local sceneGroup = self.view

    -- Chamado antes da remoção de vista da cena ("sceneGroup")
    -- Código para "limpar" a cena
    -- ex: remover obejtos display, save state, cancelar transições e etc
end

--------------------------------------------------------------------------------
function loadBackground()
  background = display.newImage("resources/images/logo.png", display.contentWidth, display.contentHeight)
  background.x = display.contentCenterX
  background.y = display.contentCenterY
  scene.view:insert(background)
end

local configTransitionMenu = {
  effect = "fade", time = 1000
}

function loadMenu()
  composer.removeScene("initial_screen")
  composer.gotoScene("jogo", configTransitionMenu)
end


-- Listener Setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

--------------------------------------------------------------------------------

return scene
