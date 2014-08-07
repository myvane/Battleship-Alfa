'use strict'

define ['services','archivoServicioPieza'], (services) ->
  services.service 'servicioBarco', (servicioPieza) ->
    class Barco
      @ESTADO_BARCO_ATACADO= "atacado"
      @ESTADO_BARCO_COMPLETO = "completo"

      constructor: (identificador, tamanio, url, ancho, alto, orientacion) ->
        @identificador = identificador
        @tamanio = tamanio
        @url = url
        @ancho = ancho
        @alto = alto
        @orientacion = orientacion
        @arregloPiezas = []
        @construirBarco()


      getIdentificador: ->
        @identificador

      getUrl: ->
        @url

      getOrientacion: ->
        @orientacion

      setAncho: (newAncho) ->
        @ancho = newAncho

      setAlto: (newAlto) ->
        @alto = newAlto

      setOrientacion: (tamanio,w,h) ->

        if(@orientacion is "vertical")
          @url = 'images/barco'+tamanio+'H.png'
          @orientacion = "horizontal"
          @setAncho(h)
          @setAlto(w)
        else
          @url = 'images/barco'+tamanio+'V.png'
          @orientacion = "vertical"
          @setAncho(h)
          @setAlto(w)


      construirBarco: ->
        for tam in [1..@tamanio]
          @arregloPiezas.push(new servicioPieza 0, 0, "vivo")

      setPiezas: (arreglos) ->
        arr = []
        arr = arreglos
        tamArreglo = parseInt(arr.length)-2
        for arreglo in [0..tamArreglo]
          @arregloPiezas[arreglo].setFila(arr[arreglo].fila-1)
          @arregloPiezas[arreglo].setColumna(arr[arreglo].columna-1)
          #console.log "piezas" + @arregloPiezas[arreglo].getFila() + "--" + @arregloPiezas[arreglo].getColumna()

      getPiezas: ->
        @arregloPiezas

      getPieza: (indice) ->
        @arregloPiezas[indice]

      getTamanio: ->
        @tamanio

      setPosicionPiezas:(fila, columna) ->
        f = parseInt(fila)
        c = parseInt(columna)
        if @orientacion == "horizontal"
          for indice in [0..@tamanio-1]
            @arregloPiezas[indice].setFila(f)
            @arregloPiezas[indice].setColumna(c)
            c++
        else
          for indice in [0..@tamanio-1]
            @arregloPiezas[indice].setFila(f)
            @arregloPiezas[indice].setColumna(c)
            f++

      atacar: (fila, columna) ->
        resultadoAtaque = "ataque-fallido"
        indicePieza = @indicePiezaEnPosicion(fila, columna)
        if(indicePieza >= 0)
          pieza = @arregloPiezas[indicePieza]
          pieza.atacar()
          if(@cantidadPiezasVivas() == 0)
            resultadoAtaque = "barco-hundido"
          else
            resultadoAtaque = "pieza-atacada"
        alert(resultadoAtaque)
        return resultadoAtaque

      indicePiezaEnPosicion: (fila, columna) ->
        indice = 0;
        encontrado = false
        while(indice < @arregloPiezas.length && !encontrado)
          pieza = @arregloPiezas[indice]
          if(pieza.getFila() == fila && pieza.getColumna() == columna)
            encontrado = true
          else
            indice++
        if encontrado == false
          indice = -1
        return indice

      cantidadPiezasVivas: ->
        vivos = 0
        for pieza in @arregloPiezas
          if pieza.getEstado() == "vivo"
            vivos++
        return vivos

        ###getExistePieza: (fila, columna) ->
        res = false
        for i in @arregloPiezas
          if(i.getFila() is fila && i.getColumna() is columna)
            res = true
        return res
      ###

