'use strict'

define ['services'], (services) ->
  services.service 'servicioCelda', () ->

    # Clase Celda, representa a una celda de la Tabla
    #
    class Celda

      # Constante estado celda libre
      @ESTADO_CELDA_LIBRE = 'libre'

      # Constante estado celda atacado
      @ESTADO_CELDA_ATACADO = 'atacado'

      # Constante estado celda bloqueado
      @ESTADO_CELDA_BLOQUEADO = 'bloqueado'

      # Construye un objeto Celda
      #
      # @param [String] estado el estado de la celda. El valor por defecto es
      #   'libre' lo cual significa la celda esta libre
      # @param [Integer] idBarco identificador del barco. El valor por defecto
      #    es 0 y significa que no existe barco
      #
      constructor: (estado = 'libre', idBarco = 0) ->
        @estado = estado
        @idBarco = idBarco

      # Devuelve el estado de la celda
      #
      # @return [String] estado de la celda
      #
      getEstado: ->
        @estado

      # Modifica el estado de la celda
      #
      # @param [String] estado es el nuevo estado de la celda
      #
      setEstado: (estado) ->
        @estado = estado

      # Devuelve el identificador del barco
      #
      # @return [Integer] identificador del barco
      #
      getIdBarco: ->
        @idBarco

      # Modifica el identificador del barco
      #
      # @param [Integer] idBarco es el identificador del barco
      #
      setIdBarco: (idBarco) ->
        @idBarco = idBarco
