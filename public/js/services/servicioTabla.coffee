'use strict'

define ['services','archivoServicioCelda', 'archivoServicioBarco'], (services) ->
  services.service 'servicioTabla', (servicioCelda, servicioBarco) ->
    class Tabla

      constructor: (idJugador, dimension) ->
        @idJugador = idJugador
        @dimension = dimension
        @celdas = @construirTabla(@dimension)
        @barcos = new Array()

      construirTablaEnemigo: ->
        @generarMatrizBarcos()

      construirTabla: (dimension) ->
        tabla = new Array(dimension)
        for fila in [0..dimension-1]
          tabla[fila] = Array(dimension)
          for columna in [0..dimension-1]
            tabla[fila][columna] = new servicioCelda("libre",0)
        return tabla

      agregarBarco: (barco) ->
        @barcos.push(barco)
        @actualizarTabla()

      actualizarTabla: ->
        for barco in barcos
          piezas = barco.getPiezas()
          for pieza in piezas
            celda = @celdas[pieza.getFila()][pieza.getColumna()]
            celda.setIdBarco(barco.getId())

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

      # Comprueba si la cola de un barco se sale del tablero
      # retorna un boolean, true si se sale y false en caso contrario
      estaDentroPerimetro: (fila, columna, barco) ->
        fila =  parseInt(fila)
        columna = parseInt(columna)
        res = false
        tamanio = barco.getTamanio()
        posicion = columna + tamanio-1
        if barco.getOrientacion() == "horizontal"
         if posicion < @dimension
          res = true
        else if (fila + tamanio-1) < @dimension
          res = true
        else
          res = false
        return res

      bloqueoHorizontal: (fila, columna, barco) ->
        fila =  parseInt(fila)
        columna = parseInt(columna)

        f = parseInt(fila - 1)
        c = parseInt(columna - 1)
        contadorTamanio = 1

        while contadorTamanio <= barco.getTamanio()+2
          if (f >= 0 and c >= 0) and (f < @dimension and c < @dimension)
            @celdas[f][c].setEstado(servicioCelda.ESTADO_CELDA_BLOQUEADO)
          if (f+2 >= 0 and c >= 0) and (f+2 < @dimension and c < @dimension)
            @celdas[f + 2][c].setEstado(servicioCelda.ESTADO_CELDA_BLOQUEADO)
          c++
          contadorTamanio++
        if columna - 1 > 0
          @celdas[fila][columna-1].setEstado(servicioCelda.ESTADO_CELDA_BLOQUEADO)
        if (columna + barco.getTamanio()) < @dimension
          @celdas[fila][columna+barco.getTamanio()].setEstado(servicioCelda.ESTADO_CELDA_BLOQUEADO)

      bloqueoVertical: (fila, columna, barco)->
        fila =  parseInt(fila)
        columna = parseInt(columna)

        f = parseInt(fila-1)
        c = parseInt(columna - 1)
        tamanio = 1
        while tamanio <= barco.getTamanio()+2
          if (f >= 0 and c >= 0) and (f < @dimension and c < @dimension)
            @celdas[f][c].setEstado(servicioCelda.ESTADO_CELDA_BLOQUEADO)
          if (f >= 0 and (c+2) >= 0) and (f < @dimension and (c+2) < @dimension)
            @celdas[f][c+2].setEstado(servicioCelda.ESTADO_CELDA_BLOQUEADO)
          f++
          tamanio++
        if fila-1 > 0
          @celdas[fila-1][columna].setEstado(servicioCelda.ESTADO_CELDA_BLOQUEADO)
        if (fila + barco.getTamanio()) < @dimension
          @celdas[fila + barco.getTamanio()][columna].setEstado(servicioCelda.ESTADO_CELDA_BLOQUEADO)

      # Verifica si existe espacio para insertar un barco en posicion horizontal
      # retorna un boolean, true si existe espacio y false en caso contrario
      existeEspacioHorizontal: (fila, columna, barco)->
        fila =  parseInt(fila)
        columna = parseInt(columna)
        tamanio = barco.getTamanio()
        res = true
        col = columna
        frente = (columna + tamanio-1)

        while res == true and col  <= frente
          if @celdas[fila][col].getEstado() == servicioCelda.ESTADO_CELDA_BLOQUEADO
            res = false
          col++
        return res

      existeEspacioVertical: (fila, columna, barco) ->
        fila =  parseInt(fila)
        columna = parseInt(columna)

        tamanio = barco.getTamanio()
        res = true
        fil = fila
        while res == true and  fil <= (fila + tamanio-1)
          if @celdas[fil][columna].getEstado() == servicioCelda.ESTADO_CELDA_BLOQUEADO
            res = false
          fil++
        return res
        
      bloquearBarco: (fila,columna,barco) ->
        fila =  parseInt(fila)
        columna = parseInt(columna)
        if barco.getOrientacion() == "horizontal"
          @bloqueoHorizontal(fila,columna,barco)
        else
          @bloqueoVertical(fila,columna,barco)

      verificarEspacioBarco: (fila, columna,barco)->
        fila =  parseInt(fila)
        columna = parseInt(columna)
        res = false
        if barco.getOrientacion() is "horizontal"
           res=  @existeEspacioHorizontal(fila,columna,barco)
        else
           res =@existeEspacioVertical(fila,columna,barco)
        return res

      insertarBarco: (fila, columna, barco) ->
        fila =  parseInt(fila)
        columna = parseInt(columna)
        if barco.getOrientacion() == "horizontal"
          tamanio = columna + barco.getTamanio()-1
          for indice in [columna..tamanio]
            @celdas[fila][indice].setIdBarco(barco.getIdentificador())
            @celdas[fila][indice].setEstado(servicioCelda.ESTADO_CELDA_BLOQUEADO)
        else
          tamanio = fila + barco.getTamanio()-1
          for indice in [fila..tamanio]
            @celdas[indice][columna].setIdBarco(barco.getIdentificador())
            @celdas[indice][columna].setEstado(servicioCelda.ESTADO_CELDA_BLOQUEADO)

      coordenadaAleatoria: ->

        fil = Math.floor(Math.random()*@dimension)
        col = Math.floor(Math.random()*@dimension)
        return "#{fil}-#{col}"

      generarMatrizBarcos: ->
        #for indice in [0..(@dimension-1)]
        @barcos[0] = new servicioBarco(1, 4, "./images/barco4H.png", 30, 120, "horizontal")
        @barcos[1] = new servicioBarco(2, 3, "./images/barco3V.png", 90, 30, "vertical")
        @barcos[2] = new servicioBarco(3, 3, "./images/barco3H.png", 30, 90, "horizontal")
        @barcos[3] = new servicioBarco(4, 2, "./images/barco2V.png", 60, 30, "vertical")
        @barcos[4] = new servicioBarco(5, 2, "./images/barco2H.png", 30, 60, "horizontal")
        @barcos[5] = new servicioBarco(6, 2, "./images/barco2V.png", 60, 30, "vertical")
        @barcos[6] = new servicioBarco(7, 1, "./images/barco1H.png", 30, 30, "horicontal")
        @barcos[7] = new servicioBarco(8, 1, "./images/barco1H.png", 30, 30, "horizontal")
        @barcos[8] = new servicioBarco(9, 1, "./images/barco1V.png", 30, 30, "vertical")
        @barcos[9] = new servicioBarco(10, 1, "./images/barco1V.png", 30, 30, "vertical")

      llenarTabla: ->
        coordenada = @coordenadaAleatoria()
        fila = parseInt( coordenada.charAt(0))
        columna = parseInt(coordenada.charAt(2))

        for barco in @barcos
          insertado = false
          while insertado == false
            if @estaDentroPerimetro(fila, columna, barco) == true
              if @verificarEspacioBarco(fila,columna,barco) == true
                @insertarBarco(fila,columna,barco)
                @bloquearBarco(fila,columna,barco)
                barco.setPosicionPiezas(fila,columna)
                insertado = true
              else
                coordenada = @coordenadaAleatoria()
                fila = parseInt(coordenada.charAt(0))
                columna = parseInt(coordenada.charAt(2))
            else
              coordenada = @coordenadaAleatoria()
              fila = parseInt(coordenada.charAt(0))
              columna =parseInt(coordenada.charAt(2))

      mostrarTabla: ->
        res = ""
        for fila in [0..(@dimension-1)]
          for columna in [0..(@dimension-1)]
            if @celdas[fila][columna].getEstado() == servicioCelda.ESTADO_CELDA_BLOQUEADO
              res += "B"
            else
              res += "0"
          res += "  ->#{fila}"

        return res

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
