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
local nameTsuruBefore
local speed = 10000

--functions
local Main = {}
local gameView = {}
local addOri = {}
local addTsurus = {}
local update = {}
local onTouch = {}
local gameOver = {}
local speedUp = {}

--Main function
function Main()
  --Starts the game
  gameView()
end

function gameView()
  --Add Ori
  addOri()
  --Add tsurus
  tsuruTimer = timer.performWithDelay(2000, addTsurus, 0 )
  --Update the scene
  Runtime:addEventListener('enterFrame', update)

  --show distance
--  distanceText = display.newText('Distância 0.0 km', 250, 22, system.nativeFont, 12)
--  distanceText:setTextColor(68, 68, 68)
end

distanceText = display.newText("Distância 0 m", _W - 250, _H - 300, native.systemFontBold, 20)
distanceText:setTextColor(68, 68, 68)
  --end
  function distanceUp()
     --incrementando a distancia
      distance = distance + 60
      distanceText.text = string.format("Distância %d m", distance)
  end
  dtc = timer.performWithDelay( 1000, distanciaUp, 0 )


function addTsurus(event)
  --Speed up each 15 tsurus added
    if(event.count % 3 == 0 ) then
    --  speedUp()
    end

    --Add 3 tsurus
    --Add tsuru on top
    tsuru1 = display.newImage("tsuru.png")
    tsuru1.x = _W
    tsuru1.y = _H - 250
    tsuru1.name = "tsuru-top"
    physics.addBody(tsuru1, "static")

    --Add tsuru in the middle
    tsuru2 = display.newImage("tsuru.png")
    tsuru2.x = _W
    tsuru2.y = _H - 150
    tsuru2.name = "tsuru-middle"
    physics.addBody(tsuru2, "static")

    --Add tsuru at the bottom
    tsuru3 = display.newImage("tsuru.png")
    tsuru3.x = _W
    tsuru3.y = _H - 50
    tsuru3.name = "tsuru-bottom"
    physics.addBody(tsuru3, "static")

    --transition tsurrus
    transition.to(tsuru1, {time = speed, x = -150, y = tsuru1.y, tag="all"})
    transition.to(tsuru2, {time = speed, x = -150, y = tsuru2.y, tag="all"})
    transition.to(tsuru3, {time = speed, x = -150, y = tsuru3.y, tag="all"})

    --Add handler on touch
    tsuru1.touch = onTouch
    tsuru2.touch = onTouch
    tsuru3.touch = onTouch

    tsuru1:addEventListener("touch", tsuru1)
    tsuru2:addEventListener("touch", tsuru2)
    tsuru3:addEventListener("touch", tsuru3)

    --show speed
    --distanceText.text = speed
end

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

function addOri()
  tsuru = display.newImage("tsuru.png")
  tsuru.x = _W
  tsuru.y = _H - 150
  tsuru.name = 'tsuru-middle'
  physics.addBody(tsuru, "static")


  nameTsuruBefore = tsuru.name

  ori = display.newImage('ori.png')
  ori.x = tsuru.x
  ori.y = tsuru.y - 25
  physics.addBody(ori, "dynamic")
  ori.name = "ori"
  ori.isFixedRotation = true
  --ori.linearDamping = 5

 transition.to(ori, {time = speed, x = -150, y = ori.y, tag="all"})

  --tsuru.collision = onTouch

--  tsuru:addEventListener("collision", tsuru)

  transition.to(tsuru, {time = speed, x = -150, y = tsuru.y, tag="all"})
end

--[[function gameListeners(action)
  if(action == 'add') then
      tsuruTimer = timer.performWithDelay(3000, addTsurus, 0 )
      Runtime:addEventListener('touch', moveori)
      Runtime:addEventListener('enterFrame', update)
      --tsuruTimer = timer.performWithDelay(800, addTsurus, 0)
      ori:addEventListener('collision', onTouch)
  else
    Runtime:removeEventListener('touch', moveori)
    Runtime:removeEventListener('enterFrame', update)
    timer.cancel(tsuruTimer)
    tsuruTimer = nil
    ori:removeEventListener('collision', onTouch)
  end
end]]--

--[[
function update1(e)
  -- Screen Borders
  if(ori.x <= 0) then --Left
  ori.x = 0
  elseif(ori.x >= (_W - ori.width)) then --Right
  ori.x = (_W - ori.width)
  end
  -- ori Movement
  ori.y = ori.y + moveSpeed
   for i = 1, tsurus.numChildren do
  -- tsurus Movement
  tsurus[i].y = tsurus[i].y - moveSpeed
  end

  -- distance
  distance = distance + 1
  distanceText.text = distance
  -- Lose Lives
  if(ori.y > _H or ori.y < -5) then
  -- ori.x = tsurus[tsurus.numChildren - 1].x
  --ori.y = tsurus[tsurus.numChildren - 1].y - ori.height
  --lives = lives - 1
  --livesTF.text = 'x' .. lives
    gameOver()
end

-- Levels


if(distance > 500 and distance < 502) then
moveSpeed = 3
end
end
]]--

function onTouch(self, event)
  --Moves Ori to the tsuru touched
  if(event.phase == "began" and self.x > ori.x) then
  --  transition.cancel(ori)

    ori.x = self.x
    ori.y = self.y - 25

    transition.to(ori, {time = speed, x = -150, y = ori.y, tag="all"})

    if(self.name == nameTsuruBefore) then
      gameOver()
    end

    distanceUp()
    nameTsuruBefore = self.name
  end
end


function gameOver()
  transition.cancel("all")
  timer.cancel(tsuruTimer)

  --alertGameOver = display.newText("Fim de Jogo!", 250, 140, native.systemFont, 30)
  alertGameOver  = display.newText( "Fim de Jogo!", 250, 140, native.systemFont, 30 )

  transition.from(alertGameOver, {time = 200})
end


Main()
