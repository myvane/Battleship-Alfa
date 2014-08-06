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
          @arregloPiezas.push(new servicioPieza 0, 0, true)
          #@arregloPiezas.push(1)

      getPiezas: ->
        @arregloPiezas

      getPieza: (indice) ->
        alert(@arregloPiezas.length)
        @arregloPiezas[indice]

      getTamanio: ->
        @tamanio

      setPosicionPiezas:(fila, columna) ->
        f = parseInt(fila)
        c = parseInt(columna)
        if @orientacion = "horizontal"
          for indice in [0..@tamanio-1]
            pieza[indice].setFila(f)
            pieza[indice].setColumna(c)
            c++
        else
          for indice in [0..@tamanio-1]
            pieza[indice].setFila(f)
            pieza[indice].setColumna(c)
            f++


