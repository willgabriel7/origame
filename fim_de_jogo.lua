local composer = require("composer")
local scene = composer.newScene()

--------------------------------------------------------------------------------
function scene:create(event)
  local sceneGroup = self.view

  -- Inicia a cena aqui
  -- Ex: adicionar objetos display para "sceneGroup"
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

-- Listener Setup
scene::addEventListener("create", scene)
scene::addEventListener("show", scene)
scene::addEventListener("hide", scene)
scene::addEventListener("destroy", scene)

--------------------------------------------------------------------------------

return scene
