'use strict'

define ['services'], (services) ->
  services.service 'servicioPieza', () ->
    class Pieza
      constructor: (idBarco, fila, columna, estado) ->
        @idBarco = idBarco
        @fila = fila
        @columna = columna
        @estado = estado

      getIdBarco: ->
        @idBarco

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
