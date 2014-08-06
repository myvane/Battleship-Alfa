'use strict'

define ['services'], (services) ->
  services.service 'servicioPieza', () ->
    class Pieza
      constructor: (fila, columna, estado) ->
        @fila = fila
        @columna = columna
        @estado = estado

      getFila: ->
        @fila

      setFila: (nuevaFila) ->
        @fila = nuevaFila

      getColumna: ->
        @columna

      setColumna: (nuevaColumna) ->
        @columna = nuevaColumna

      getEstado: ->
        @estado

      setEstado: (nuevoestado) ->
        @estado = nuevoestado

      atacar: () ->
        if(@estado == "vivo")
          @estado = "muerto"
