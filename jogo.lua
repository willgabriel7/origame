-- Origame
-- por Gabriel Araújo

-- Esconde a barra de status
display.setStatusBar(display.HiddenStatusBar)
--physics.setDrawMode("hybrid")


-- Constantes
local LARGURA_TELA = display.contentWidth
local ALTURA_TELA = display.contentHeight
local CENTRO_X = display.contentCenterX
local CENTRO_Y = display.contentCenterY


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
local textoPontuacao
local etiquetaPontuacao
local regraDiferenciacao
local etiquetaDistancia
local textoDistancia
local ultimaCorSelecionada
local ultimaFormaSelecionada
local velocidadeMovimento = 2
local ori
local velocidade = .1
local tsuru
local tsuruTimer
local tsuru1
local tsuru2
local tsuru3
local caminhoDiretorioImagens = "resources/images/"
local caminhoDiretorioSom = "resources/sons/"
local cores = {"ambar", "indigo", "laranja", "roxo", "vermelho"}
local formas = {"forma1", "forma2", "forma3"}
local grupoImagens = display.newGroup()
local contadorTsurus = 0
local tableTsurus = {}
local indice = 1
local trioTsurusAtual = 1
local limiteNivel = 30
local primeiraEscolha = true
local ultimoTempo = 4.000
local tempoAtual
local fundo
local montanhasFundo
local montanhasFrente
local caminhoDiretorioEstilo = "resources/estilo/"
local velocidadeMontanhas
local barreira
local tsuruInicio = nil
local iconeDiferenciacao
local btnJogar
local btnCreditos
local btnSair
local btnComoJogar
local destroi = false
local titulo1
local titulo2
local frequencia = 3000
local nivel = 1
local toquePausar = false
local salto = true

-- Funções
local adicionarOri = {}
local adicionarTsurus = {}
local mudarRegraDiferenciacao = {}
local diferenciar = {}
local fimDeJogo = {}
local selecionarTsuru = {}
local aumentarVelocidade = {}
local inspesionador = {}
local embaralhar = {}
local removerTsurusNaoSelecionados = {}
local pausar = {}
local resumir = {}
local montarCenario = {}
local scrollingMontanhas = {}
local carregarMenu = {}
local jogar = {}
local creditos = {}
local carregarMenu = {}
local fecharApp = {}
local montarCenario = {}
local jogar = {}
local options = {width = 90.6, height = 64, numFrames = 4}
local tsurusAnim = { name="fly", start = 1, count = 4, time = 1000, loopCount = 0}


local transicao = false

function scene:create(event)
  local sceneGroup = self.view

  -- Inicia a cena aqui
  -- Ex: adicionar objetos display para "sceneGroup"

  -- monta cenario
  montarCenario()

  local somMenu = audio.loadStream(caminhoDiretorioSom .. "chinese-traditional-4.aif.mp3" )
  audio.play(somMenu, {loops = -1, channel = 1, fadeout=1000})
  audio.setVolume( 0.50 , { channel=1 })

end

function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase

  if (phase == "will") then
    -- Chama quando a cena está fora da cena
  elseif (phase == "did") then
    btnJogar:addEventListener("touch", jogar)
    btnCreditos:addEventListener("touch", creditos)
    btnSair:addEventListener("touch", fecharApp)
    btnComoJogar:addEventListener("touch", comoJogar)

    if(isJogarNovamente) then
      jogar()
    end
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


function montarCenario()
  fundo = display.newImageRect(caminhoDiretorioEstilo .. "fundo2.png", LARGURA_TELA, ALTURA_TELA)
  fundo.x = CENTRO_X
  fundo.y = CENTRO_Y
  scene.view:insert(fundo)

  titulo1 = display.newText('ori', CENTRO_X - 90, CENTRO_Y - 162, "Origram", 70)
  titulo1:setFillColor(244/255,67/255,54/255)
  scene.view:insert(titulo1)
  titulo2 = display.newText('game', CENTRO_X + 42, CENTRO_Y - 162, "Origram", 70)
  scene.view:insert(titulo2)

--[[  montanhasFundo = display.newImageRect(caminhoDiretorioEstilo .. "montanhas-fundo.png", LARGURA_TELA, ALTURA_TELA)
  montanhasFundo.x = CENTRO_X
  montanhasFundo.y = CENTRO_Y
  scene.view:insert(montanhasFundo)

  montanhasFrente = display.newImageRect(caminhoDiretorioEstilo .. "montanhas-frente.png", LARGURA_TELA, ALTURA_TELA)
  montanhasFrente.x = CENTRO_X
  montanhasFrente.y = CENTRO_Y
  scene.view:insert(montanhasFrente)]]

--[[  montanhasFrente2 = display.newImageRect(caminhoDiretorioEstilo .. "montanhas-frente.png", LARGURA_TELA, ALTURA_TELA)
  montanhasFrente2.x = montanhasFrente.x + LARGURA_TELA
  montanhasFrente2.y = CENTRO_Y
  scene.view:insert(montanhasFrente2)

  montanhasFrente3 = display.newImageRect(caminhoDiretorioEstilo .. "montanhas-frente.png", LARGURA_TELA, ALTURA_TELA)
  montanhasFrente3.x = montanhasFrente3.x + LARGURA_TELA
  montanhasFrente3.y = CENTRO_Y
  scene.view:insert(montanhasFrente3)]]

  ori = display.newImage(caminhoDiretorioImagens .. 'ori.png')
  ori.x = CENTRO_X - 248
  ori.y = CENTRO_Y - 106
  ori.name = "ori"
  ori.isFixedRotation = true
  physics.addBody(ori, "kinematic")
  scene.view:insert(ori)
  --grupoImagens:insert(ori)


--[[barreira = display.newRect(CENTRO_X, CENTRO_Y, LARGURA_TELA, ALTURA_TELA)
  barreira:setFillColor(0, 0.5)
  barreira:setStrokeColor( 1, 0, 0 )
  scene.view:insert(barreira)]]

  carregarMenu()
end

-- Carregar imagens contidas no menu
function carregarMenu()
  btnComoJogar = display.newImageRect(caminhoDiretorioEstilo .. "botao-tutorial.png", 40, 40)
  btnComoJogar.x = CENTRO_X - 130
  btnComoJogar.y = CENTRO_Y + 170
  scene.view:insert(btnComoJogar)

  btnJogar = display.newImageRect(caminhoDiretorioEstilo .. "botao-jogar.png", 90, 90)
  btnJogar.x = CENTRO_X
  btnJogar.y = CENTRO_Y + 147
  scene.view:insert(btnJogar)

  btnCreditos = display.newImageRect(caminhoDiretorioEstilo .. "botao-creditos.png", 40, 40)
  btnCreditos.x = CENTRO_X + 130
  btnCreditos.y = CENTRO_Y + 170
  scene.view:insert(btnCreditos)

  btnSair = display.newImageRect(caminhoDiretorioEstilo .. "botao-sair.png", 30, 30)
  btnSair.x = CENTRO_X + 300
  btnSair.y = CENTRO_Y - 160
  scene.view:insert(btnSair)

  adicionarTsurus()
end

function scrollingMontanhas(event)
--  montanhasFundo.x = montanhasFundo.x - 0.5
  montanhasFrente.x = montanhasFrente.x - 1
  montanhasFrente2.x = montanhasFrente2.x - 1
  montanhasFrente3.x = montanhasFrente3.x - 1

  if (montanhasFrente.x + montanhasFrente.contentWidth) < 0 then
    montanhasFrente:translate(LARGURA_TELA * 4, 0)
  end

  if (montanhasFrente2.x + montanhasFrente2.contentWidth) < 0 then
    montanhasFrente2:translate(LARGURA_TELA * 4, 0)
  end

  if (montanhasFrente3.x + montanhasFrente3.contentWidth) < 0 then
    montanhasFrente3:translate(LARGURA_TELA * 4, 0)
  end
end

function exibirTextos()
  -- Exibi a distância percorrida
  textoDistancia = display.newText("0 m", CENTRO_X - 160, CENTRO_Y - 180, "Origram", 16)
  textoDistancia:setTextColor(68, 68, 68)
  scene.view:insert(textoDistancia)

  -- Exibi a pontuação
  textoPontuacao = display.newText("0", CENTRO_X, CENTRO_Y - 180, "Origram", 16)
  textoPontuacao:setTextColor(68, 68, 68)
  scene.view:insert(textoPontuacao)

  -- Exibi a regra de difereciação
  iconeDiferenciacao = display.newImageRect(caminhoDiretorioEstilo .. "icone-diferente.png", 30, 20)
  iconeDiferenciacao.x = CENTRO_X + 160
  iconeDiferenciacao.y = CENTRO_Y - 180
  scene.view:insert(iconeDiferenciacao)

  textoDiferenciacao = display.newText("", CENTRO_X + 205, CENTRO_Y - 180, "Origram", 16)
  textoDiferenciacao:setTextColor(68, 68, 68)
  scene.view:insert(textoDiferenciacao)

  iconePausar = display.newImageRect(caminhoDiretorioEstilo .. "icone-pausar.png", 30, 25)
  iconePausar.x = CENTRO_X + 300
  iconePausar.y = CENTRO_Y - 180
  iconePausar.alpha = 1
  scene.view:insert(iconePausar)

  iconeResume = display.newImageRect(caminhoDiretorioEstilo .. "icone-resume.png", 30, 25)
  iconeResume.x = CENTRO_X + 300
  iconeResume.y = CENTRO_Y - 180
  iconeResume.alpha = 0
  scene.view:insert(iconeResume)

  iconePausar:addEventListener("touch", pausar)
  iconeResume:addEventListener("touch", retormar)
end

function jogar()
  --scene.view:remove(barreira)
  scene.view:remove(btnJogar)
  scene.view:remove(btnSair)
  scene.view:remove(btnCreditos)
  scene.view:remove(btnComoJogar)
  scene.view:remove(titulo1)
  scene.view:remove(titulo2)

  audio.stop(1)

  pontuacao = 0

  aumentarNivel()

  local somGongo = audio.loadStream(caminhoDiretorioSom .. "gongo.wav" )
  audio.play(somGongo, {loops = 0, channel=2, fadein=1000})
  audio.setVolume(0.50 , { channel=2 })

  local somVento = audio.loadStream(caminhoDiretorioSom .. "wind.ogg" )
  audio.play(somVento, {loops = -1, channel = 3, fadeout=1000})
  audio.setVolume( 0.20 , { channel=2 })


  local somVento2 = audio.loadStream(caminhoDiretorioSom .. "wind3.ogg" )
  audio.play(somVento2, {loops = -1, channel = 4, fadeout=1000})
  audio.setVolume( 0.10 , { channel=4 })

  local somFundo = audio.loadStream(caminhoDiretorioSom .. "background-sound.wav" )
  audio.play(somFundo, {loops = -1, channel = 5, fadeout=100})
  audio.setVolume( 0.30 , { channel=5 })


  exibirTextos()

  local removeTsuru = function(obj)
    display.remove(obj)
    obj = nil
  end

  tsuruInicio = tsuru3

  tsuru1:play()
  tsuru2:play()
  tsuru3:play()

  --transição tsurus
  transition.to(tsuru1, {time = calculaTempo(tsuru1.x), x = CENTRO_X - 400, y = tsuru1.y, tag="transicao", onComplete=removeTsuru})
  transition.to(tsuru2, {time = calculaTempo(tsuru2.x), x = CENTRO_X - 400, y = tsuru2.y, tag="transicao", onComplete=removeTsuru})
  transition.to(tsuru3, {time = calculaTempo(tsuru3.x), x = CENTRO_X- 400, y = tsuru3.y, tag="transicao", onComplete=removeTsuru})

  --Adiciona manipulador ao toque
  tsuru1.touch = selecionarTsuru
  tsuru2.touch = selecionarTsuru
  tsuru3.touch = selecionarTsuru

  tsuru1:addEventListener("touch", tsuru1)
  tsuru2:addEventListener("touch", tsuru2)
  tsuru3:addEventListener("touch", tsuru3)

--  adicionarTsurusCall = adicionarTsurus(true)


  -- Adicionar tsurus
   transicao = true
   adicionarTsurus()
   tsuruTimer =  timer.performWithDelay(frequencia, adicionarTsurus, 0)
  -- Adicionar Ori
  -- adicionarOri()

  -- Atualizar cena
   Runtime:addEventListener('enterFrame', inspesionador)
  -- Runtime:addEventListener("enterFrame", scrollingMontanhas)
end

function calculaTempo(valorX)
    return (valorX - (CENTRO_X - 400))/velocidade
end


-- Adicionar Tsurus
function adicionarTsurus()
    local tsurus = {}

    if(contadorTsurus == limiteNivel) then
        novoNivel()
    end

    embaralhar(cores)
    embaralhar(formas)

    local cor1 = cores[1]
    local cor2 = cores[2]
    local cor3 = cores[3]

    local forma1 = formas[1]
    local forma2 = formas[2]
    local forma3 = formas[3]

    local tsuru1Sheet = graphics.newImageSheet(caminhoDiretorioImagens .. "tsurus/" .. forma1 .. "/tsuru_" .. cor1 .. ".png", options )
    local tsuru2Sheet = graphics.newImageSheet(caminhoDiretorioImagens .. "tsurus/" .. forma2 .. "/tsuru_" .. cor2 .. ".png", options )
    local tsuru3Sheet = graphics.newImageSheet(caminhoDiretorioImagens .. "tsurus/" .. forma3 .. "/tsuru_" .. cor3 .. ".png", options )

    --Adiciona três tsurus
    --Adiciona tsuru no topo
    --tsuru1 = display.newRect(0,0,90,60)
    tsuru1 = display.newSprite(tsuru1Sheet, tsurusAnim)
    --tsuru1.fill = {type="image", filename=caminhoDiretorioImagens .. "tsurus/" .. forma1 .. "/tsuru_" .. cor1 .. ".png"}
    tsuru1.cor = cor1
    tsuru1.forma = forma1
    tsuru1.id = 1
    tsuru1.isFullResolution = true
    physics.addBody(tsuru1, "kinematic")
    scene.view:insert(tsuru1)

    --Adiciona tsuru no meio
    --tsuru2 = display.newRect(0,0,90,60)
    tsuru2 = display.newSprite(tsuru2Sheet, tsurusAnim)
    --tsuru2.fill = {type="image", filename=caminhoDiretorioImagens .. "tsurus/" .. forma2 .. "/tsuru_" .. cor2 .. ".png"}
    tsuru2.cor = cor2
    tsuru2.forma = forma2
    tsuru2.id = 2
    tsuru2.isFullResolution = true
    physics.addBody(tsuru2, "kinematic")
    scene.view:insert(tsuru2)

    --Adiona tsuru ao fundo
    --tsuru3 = display.newRect(0,0,90,60)
    tsuru3 = display.newSprite(tsuru3Sheet, tsurusAnim)
    --tsuru3.fill = {type="image", filename=caminhoDiretorioImagens .. "tsurus/" .. forma3 .. "/tsuru_" .. cor3 .. ".png"}
    tsuru3.cor = cor3
    tsuru3.forma = forma3
    tsuru3.id = 3
    tsuru3.isFullResolution = true
    physics.addBody(tsuru3, "kinematic")
    scene.view:insert(tsuru3)


  --[[  print("tsuru1 = " .. caminhoDiretorioImagens .. "tsurus/" .. forma1 .. "/tsuru_" .. cor1 .. ".png")
    print("tsuru2 = " .. caminhoDiretorioImagens .. "tsurus/" .. forma2 .. "/tsuru_" .. cor2 .. ".png")
    print("tsuru3 = " .. caminhoDiretorioImagens .. "tsurus/" .. forma3 .. "/tsuru_" .. cor3 .. ".png")
    print(".............................................")
    print(" ") print(" ")]]


    if(transicao) then
      tsuru1.x = LARGURA_TELA + 40
      tsuru1.y = ALTURA_TELA - 230
      tsuru1:play()

      tsuru2.x = LARGURA_TELA + 150
      tsuru2.y = ALTURA_TELA - 300
      tsuru2:play()

      tsuru3.x = LARGURA_TELA + 180
      tsuru3.y = ALTURA_TELA - 160
      tsuru3:play()

      local removeTsuru = function(obj)
        display.remove(obj)
        obj = nil
      end

      --transição tsurus
      transition.to(tsuru1, {time = calculaTempo(tsuru1.x), x = CENTRO_X - 400, y = tsuru1.y, tag="transicao", onComplete=removeTsuru})
      transition.to(tsuru2, {time = calculaTempo(tsuru2.x), x = CENTRO_X - 400, y = tsuru2.y, tag="transicao", onComplete=removeTsuru})
      transition.to(tsuru3, {time = calculaTempo(tsuru3.x), x = CENTRO_X - 400, y = tsuru3.y, tag="transicao", onComplete=removeTsuru})

      --Adiciona manipulador ao toque
      tsuru1.touch = selecionarTsuru
      tsuru2.touch = selecionarTsuru
      tsuru3.touch = selecionarTsuru

      tsuru1:addEventListener("touch", tsuru1)
      tsuru2:addEventListener("touch", tsuru2)
      tsuru3:addEventListener("touch", tsuru3)
    else
      tsuru1.x = CENTRO_X + 100
      tsuru1.y = CENTRO_Y - 20

      tsuru2.x = CENTRO_X + 180
      tsuru2.y = CENTRO_Y - 100

      tsuru3.x = CENTRO_X + 200
      tsuru3.y = CENTRO_Y + 50
    end

    --adiciona tsurus a um grupo
  --[[  grupoImagens:insert(tsuru1)
    grupoImagens:insert(tsuru2)
    grupoImagens:insert(tsuru3)
]]
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
    tsuruInicio = nil

  -- Move Ori para o tsuru tocado
  if((event.phase == "began" and salto) and (primeiraEscolha or ((self.x > ori.x) and (self.x < (ori.x +  450))))) then
    primeiraEscolha = false
  --  transition.to(tsuru, {time = 7000, x = -150, y = tsuru.y, tag="transicao"})
    ori.x = self.x
    ori.y = self.y - 25

    local terminaJogo = function(obj)
      fimDeJogo()
    end

    transition.cancel(ori)
    transition.to(ori, {time = calculaTempo(self.x), x = CENTRO_X - 400, y = ori.y, tag="transicao", onComplete=terminaJogo})

    diferenciar(self)

    totalTsurusSaltados = totalTsurusSaltados + 1

    aumentarDistancia()

    removerTsurusNaoSelecionados(self.id)

    trocaTsurus(self)

    ganharPonto(event)
  end
end


function trocaTsurus(self)
  local auxSheet = graphics.newImageSheet(caminhoDiretorioImagens .. "tsurus/tsuru_neutro.png", options )
  local aux = display.newSprite(auxSheet, tsurusAnim)
  aux.x = self.x
  aux.y = self.y
  aux:play()
  physics.addBody(aux, "kinematic")
  grupoImagens:insert(aux)

  local removeTsuru = function(obj)
    display.remove(obj)
    obj = nil
  end

  self.alpha = 0
  transition.to(aux, {time = calculaTempo(self.x), x = CENTRO_X - 400, y = self.y, tag="transicao", onComplete=removeTsuru})
  --self.fill = {type="image", filename=caminhoDiretorioImagens .. "tsurus/forma1/tsuru_preto.png"}]
end


function diferenciar(TsuruAtual)
  local diferente = true
  local somTsuru

  if(regraDiferenciacao == "cor") then
    if(TsuruAtual.cor == ultimaCorSelecionada) then
      diferente = false
    end
  else
    if(TsuruAtual.forma == ultimaFormaSelecionada) then
      diferente = false
    end
  end

  if(diferente) then
    somTsuru = audio.loadStream(caminhoDiretorioSom .. "bird.wav" )
    audio.play(somTsuru, {fadeout=100})
  else
      somTsuru = audio.loadStream(caminhoDiretorioSom .. "cricket.wav" )
      audio.play(somTsuru, {fadeout=100, onComplete=fimDeJogo})
  end

  ultimaCorSelecionada = TsuruAtual.cor
  ultimaFormaSelecionada = TsuruAtual.forma

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
  velocidade = velocidade + .02
  timer.cancel(tsuruTimer)
  frequencia = frequencia - 500
  tsuruTimer =  timer.performWithDelay(frequencia, adicionarTsurus, 0)
end

function inspesionador()
  if((tsuruInicio ~= nil) and tsuruInicio.x < (ori.x - 20)) then
    fimDeJogo()
  end

--fim de jogo
  if(contadorTsurus == 150) then
      finalizar()
  end
end


function ganharPonto(event)
  tempoAtual = event.time/1000
  local diferencaTempo = tempoAtual - ultimoTempo

  if(diferencaTempo < 1.500) then
    pontuacao = pontuacao + 50
  elseif(diferencaTempo > 1.500 and diferencaTempo < 3000) then
      pontuacao = pontuacao + 30
  elseif(diferencaTempo > 3000) then
    pontuacao = pontuacao + 10
  end

  textoPontuacao.text = string.format("%d", pontuacao)
  ultimoTempo = tempoAtual
end


function mostraTextoNovoNivel(nomePlaneta)
 nivelTexto = display.newText(nomePlaneta, display.contentWidth, display.contentHeight, "Origram", 50)
 nivelTexto.x = CENTRO_X
 nivelTexto.y = CENTRO_Y + 100
 nivelTexto.alpha = 0
 scene.view:insert(nivelTexto)
end


function efeitoTextoNovoNivel()
  if (nivelTexto ~= nil) then
    if (nivelTexto.alpha > 0) then
        transition.to(nivelTexto, {time=2000, alpha=0})
    else
        transition.to(nivelTexto, {time=2000, alpha=1})
    end
  end
end


function aumentarNivel()
  mostraTextoNovoNivel("Nível " .. nivel)
  nivelTimer = timer.performWithDelay(2000, efeitoTextoNovoNivel, 2)
  nivel = nivel + 1
end

function novoNivel()
  aumentarNivel()

  aumentarVelocidade()

  limiteNivel = limiteNivel + 30
end


-- Configuração de transição entre cenas
local transicaofimDeJogoConfig = {
	effect = "fade", time = 1000
}


-- Função que chama cena para início do jogo
function fimDeJogo()
  destroi = true
  composer.removeScene("jogo")
  composer.gotoScene("fim_de_jogo", transicaofimDeJogoConfig)
end

function scene:destroy(event)
  local sceneGroup = self.view

  if(destroi) then
    audio.stop(3)
    audio.stop(4)
    audio.stop(5)
    display.remove(grupoImagens)
    transition.cancel("transicao")
    timer.cancel(tsuruTimer)
    timer.cancel(nivelTimer)
    iconePausar:removeEventListener("touch", pausar)
    iconeResume:removeEventListener("touch", retormar)
    Runtime:removeEventListener("enterFrame", inspesionador)
    Runtime:removeEventListener("enterFrame", scrollingMontanhas)
    Runtime:removeEventListener("touch", tsuru1)
    Runtime:removeEventListener("touch", tsuru2)
    Runtime:removeEventListener("touch", tsuru3)
  end
end

function pausar()
  if (toquePausar == false) then
    iconePausar:addEventListener("touch", pausarJogo)
    toquePausar = true
  else
    iconeResume:removeEventListener("touch", retormarJogo)
    iconePausar:addEventListener("touch", pausarJogo)
  end
end

function pausarJogo(event)
  if (event.phase == "began" and iconePausar.alpha == 1) then
   transition.pause("transicao")
   timer.pause(tsuruTimer)
   timer.pause(nivelTimer)
   physics.pause()
   salto = false
   audio.pause(3)
   audio.pause(4)
   audio.pause(5)
   audio.pause(2)

   iconePausar.alpha = 0
   iconeResume.alpha = 1
  end
end

function retormar()
  if (toquePausar == true) then
    iconePausar:removeEventListener("touch", pausar)
    iconeResume:addEventListener("touch", retormarJogo)
  end
end

function retormarJogo(event)
  if (event.phase == "began" and iconeResume.alpha == 1) then
   transition.resume("transicao")
   timer.resume(tsuruTimer)
   timer.resume(nivelTimer)
   physics.start(true)
   salto = true
   audio.resume(3)
   audio.resume(4)
   audio.resume(5)
   audio.resume(2)

   iconePausar.alpha = 1
   iconeResume.alpha = 0
  end
end


-- Fechar app
function fecharApp()
      composer.removeScene("menu")

       if(system.getInfo("platformName")=="Android") then
           native.requestExit()
       else
           os.exit()
      end
end


-- Configuração de transição entre cenas
local transicaoCreditosConfig = {
	effect = "fade", time = 550
}


local transicaoComoJogarConfig = {
	effect = "fade", time = 550
}


local transicaoFinalConfig = {
	effect = "crossFade", time = 550
}


-- Função que chama cena de créditos do jogo
function creditos()
  composer.removeScene("jogo")
	composer.gotoScene("creditos", transicaoCreditosConfig)
end

-- Função que chama cena de créditos do jogo
function comoJogar()
  composer.removeScene("jogo")
	composer.gotoScene("como_jogar", transicaoComoJogarConfig)
end

function finalizar()
  destroi = true
  composer.removeScene("jogo")
  composer.gotoScene("final", transicaoFinalConfig)
end


-- Listener Setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)


return scene
