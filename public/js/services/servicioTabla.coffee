'use strict'

define ['services','archivoServicioCelda'], (services) ->
  services.service 'servicioTabla', (servicioCelda) ->
    class Tabla
      constructor: (dimension) ->
        @dimension = dimension
        @celdas = @construirTabla(@dimension)
        @barcos = []

      
      construirTabla: (dimension) ->
        tabla = new Array(dimension)
        for fila in tabla
          fila = new Array(dimension)
          for celda in fila
            celda = new servicioCelda()
        return tabla

      agregarBarco: (barco)->
        @barcos.push(barco)
        @actualizarTabla()

      actualizarTabla: ->
        for barco in barcos
          piezas = barco.getPiezas()
          for pieza in piezas
            celda = @celdas[pieza.getFila()][pieza.getColumna()]
            celda.setIdBarco(barco.getId)

      setDimension: (dimension)->
        @dimension = dimension
      
      setEstadoCelda: (fila, columna, estado)->
        celda = @celdas[fila][columna]
        celda.setEstadoCelda(estado) 

      getDimension: ->
        return @dimension

