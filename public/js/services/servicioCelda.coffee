'use strict'

define ['services'], (services) ->
  services.service 'servicioCelda', () ->
    class Celda

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
