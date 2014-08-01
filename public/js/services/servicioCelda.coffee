'use strict'

define ['services'], (services) ->
  services.service 'servicioCelda', () ->
    class Celda
    	@ESTADO_CELDA_LIBRE = "Libre"
    	@ESTADO_CELDA_ATACADO = "Atacado"

    	constructor: (estado = "Libre", idBarco = 0) ->
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
