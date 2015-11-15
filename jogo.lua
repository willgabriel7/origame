-- Origame
-- por Gabriel Araújo

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
local TsuruAtual
local etiquetaDiferenciacao
local textoDiferenciacao
local regraDiferenciacao
local etiquetaDistancia
local textoDistancia
local ultimaCorSelecionada
local ultimaFormaSelecionada
local velocidadeMovimento = 2
local ori
local velocidade = 10000
local tsuru
local tsuruTimer
local tsuru1
local tsuru2
local tsuru3
local caminhoDiretorioImagens = "resources/images/"
local cores = {"red", "yellow", "green"}
local formas = {"shape1", "shape2", "shape3"}
local grupoImagens
local contadorTsurus = 0
local tableTsurus = {}
local indice = 1
local trioTsurusAtual = 1


-- Funções
local adicionarOri = {}
local adicionarTsurus = {}
local mudarRegraDiferenciacao = {}
local diferenciar = {}
local fimDeJogo = {}
local selecionarTsuru = {}
local aumentarVelocidade = {}
local update = {}
local selecionarCor = {}
local selecionarForma= {}
local embaralhar = {}
local removerTsurusNaoSelecionados = {}


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
    grupoImagens = display.newGroup()

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
  display.remove(grupoImagens)
  --display.remove(ori)
  display.remove(textoDiferenciacao)
  display.remove(etiquetaDiferenciacao)
  display.remove(textoDistancia)
  display.remove(etiquetaDistancia)
    -- Chamado antes da remoção de vista da cena ("sceneGroup")
    -- Código para "limpar" a cena
    -- ex: remover obejtos display, save state, cancelar transições e etc
end

-- Aumenta a distância
function aumentarDistancia()
     --incrementando a distância
      distancia = distancia + 60
      textoDistancia.text = string.format("%d m", distancia)
end
  --dtc = timer.performWithDelay( 1000, aumentarDistancia, 0 )

--Add Tsurus
function adicionarTsurus(event)
    local tsurus = {}
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
    tsuru1 = display.newRect(0,0,80,80)
    tsuru1.fill = {type="image", filename=caminhoDiretorioImagens .. "tsurus/tsuru_".. color1 .. "_" .. shape1 .. ".png"}
    tsuru1.x = LARGURA
    tsuru1.y = ALTURA - 250
    tsuru1.color = color1
    tsuru1.shape = shape1
    tsuru1.id = 1
    physics.addBody(tsuru1, "static")

    --Add tsuru in the middle
    tsuru2 = display.newRect(0,0,80,80)
    tsuru2.fill = {type="image", filename=caminhoDiretorioImagens .. "tsurus/tsuru_".. color2 .. "_" .. shape2 .. ".png"}
    tsuru2.x = LARGURA
    tsuru2.y = ALTURA - 150
    tsuru2.color = color2
    tsuru2.shape = shape2
    tsuru2.id = 2
    physics.addBody(tsuru2, "static")

    --Add tsuru at the bottom
    tsuru3 = display.newRect(0,0,80,80)
    tsuru3.fill = {type="image", filename=caminhoDiretorioImagens .. "tsurus/tsuru_" .. color3 .. "_" .. shape3 .. ".png"}
    tsuru3.x = LARGURA
    tsuru3.y = ALTURA - 50
    tsuru3.color = color3
    tsuru3.shape = shape3
    tsuru3.id = 3
    physics.addBody(tsuru3, "static")

    --transition tsurus
    transition.to(tsuru1, {time = velocidade, x = -150, y = tsuru1.y, tag="all"})
    transition.to(tsuru2, {time = velocidade, x = -150, y = tsuru2.y, tag="all"})
    transition.to(tsuru3, {time = velocidade, x = -150, y = tsuru3.y, tag="all"})

    --Add handler on touch
    tsuru1.touch = selecionarTsuru
    tsuru2.touch = selecionarTsuru
    tsuru3.touch = selecionarTsuru

    tsuru1:addEventListener("touch", tsuru1)
    tsuru2:addEventListener("touch", tsuru2)
    tsuru3:addEventListener("touch", tsuru3)

    grupoImagens:insert(tsuru1)
    grupoImagens:insert(tsuru2)
    grupoImagens:insert(tsuru3)

    tsurus = {tsuru1, tsuru2, tsuru3}

    tableTsurus[indice] = tsurus
    indice = indice + 1

    contadorTsurus = contadorTsurus + 3
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
  velocidade = velocidade - 1000

  transition.cancel(ori)
  transition.to(ori, {time = velocidade - 2000, x = -150, y = ori.y , tag="all"})
end

function update()
  -- utilizar o tamanho da tela do dispositivo LARGURA
  if(ori.x < -75 or contadorTsurus == 1000) then
    --mudar para composer.fimDeJogo()
    fimDeJogo()
  end

  --.text  = distance
end

--Add ori to game
function adicionarOri()
  tsuru = display.newImage(caminhoDiretorioImagens .. "tsuru.png")
  tsuru.x = LARGURA
  tsuru.y = ALTURA - 150
  tsuru.color = ""
  tsuru.shape = ""
  physics.addBody(tsuru, "static")

  grupoImagens:insert(tsuru)

  --ultimaCorSelecionada = tsuru.name

  ori = display.newImage(caminhoDiretorioImagens .. 'ori.png')
  ori.x = tsuru.x
  ori.y = tsuru.y - 25
  ori.name = "ori"
  ori.isFixedRotation = true
  physics.addBody(ori, "static")
  --ori.linearDamping = 5
    grupoImagens:insert(ori)

 transition.to(ori, {time = velocidade, x = -150, y = ori.y, tag="all"})

  --tsuru.collision = selecionarTsuru

--  tsuru:addEventListener("collision", tsuru)

  transition.to(tsuru, {time = velocidade, x = -150, y = tsuru.y, tag="all"})

  --differentiation rule
  diferenciar(tsuru)
end

--Tsuru is touched
function selecionarTsuru(self, event)

  --Moves Ori to the tsuru touched
  if(event.phase == "began" and self.x > ori.x and self.x < (ori.x + 150)) then
    ori.x = self.x
    ori.y = self.y - 25

    transition.to(ori, {time = velocidade, x = -150, y = ori.y, tag="all"})


    diferenciar(self)

    totalTsurusSaltados = totalTsurusSaltados + 1
    aumentarDistancia()

    removerTsurusNaoSelecionados(self.id)

      self.fill = {type="image", filename=caminhoDiretorioImagens .. "tsuru.png"}
  end
end

-- Remove os tsurus não selecionados do trio de tsurus atual
function removerTsurusNaoSelecionados(tsuruId)
  local tsuruNaoSelecionado1
  local tsuruNaoSelecionado2
--[[  print("tsuro1 removido")
  tsuruNaoSelecionado1 = print(table.remove(tableTsurus[trioTsurusAtual],1))
  print("tssuro2 removido")
  tsuruNaoSelecionado2 = print(table.remove(tableTsurus[trioTsurusAtual],2))]]
  if (tsuruId == 1) then
    tsuruNaoSelecionado2 = table.remove(tableTsurus[trioTsurusAtual],3)
    tsuruNaoSelecionado2:removeSelf()
    tsuruNaoSelecionado2 = nil

    tsuruNaoSelecionado1 = table.remove(tableTsurus[trioTsurusAtual],2)
    tsuruNaoSelecionado1:removeSelf()
    tsuruNaoSelecionado1 = nil

  elseif (tsuruId == 2) then
    tsuruNaoSelecionado2 =  table.remove(tableTsurus[trioTsurusAtual],3)
    tsuruNaoSelecionado2:removeSelf()
    tsuruNaoSelecionado2 = nil

    tsuruNaoSelecionado1 =  table.remove(tableTsurus[trioTsurusAtual],1)
    tsuruNaoSelecionado1:removeSelf()
    tsuruNaoSelecionado1 = nil
  else
    tsuruNaoSelecionado2 =  table.remove(tableTsurus[trioTsurusAtual],2)
    tsuruNaoSelecionado2:removeSelf()
    tsuruNaoSelecionado2 = nil

    tsuruNaoSelecionado1 =  table.remove(tableTsurus[trioTsurusAtual],1)
    tsuruNaoSelecionado1:removeSelf()
    tsuruNaoSelecionado1 = nil
  end

  trioTsurusAtual =  trioTsurusAtual + 1
end

-- muda cor e forma do tsuru selecionado para cinza
function mudarCorEFormaTsuru(self)
  self:removeSelf()

end

--Tsurus differentiation
function diferenciar(TsuruAtual)
  if(regraDiferenciacao == "cor") then
    if(TsuruAtual.color == ultimaCorSelecionada) then
      fimDeJogo()
    end
  else
    if(TsuruAtual.shape == ultimaFormaSelecionada) then
      fimDeJogo()
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
local transicaofimDeJogoConfig = {
	effect = "fade", time = 1000
}
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Função que chama cena para início do jogo
--------------------------------------------------------------------------------
function fimDeJogo()
  composer.removeScene("jogo")
  composer.gotoScene("fim_de_jogo", transicaofimDeJogoConfig)
end


--------------------------------------------------------------------------------

-- Listener Setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

--------------------------------------------------------------------------------

return scene
