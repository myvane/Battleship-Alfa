'use strict'

define ['services'], (services) ->
  services.service 'servicioCelda', () ->
    class Celda
      @ESTADO_CELDA_LIBRE = "libre"
      @ESTADO_CELDA_ATACADO = "atacado"
      @ESTADO_CELDA_BLOQUEADO = "bloqueado"

      constructor: (estado = "libre", idBarco = 0) ->
        @estado = estado
        @idBarco = idBarco

      getEstado: () ->
        @estado

      setEstado: (estado) ->
      	@estado = estado

      getIdBarco: () ->
      	@idBarco

      setIdBarco: (idBarco) ->
      	@idBarco = idBarco
