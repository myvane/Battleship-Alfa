'use strict'

define ['services'], (services) ->
  services.service 'servicioPieza', () ->

    # Clase pieza. Clase para crear objeto pieza
    #
    class Pieza

      # construir un objeto pieza
      #
      # @fila [Integer] posicion de una pieza en el eje x de un tablero
      # @columna [Integer] posicion de una pieza en el eje y de un tablero
      # @estado [String] cada pieza se construye por defecto con estado "vivo"
      #
      constructor: (fila, columna, estado='vivo') ->
        @fila = fila
        @columna = columna
        @estado = estado

      # Obtener la fila de una pieza
      #
      # @fila [Integer] Fila de una pieza
      #
      getFila: ->
        @fila
      
      # Modificar la fila de una pieza
      #
      # nuevaFila [Integer] nuevo valor para la fila de una pieza
      #
      setFila: (nuevaFila) ->
        @fila = nuevaFila

      # Obtener la columna de una pieza
      #
      # @columna [Integer] Columna de una pieza
      #
      getColumna: ->
        @columna
      
      # Modificar la fila de una pieza
      #
      # nuevaColumna [Integer] nuevo valor para la columna de una pieza
      #
      setColumna: (nuevaColumna) ->
        @columna = nuevaColumna
      
      # Obtener el estado de una pieza
      #
      # @estado [String] Estado de una pieza
      #
      getEstado: ->
        @estado
      
      # Modificar la fila de una pieza
      #
      # nuevoEstado [String] nuevo valor para el estado de una pieza
      #
      setEstado: (nuevoEstado) ->
        @estado = nuevoEstado
      
      # Cambia el estado de una pieza al ser atacada
      #
      atacar: ->
        if(@estado == 'vivo')
          @estado = 'muerto'