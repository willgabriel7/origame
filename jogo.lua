-- Origame

-- Esconde a barra de status
display.setStatusBar(display.HiddenStatusBar)
--physics.setDrawMode("hybrid")

-- Constantes
local LARGURA = display.contentWidth
local ALTURA = display.contentHeight

-- Física
local physics = require('physics')
physics.start()

-- Variaveis composer
local composer = require("composer")
local scene = composer.newScene()

-- Variaveis
local alertGameOver
local background
local TsuruAtual
local etiquetaDiferenciacao
local textoDiferenciacao
local regraDiferenciacao
local etiquetaDistancia
local textoDistancia
--local distance = 0
local gameView
local ultimaCorSelecionada
local ultimaFormaSelecionada
local velocidadeMovimento = 2
local ori
local speed = 10000
local tsuru
local tsuruTimer
local tsuru1
local tsuru2
local tsuru3
local diretorioImagens = "resources/images/"
local cores = {"red", "yellow", "green"}
local formas = {"shape1", "shape2", "shape3"}
local grupoTsurus

-- Funções
local adicionarOri = {}
local adicionarTsurus = {}
local mudarRegraDiferenciacao = {}
local differentiation = {}
local gameOver = {}
local gameView = {}
local Main = {}
local selecionarTsuru = {}
local aumentarVelocidade = {}
local update = {}
local selecionarCor = {}
local selecionarForma= {}
local embaralhar = {}

--------------------------------------------------------------------------------
function scene:create(event)
  local sceneGroup = self.view

  -- Inicia a cena aqui
  -- Ex: adicionar objetos display para "sceneGroup"

  -- Exibi a regra de difereciação
  etiquetaDiferenciacao = display.newText("Diferenciação:", LARGURA - 390, ALTURA - 300, native.systemFontBold, 12)
  etiquetaDiferenciacao:setTextColor(68, 68, 68)

  textoDiferenciacao = display.newText("", LARGURA - 280, ALTURA - 300, native.systemFontBold, 12)
  textoDiferenciacao:setTextColor(68, 68, 68)

  -- Exibi a distância percorrida
  etiquetaDistancia = display.newText("Distância:", LARGURA - 150, ALTURA - 300, native.systemFontBold, 12)
  etiquetaDistancia:setTextColor(68, 68, 68)

  textoDistancia = display.newText("0 m", LARGURA - 50, ALTURA - 300, native.systemFontBold, 12)
  textoDistancia:setTextColor(68, 68, 68)
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
    grupoTsurus = display.newGroup()

    -- Adicionar Ori
    adicionarOri()

    -- Adicionar tsurus
    tsuruTimer = timer.performWithDelay(2000, adicionarTsurus, 0 )

    -- Atualizar cena
    Runtime:addEventListener('enterFrame', update)


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

  transition.cancel("all")
  timer.cancel(tsuruTimer)
  Runtime:removeEventListener("enterFrame", update)
  Runtime:removeEventListener("touch", tsuru1)
  Runtime:removeEventListener("touch", tsuru2)
  Runtime:removeEventListener("touch", tsuru3)
  display.remove(grupoTsurus)
  --display.remove(ori)
  display.remove(textoDiferenciacao)
  display.remove(etiquetaDiferenciacao)
  display.remove(textoDistancia)
  display.remove(etiquetaDistancia)
    -- Chamado antes da remoção de vista da cena ("sceneGroup")
    -- Código para "limpar" a cena
    -- ex: remover obejtos display, save state, cancelar transições e etc
end

--Game's Distance up
function distanceUp()
     --incrementando a distância
      distance = distance + 60
      textoDistancia.text = string.format("%d m", distance)
end
  dtc = timer.performWithDelay( 1000, distanciaUp, 0 )

--Add Tsurus
function adicionarTsurus(event)
  --Speed up each 15 tsurus added
    if(event.count % 3 == 0 ) then
    --  aumentarVelocidade()
    end

    embaralhar(cores)
    embaralhar(formas)

    local color1 = cores[1]
    local color2 = cores[2]
    local color3 = cores[3]

    local shape1 = formas[1]
    local shape2 = formas[2]
    local shape3 = formas[3]

    --Add 3 tsurus
    --Add tsuru on top
    tsuru1 = display.newImage(diretorioImagens .. "tsurus/tsuru_".. color1 .. "_" .. shape1 .. ".png")
    tsuru1.x = LARGURA
    tsuru1.y = ALTURA - 250
    tsuru1.color = color1
    tsuru1.shape = shape1
    physics.addBody(tsuru1, "static")

    --Add tsuru in the middle
    tsuru2 = display.newImage(diretorioImagens .. "tsurus/tsuru_".. color2 .. "_" .. shape2 .. ".png")
    tsuru2.x = LARGURA
    tsuru2.y = ALTURA - 150
    tsuru2.color = color2
    tsuru2.shape = shape2
    physics.addBody(tsuru2, "static")

    --Add tsuru at the bottom
    tsuru3 = display.newImage(diretorioImagens .. "tsurus/tsuru_" .. color3 .. "_" .. shape3 .. ".png")
    tsuru3.x = LARGURA
    tsuru3.y = ALTURA - 50
    tsuru3.color = color3
    tsuru3.shape = shape3
    physics.addBody(tsuru3, "static")

    --transition tsurrus
    transition.to(tsuru1, {time = speed, x = -150, y = tsuru1.y, tag="all"})
    transition.to(tsuru2, {time = speed, x = -150, y = tsuru2.y, tag="all"})
    transition.to(tsuru3, {time = speed, x = -150, y = tsuru3.y, tag="all"})

    --Add handler on touch
    tsuru1.touch = selecionarTsuru
    tsuru2.touch = selecionarTsuru
    tsuru3.touch = selecionarTsuru

    tsuru1:addEventListener("touch", tsuru1)
    tsuru2:addEventListener("touch", tsuru2)
    tsuru3:addEventListener("touch", tsuru3)

    grupoTsurus:insert(tsuru1)
    grupoTsurus:insert(tsuru2)
    grupoTsurus:insert(tsuru3)

    --show speed
    --textoDistancia.text = speed
end

-- generate random color
function selecionarCor()
  local color =  math.random(1, 3)

  if(color == 1 and color ~= lastColor) then
    color  = "red"
  elseif (color == 2 and color ~= lastColor) then
    color = "yellow"
  else
    color = "green"
  end

  lastColor = color

  return color
end

function embaralhar( t )
    local rand = math.random
    local iterations = #t
    local j

    for i = iterations, 2, -1 do
        j = rand(i)
        t[i], t[j] = t[j], t[i]
    end
end

-- generate random shape
function selecionarForma()
  local shape =  math.random(1, 3)

  if(shape == 1 and shape ~= lastShape) then
    shape  = "shape1"
  elseif (color == 2 and shape ~= lastShape) then
    shape = "shape2"
  else
    shape = "shape3"
  end

  lastShape = shape

  return shape
end

--Game's speed up
function aumentarVelocidade()
  speed = speed - 1000

  --transition.cancel(ori)
  transition.to(ori, {time = speed - 2000, x = -150, y = ori.y , tag="all"})
end

function update()
  -- utilizar o tamanho da tela do dispositivo LARGURA
  if(ori.x < -75) then
    --mudar para composer.gameOver()
    gameOver()
  end

  --.text  = distance
end

--Add ori to game
function adicionarOri()
  tsuru = display.newImage(diretorioImagens .. "tsuru.png")
  tsuru.x = LARGURA
  tsuru.y = ALTURA - 150
  tsuru.color = ""
  tsuru.shape = ""
  physics.addBody(tsuru, "static")

  grupoTsurus:insert(tsuru)

  --ultimaCorSelecionada = tsuru.name

  ori = display.newImage(diretorioImagens .. 'ori.png')
  ori.x = tsuru.x
  ori.y = tsuru.y - 25
  ori.name = "ori"
  ori.isFixedRotation = true
  physics.addBody(ori, "static")
  --ori.linearDamping = 5
    grupoTsurus:insert(ori)

 transition.to(ori, {time = speed, x = -150, y = ori.y, tag="all"})

  --tsuru.collision = selecionarTsuru

--  tsuru:addEventListener("collision", tsuru)

  transition.to(tsuru, {time = speed, x = -150, y = tsuru.y, tag="all"})

  --differentiation rule
  differentiation(tsuru)
end

--Tsuru is touched
function selecionarTsuru(self, event)
  --Moves Ori to the tsuru touched
  if(event.phase == "began" and self.x > ori.x and self.x < (ori.x + 150)) then
    ori.x = self.x
    ori.y = self.y - 25

    transition.to(ori, {time = speed, x = -150, y = ori.y, tag="all"})

    differentiation(self)

    tsurusSaltados = tsurusSaltados + 1
    distanceUp()
  end
end

--Tsurus differentiation
function differentiation(TsuruAtual)
  if(regraDiferenciacao == "cor") then
    if(TsuruAtual.color == ultimaCorSelecionada) then
      gameOver()
    end
  else
    if(TsuruAtual.shape == ultimaFormaSelecionada) then
      gameOver()
    end
  end

  ultimaCorSelecionada = TsuruAtual.color
  ultimaFormaSelecionada = TsuruAtual.shape

  mudarRegraDiferenciacao()
end

--Change the tsurus differentiation mode
function mudarRegraDiferenciacao()
  local randomNumber = math.random(0,1)

  if(randomNumber == 0) then
    regraDiferenciacao = "cor"
  else
    regraDiferenciacao = "forma"
  end

  textoDiferenciacao.text = string.format("%s", regraDiferenciacao)

end


--------------------------------------------------------------------------------
-- Configuração de transição entre cenas
--------------------------------------------------------------------------------
local configTransicaoGameOver = {
	effect = "fade", time = 1000
}
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Função que chama cena para início do jogo
--------------------------------------------------------------------------------
function gameOver()
  composer.removeScene("jogo")
  composer.gotoScene("fim_de_jogo", configTransicaoGameOver)
end


--------------------------------------------------------------------------------

-- Listener Setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

--------------------------------------------------------------------------------

return scene
