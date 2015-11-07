-- Origame

-- Esconde a barra de status
display.setStatusBar(display.HiddenStatusBar)

-- Constantes
local _W = display.contentWidth
local _H = display.contentHeight

-- Física
local physics = require('physics')
physics.start()

-- Variaveis composer
local composer = require("composer")
local scene = composer.newScene()

-- Variaveis
local alertGameOver
local background
local currentTsuru
local differentiationLabel
local differentiationText
local differentiationMode
local distanceLabel
local distanceText
local distance = 0
local gameView
local lastTsuruColor
local lastTsuruShape
local moveSpeed = 2
local ori
local speed = 10000
local tsuru
local tsuruTimer
local tsuru1
local tsuru2
local tsuru3
local imagePath = "resources/images/"
local colors = {"red", "yellow", "green"}
local shapes = {"shape1", "shape2", "shape3"}

-- Funções
local addOri = {}
local addTsurus = {}
local changeDifferentiationMode = {}
local differentiation = {}
local gameOver = {}
local gameView = {}
local jump = {}
local Main = {}
local onTouchTsuru = {}
local speedUp = {}
local update = {}
local getColor = {}
local getShape= {}
local shuffleTable = {}

--------------------------------------------------------------------------------
function scene:create(event)
  local sceneGroup = self.view

  -- Inicia a cena aqui
  -- Ex: adicionar objetos display para "sceneGroup"

  -- Exibi a regra de difereciação
  differentiationLabel = display.newText("Diferenciação:", _W - 390, _H - 300, native.systemFontBold, 12)
  differentiationLabel:setTextColor(68, 68, 68)

  differentiationText = display.newText("", _W - 280, _H - 300, native.systemFontBold, 12)
  differentiationText:setTextColor(68, 68, 68)

  -- Exibi a distância percorrida
  distanceText = display.newText("Distância:", _W - 150, _H - 300, native.systemFontBold, 12)
  distanceText:setTextColor(68, 68, 68)

  distanceText = display.newText("0 m", _W - 50, _H - 300, native.systemFontBold, 12)
  distanceText:setTextColor(68, 68, 68)
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

    -- Adicionar Ori
    addOri()

    -- Adicionar tsurus
    tsuruTimer = timer.performWithDelay(2000, addTsurus, 0 )

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

    -- Chamado antes da remoção de vista da cena ("sceneGroup")
    -- Código para "limpar" a cena
    -- ex: remover obejtos display, save state, cancelar transições e etc
end

--Game's Distance up
function distanceUp()
     --incrementando a distância
      distance = distance + 60
      distanceText.text = string.format("%d m", distance)
end
  dtc = timer.performWithDelay( 1000, distanciaUp, 0 )

--Add Tsurus
function addTsurus(event)
  --Speed up each 15 tsurus added
    if(event.count % 3 == 0 ) then
    --  speedUp()
    end

    shuffleTable(colors)
    shuffleTable(shapes)

    local color1 = colors[1]
    local color2 = colors[2]
    local color3 = colors[3]

    local shape1 = shapes[1]
    local shape2 = shapes[2]
    local shape3 = shapes[3]

    --Add 3 tsurus
    --Add tsuru on top
    tsuru1 = display.newImage(imagePath .. "tsurus/tsuru_".. color1 .. "_" .. shape1 .. ".png")
    tsuru1.x = _W
    tsuru1.y = _H - 250
    tsuru1.color = color1
    tsuru1.shape = shape1
    physics.addBody(tsuru1, "static")

    --Add tsuru in the middle
    tsuru2 = display.newImage(imagePath .. "tsurus/tsuru_".. color2 .. "_" .. shape2 .. ".png")
    tsuru2.x = _W
    tsuru2.y = _H - 150
    tsuru2.color = color2
    tsuru2.shape = shape2
    physics.addBody(tsuru2, "static")

    --Add tsuru at the bottom
    tsuru3 = display.newImage(imagePath .. "tsurus/tsuru_" .. color3 .. "_" .. shape3 .. ".png")
    tsuru3.x = _W
    tsuru3.y = _H - 50
    tsuru3.color = color3
    tsuru3.shape = shape3
    physics.addBody(tsuru3, "static")

    --transition tsurrus
    transition.to(tsuru1, {time = speed, x = -150, y = tsuru1.y, tag="all"})
    transition.to(tsuru2, {time = speed, x = -150, y = tsuru2.y, tag="all"})
    transition.to(tsuru3, {time = speed, x = -150, y = tsuru3.y, tag="all"})

    --Add handler on touch
    tsuru1.touch = onTouchTsuru
    tsuru2.touch = onTouchTsuru
    tsuru3.touch = onTouchTsuru

    tsuru1:addEventListener("touch", tsuru1)
    tsuru2:addEventListener("touch", tsuru2)
    tsuru3:addEventListener("touch", tsuru3)

    --show speed
    --distanceText.text = speed
end

-- generate random color
function getColor()
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

function shuffleTable( t )
    local rand = math.random
    local iterations = #t
    local j

    for i = iterations, 2, -1 do
        j = rand(i)
        t[i], t[j] = t[j], t[i]
    end
end

-- generate random shape
function getShape()
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
function speedUp()
  speed = speed - 1000

  --transition.cancel(ori)
  transition.to(ori, {time = speed - 2000, x = -150, y = ori.y })
end

function update()
  -- utilizar o tamanho da tela do dispositivo _W
  if(ori.x < -75) then
    --mudar para composer.gameOver()
    gameOver()
  end

  --.text  = distance
end

--Add ori to game
function addOri()
  tsuru = display.newImage(imagePath .. "tsuru.png")
  tsuru.x = _W
  tsuru.y = _H - 150
  tsuru.color = ""
  tsuru.shape = ""
  physics.addBody(tsuru, "static")

  --lastTsuruColor = tsuru.name

  ori = display.newImage(imagePath .. 'ori.png')
  ori.x = tsuru.x
  ori.y = tsuru.y - 25
  ori.name = "ori"
  ori.isFixedRotation = true
  physics.addBody(ori, "static")
  --ori.linearDamping = 5

 transition.to(ori, {time = speed, x = -150, y = ori.y, tag="all"})

  --tsuru.collision = onTouchTsuru

--  tsuru:addEventListener("collision", tsuru)

  transition.to(tsuru, {time = speed, x = -150, y = tsuru.y, tag="all"})

  --differentiation rule
  differentiation(tsuru)
end

--Tsuru is touched
function onTouchTsuru(self, event)
  --Moves Ori to the tsuru touched
  if(event.phase == "began" and self.x > ori.x and self.x < (ori.x + 150)) then
    ori.x = self.x
    ori.y = self.y - 25

    transition.to(ori, {time = speed, x = -150, y = ori.y, tag="all"})

    differentiation(self)

    distanceUp()
  end
end

--Tsurus differentiation
function differentiation(currentTsuru)
  if(differentiationMode == "cor") then
    if(currentTsuru.color == lastTsuruColor) then
      gameOver()
    end
  else
    if(currentTsuru.shape == lastTsuruShape) then
      gameOver()
    end
  end

  lastTsuruColor = currentTsuru.color
  lastTsuruShape = currentTsuru.shape

  changeDifferentiationMode()
end

--Change the tsurus differentiation mode
function changeDifferentiationMode()
  local randomNumber = math.random(0,1)

  if(randomNumber == 0) then
    differentiationMode = "cor"
  else
    differentiationMode = "forma"
  end

  differentiationText.text = string.format("%s", differentiationMode)

end

--Game Over
function gameOver()
  transition.cancel("all")
  timer.cancel(tsuruTimer)

  alertGameOver  = display.newText( "Fim de Jogo!", 250, 140, native.systemFont, 30)

  transition.from(alertGameOver, {time = 200})
end

--------------------------------------------------------------------------------

-- Listener Setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

--------------------------------------------------------------------------------

return scene
