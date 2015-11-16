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
local limiteNivel = 33
local primeiraEscolha = true


-- Funções
local adicionarOri = {}
local adicionarTsurus = {}
local mudarRegraDiferenciacao = {}
local diferenciar = {}
local fimDeJogo = {}
local selecionarTsuru = {}
local aumentarVelocidade = {}
local update = {}
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
    tsuruTimer = timer.performWithDelay(3000, adicionarTsurus, 0 )

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


-- Adiciona Ori
function adicionarOri()
  tsuru = display.newImage(caminhoDiretorioImagens .. "tsuru.png")
  tsuru.x = LARGURA - 500
  tsuru.y = ALTURA - 150
  tsuru.color = ""
  tsuru.shape = ""
  physics.addBody(tsuru, "kinematic")

  tsuru.touch = fimDeJogo

  tsuru:addEventListener("collision", tsuru)

  grupoImagens:insert(tsuru)

  ori = display.newImage(caminhoDiretorioImagens .. 'ori.png')
  ori.x = tsuru.x
  ori.y = tsuru.y - 25
  ori.name = "ori"
  ori.isFixedRotation = true
  physics.addBody(ori, "kinematic")
  grupoImagens:insert(ori)
end


-- Adicionar Tsurus
function adicionarTsurus(event)
    local tsurus = {}
  --Speed up each 15 tsurus added
  print("contador = " .. event.count)
    if(contadorTsurus == limiteNivel) then
      limiteNivel = limiteNivel + 33
      aumentarVelocidade()
    end

    embaralhar(cores)
    embaralhar(formas)

    local color1 = cores[1]
    local color2 = cores[2]
    local color3 = cores[3]

    local shape1 = formas[1]
    local shape2 = formas[2]
    local shape3 = formas[3]

    --Adiciona três tsurus
    --Adiciona tsuru no topo
    tsuru1 = display.newRect(0,0,80,80)
    tsuru1.fill = {type="image", filename=caminhoDiretorioImagens .. "tsurus/tsuru_".. color1 .. "_" .. shape1 .. ".png"}
    tsuru1.x = LARGURA
    tsuru1.y = ALTURA - 250
    tsuru1.color = color1
    tsuru1.shape = shape1
    tsuru1.id = 1
    physics.addBody(tsuru1, "kinematic")

    --Adiciona tsuru no meio
    tsuru2 = display.newRect(0,0,80,80)
    tsuru2.fill = {type="image", filename=caminhoDiretorioImagens .. "tsurus/tsuru_".. color2 .. "_" .. shape2 .. ".png"}
    tsuru2.x = LARGURA
    tsuru2.y = ALTURA - 150
    tsuru2.color = color2
    tsuru2.shape = shape2
    tsuru2.id = 2
    physics.addBody(tsuru2, "kinematic")

    --Adiona tsuru ao fundo
    tsuru3 = display.newRect(0,0,80,80)
    tsuru3.fill = {type="image", filename=caminhoDiretorioImagens .. "tsurus/tsuru_" .. color3 .. "_" .. shape3 .. ".png"}
    tsuru3.x = LARGURA
    tsuru3.y = ALTURA - 50
    tsuru3.color = color3
    tsuru3.shape = shape3
    tsuru3.id = 3
    physics.addBody(tsuru3, "kinematic")

    --transição tsurus
    transition.to(tsuru1, {time = velocidade, x = -150, y = tsuru1.y, tag="all"})
    transition.to(tsuru2, {time = velocidade, x = -150, y = tsuru2.y, tag="all"})
    transition.to(tsuru3, {time = velocidade, x = -150, y = tsuru3.y, tag="all"})

    --Adiciona manipulador ao toque
    tsuru1.touch = selecionarTsuru
    tsuru2.touch = selecionarTsuru
    tsuru3.touch = selecionarTsuru

    tsuru1:addEventListener("touch", tsuru1)
    tsuru2:addEventListener("touch", tsuru2)
    tsuru3:addEventListener("touch", tsuru3)

    --adiciona tsurus a um grupo
    grupoImagens:insert(tsuru1)
    grupoImagens:insert(tsuru2)
    grupoImagens:insert(tsuru3)

    -- adiciona os três tsurus a uma table
    tsurus = {tsuru1, tsuru2, tsuru3}

    -- adiciona a table com os três tsurus a outra table
    tableTsurus[indice] = tsurus

    --[[ incrementa o indice, indicando em qual posicão da tabela os próximos três
    tsurus serão adicionados]]
    indice = indice + 1

    -- guarda o numero de tsurus adicionados
    contadorTsurus = contadorTsurus + 3
end


-- Embaralha itens de uma table
function embaralhar(t)
    local j

    for i = #t, 2, -1 do
        j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end


-- Tsuru é tocado
function selecionarTsuru(self, event)

  -- Move Ori para o tsuru tocado
  if(event.phase == "began" and ((primeiraEscolha) or (self.x > ori.x and self.x < (ori.x + 250)))) then
    primeiraEscolha = false

    transition.to(tsuru, {time = 7000, x = -150, y = tsuru.y, tag="all"})
    ori.x = self.x
    ori.y = self.y - 25

    transition.to(ori, {time = velocidade, x = -150, y = ori.y, tag="all"})

    diferenciar(self)

    totalTsurusSaltados = totalTsurusSaltados + 1

    aumentarDistancia()

    removerTsurusNaoSelecionados(self.id)

    -- self.fill = {type="image", filename=caminhoDiretorioImagens .. "tsuru.png"}
  end
end

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


-- Remove os tsurus não selecionados do trio de tsurus atual
function removerTsurusNaoSelecionados(tsuruId)
  local tsuruNaoSelecionado1
  local tsuruNaoSelecionado2

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


-- Aumenta a distância
function aumentarDistancia()
     --incrementando a distância
      distancia = distancia + 60
      textoDistancia.text = string.format("%d m", distancia)
end


-- Aumenta a velocidade
function aumentarVelocidade()
  velocidade = velocidade - 1000
end

function update()
  -- utilizar o tamanho da tela do dispositivo LARGURA
  if(ori.x < LARGURA - 700 or contadorTsurus == 1000) then
    fimDeJogo()
  end
end


-- Configuração de transição entre cenas
local transicaofimDeJogoConfig = {
	effect = "fade", time = 1000
}


-- Função que chama cena para início do jogo
function fimDeJogo()
  composer.removeScene("jogo")
  composer.gotoScene("fim_de_jogo", transicaofimDeJogoConfig)
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
  display.remove(textoDiferenciacao)
  display.remove(etiquetaDiferenciacao)
  display.remove(textoDistancia)
  display.remove(etiquetaDistancia)
end


-- Listener Setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)


return scene
