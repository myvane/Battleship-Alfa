'use strict'

define ['services','archivoServicioCelda'], (services) ->
  services.service 'servicioTabla', (servicioCelda) ->
    class Tabla
      constructor: (idJugador, dimension) ->
        @idJugador = idJugador
        @dimension = dimension
        @celdas = @construirTabla(@dimension)
        @barcos = new Array()


      construirTabla: (dimension) ->
        tabla = new Array(dimension)
        for fila in [0..(dimension-1)]
          tabla[fila] = new Array(dimension)
          for columna in [0..(dimension-1)]
            tabla[fila][columna] = new servicioCelda()
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

      getEstadoCelda: (fila, columna) ->
        celda = @celdas[fila][columna]
        celda.getEstado()

      setEstadoCelda: (fila, columna, estado)->
        celda = @celdas[fila][columna]
        celda.setEstado(estado)

      getDimension: ->
        return @dimension

      getBarcos: () ->
        @barcos

      getIdJugador: ->
        @idJugador

      filaColumnaValidas: (fila, columna) ->
        respuesta = false
        if((fila >= 0 && fila < @dimension) && (columna >= 0 && columna < @dimension))
          respuesta = true
        return respuesta

      esPosibleAtacar: (fila, columna) ->
        respuesta = false
        if(@filaColmnaValidas(fila, columna))
          celda = @celdas[fila][columna]
          if(celda.getEstado() == "libre")
            respuesta = true
        return respuesta

      atacar: (fila, columna) ->
        resultadoAtaque = "ataque-erroneo"
        if(@filaColumnaValidas(fila, columna))
          celda = @celdas[fila][columna]
          if(celda.getEstado() == "libre")
            resultadoAtaque = "ataque-exitoso"
            nuevoEstadoCelda = "atacado"
            idBarco = celda.getIdBarco()
            if(idBarco > 0)
              resultadoAtaque = @atacarBarco(fila, columna, idBarco)
              if(resultadoAtaque != "ataque-fallido")
                nuevoEstadoCelda = resultadoAtaque
            else
              resultadoAtaque = "ataque-fallido"
            @celdas[fila][columna].setEstado(nuevoEstadoCelda)
          else
            resultadoAtaque = "ataque-repetido"
        return resultadoAtaque

      atacarBarco: (fila, columna, idBarco) ->
        indiceBarco = @getIndiceBarco(idBarco)
        resultadoAtaque = "ataque-fallido"
        if(indiceBarco >= 0)
          barco = @barcos[indiceBarco]
          resultadoAtaque = barco.atacar(fila, columna)
        return resultadoAtaque

      getIndiceBarco: (idBarco) ->
        indice = -1
        encontrado = false
        while indice < @barcos.length && !encontrado
          barco = @barcos[indice]
          if barco.getIdentificador() == idBarco
            encontrado = true
          else
            indice++
        if !encontrado
          indice = -1
        return indice

        ###getExistePiezaBarco: (fila, columna) ->
        res = null
        for i in @barcos
          if(i.getExistePieza(fila, columna))
            res = i
        return res
      ###


