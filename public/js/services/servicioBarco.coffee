'use strict'

define ['services','archivoServicioPieza'], (services,servicioPieza) ->
  services.service 'servicioBarco', () ->
    class Barco
      constructor: (identificador, tamanio, url, ancho, alto, orientacion) ->
        @identificador = identificador
        @tamanio = tamanio
        @url = url
        @ancho = ancho
        @alto = alto
        @orientacion = orientacion

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

      @arregloPiezas
      agregarArregloPieza: ->
        for tam in @tamanio
          pieza = new servicioPieza 0, 0, true
          @arregloPiezas.push(pieza)

      getPiezas: ->
        @arregloPiezas
