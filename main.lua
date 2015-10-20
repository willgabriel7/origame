-- Origame
-- by Will

--Hide Status Bar
display.setStatusBar(display.HiddenStatusBar)

--Constants
local _W = display.contentWidth
local _H = display.contentHeight

--Physics
local physics = require('physics')
physics.start()
--physics.setGravity( 0, 0)

--variables
local background
local distanceText
local distanceLabel
local distance = 0
local alertGameOver
local ori
local gameView
local moveSpeed = 2
local tsuruTimer
local tsuru
local tsuru1
local tsuru2
local tsuru3
local lastTsuruColor
local lastTsuruShape
local currentTsuru
local speed = 10000
local differentiationMode
local differentiationText
local differentiationLabel

--functions
local Main = {}
local gameView = {}
local addOri = {}
local addTsurus = {}
local update = {}
local onTouchTsuru = {}
local gameOver = {}
local speedUp = {}
local differentiation = {}
local changeDifferentiationMode = {}
local jump = {}

--Main function
function Main()
  --Starts the game
  gameView()
end

function gameView()
  --show differentiation
  differentiationLabel = display.newText("Diferenciação:", _W - 390, _H - 300, native.systemFontBold, 20)
  differentiationLabel:setTextColor(68, 68, 68)

  differentiationText = display.newText("", _W - 280, _H - 300, native.systemFontBold, 20)
  differentiationText:setTextColor(68, 68, 68)

  -- show distance
  distanceText = display.newText("Distância:", _W - 150, _H - 300, native.systemFontBold, 20)
  distanceText:setTextColor(68, 68, 68)

  distanceText = display.newText("0 m", _W - 50, _H - 300, native.systemFontBold, 20)
  distanceText:setTextColor(68, 68, 68)

  --Add Ori
  addOri()
  --Add tsurus
  tsuruTimer = timer.performWithDelay(2000, addTsurus, 0 )
  --Update the scene
  Runtime:addEventListener('enterFrame', update)
end

  --end
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

    --Add 3 tsurus
    --Add tsuru on top
    tsuru1 = display.newImage("images/tsuru-cinza.png")
    tsuru1.x = _W
    tsuru1.y = _H - 250
    tsuru1.color = "gray"
    tsuru1.shape = "shape1"
    physics.addBody(tsuru1, "static")

    --Add tsuru in the middle
    tsuru2 = display.newImage("images/tsuru-amarelo.png")
    tsuru2.x = _W
    tsuru2.y = _H - 150
    tsuru2.color = "yellow"
    tsuru2.shape = "shape2"
    physics.addBody(tsuru2, "static")

    --Add tsuru at the bottom
    tsuru3 = display.newImage("images/tsuru-vermelho.png")
    tsuru3.x = _W
    tsuru3.y = _H - 50
    tsuru3.color = "red"
    tsuru3.shape = "shape3"
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

--Game's speed up
function speedUp()
  speed = speed - 1000

  --transition.cancel(ori)
  transition.to(ori, {time = speed - 2000, x = -150, y = ori.y })
end

function update()
  if(ori.x < -75) then
    gameOver()
  end

  --.text  = distance
end

--Add ori to game
function addOri()
  tsuru = display.newImage("images/tsuru.png")
  tsuru.x = _W
  tsuru.y = _H - 150
  tsuru.color = ""
  tsuru.shape = ""
  physics.addBody(tsuru, "static")

  --lastTsuruColor = tsuru.name

  ori = display.newImage('images/ori.png')
  ori.x = tsuru.x
  ori.y = tsuru.y - 25
  physics.addBody(ori, "dynamic")
  ori.name = "ori"
  ori.isFixedRotation = true
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
  if(event.phase == "began" and self.x > ori.x and self.x < (ori.x + 200)) then
  --  transition.cancel(ori)
    ori.x = self.x
    ori.y = self.y - 25

    transition.to(ori, {time = speed, x = -150, y = ori.y, tag="all"})

    differentiation(self)

    distanceUp()

    changeDifferentiationMode()
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

Main()
