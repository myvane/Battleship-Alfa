'use strict'

define [
    'services','archivoServicioCelda'
    'archivoServicioBarco'
    ], (services) ->
  services.service 'servicioTabla', (servicioCelda, servicioBarco) ->
    
    # Clase base para creacion de tablas de juego.
    #
    # @example Crear un objeto Tabla
    #   tabla = new Tabla ("nombreJugador", "tamanioTabla")
    #
    class Tabla
    
      # Constructor una nueva tabla.
      #
      # @param [String] nombre del Jugador
      # @param [Integer] tamanio de la tabla
      #
      constructor: (idJugador, dimension) ->
        @idJugador = idJugador
        @dimension = dimension
        @celdas = @construirTabla(@dimension)
        @barcos = new Array()
      

      # Construye una tabla con Barcos posicionados.
      #
      construirTablaEnemigo: ->
        @generarMatrizBarcos()
        @llenarTabla()

      # Construir una Tabla vacia.
      #
      # @param [Integer] tamanio de la tabla
      #
      construirTabla: (dimension) ->
        tabla = new Array(dimension)
        for fila in [0..(dimension-1)]
          tabla[fila] = Array(dimension)
          for columna in [0..(dimension-1)]
            tabla[fila][columna] = new servicioCelda("libre",0)
        return tabla

      # Agrega un barco a una lista de barcos.
      #
      # @param [Object] caracteristicas de un Barco
      #
      agregarBarco: (barco) ->
        @barcos.push(barco)

      # Cambia el tamanio de la Dimension de la Tabla.
      #
      # @param [Integer] tamanio del barco
      #
      setDimension: (dimension)->
        @dimension = dimension
        
      # Obtiene el estado de una celda de la tabla dado un a posicion.
      #
      # @param [Integer] fila, poscision fila
      # @param [Integer] columna, posicion columna
      #
      # @return [String] estado de una celda
      #
      getEstadoCelda: (fila, columna) ->
        celda = @celdas[fila][columna]
        celda.getEstado()

      # Cambia el estado de una celda en la tabla.
      #
      # @param [Integer] fila, poscision fila
      # @param [Integer] columna, posicion columna
      # @param [String] estado, el nuevo estado
      #
      setEstadoCelda: (fila, columna, estado)->
        celda = @celdas[fila][columna]
        celda.setEstado(estado)

      # Cambia el Identificador del Barco en una celda de la tabla.
      #
      # @param [Array] arreglo, arreglo de celdas que compone un barco
      #
      setIdBarcoCelda: (arreglo)->
        for arr in [0..arreglo.length-2]
          celda = @celdas[arreglo[arr].fila-1][arreglo[arr].columna-1]
          celda.setIdBarco(arreglo[arr].idBarco)

      # Obtiene el tamanio de la tabla.
      #
      # @return [Integer] dimension, es el tamanio de la tabla.
      #
      getDimension: ->
        return @dimension

      # Comprueba si la cola de un barco se sale del tablero
      #
      # @param [Integer] fila, poscision fila
      # @param [Integer] columna, posicion columna
      # @param [Object] barco, barco a ser analizado
      #
      # @return [Boolean] TRUE si se sale del perimetro de la tabla
      # y false en caso contrario.
      #
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

      # Bloquea el perimetro de celdas en una tabla dado un barco de
      # orientcion horizontal.
      #
      # @param [Integer] fila, poscision fila
      # @param [Integer] columna, posicion columna
      # @param [Object] barco, barco a ser posicionado
      #
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
          @celdas[fila][columna-1]
            .setEstado(servicioCelda.ESTADO_CELDA_BLOQUEADO)
        if (columna + barco.getTamanio()) < @dimension
          @celdas[fila][columna+barco.getTamanio()]
            .setEstado(servicioCelda.ESTADO_CELDA_BLOQUEADO)

      # Bloquea el perimetro de celdas en una tabla dado un barco de
      # orientcion vertical.
      #
      # @param [Integer] fila, poscision fila
      # @param [Integer] columna, posicion columna
      # @param [Object] barco, barco a ser posicionado
      #
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
          @celdas[fila-1][columna]
            .setEstado(servicioCelda.ESTADO_CELDA_BLOQUEADO)
        if (fila + barco.getTamanio()) < @dimension
          @celdas[fila + barco.getTamanio()][columna]
            .setEstado(servicioCelda.ESTADO_CELDA_BLOQUEADO)

      # Comprueba si existe espacio horizontal en la tabla para
      # posicionar un barco horizontal
      #
      # @param [Integer] fila, posicion fila
      # @param [Integer] columna, posicion columna
      # @param [Object] barco, barco a ser analizado
      #
      # @return [Boolean] TRUE si existe esapcio en la tabla y false en
      # caso contrario.
      #
      existeEspacioHorizontal: (fila, columna, barco)->
        fila =  parseInt(fila)
        columna = parseInt(columna)
        tamanio = barco.getTamanio()
        res = true
        col = columna
        frente = (columna + tamanio-1)

        while res == true and col  <= frente
          if @celdas[fila][col].getEstado() == 'bloqueado'
            res = false
          col++
        return res

      # Comprueba si existe espacio vertical en la tabla para posicionar
      # un barco vertical
      #
      # @param [Integer] fila, posicion fila
      # @param [Integer] columna, posicion columna
      # @param [Object] barco, barco a ser analizado
      #
      # @return [Boolean] TRUE si existe esapcio en la tabla y false en
      # caso contrario.
      #
      existeEspacioVertical: (fila, columna, barco) ->
        fila =  parseInt(fila)
        columna = parseInt(columna)

        tamanio = barco.getTamanio()
        res = true
        fil = fila
        while res == true and  fil <= (fila + tamanio-1)
          if @celdas[fil][columna].getEstado() == 'bloqueado'
            res = false
          fil++
        return res
        
      # Bloquea el perimetro de un barco de cualquier orientacion
      #
      # @param [Integer] fila, posicion fila
      # @param [Integer] columna, posicion columna
      # @param [Object] barco, barco a ser posicionado
      #
      bloquearBarco: (fila,columna,barco) ->
        fila =  parseInt(fila)
        columna = parseInt(columna)
        if barco.getOrientacion() == "horizontal"
          @bloqueoHorizontal(fila,columna,barco)
        else
          @bloqueoVertical(fila,columna,barco)

      # Verifica si es posible insertar un barco de cualquier orientacion
      # en una posicion en la tabla.
      #
      # @param [Integer] fila, posicion fila
      # @param [Integer] columna, posicion columna
      # @param [Object] barco, barco a ser posicionado
      #
      verificarEspacioBarco: (fila, columna,barco)->
        fila =  parseInt(fila)
        columna = parseInt(columna)
        res = false
        if barco.getOrientacion() is 'horizontal'
          res=  @existeEspacioHorizontal(fila,columna,barco)
        else
          res =@existeEspacioVertical(fila,columna,barco)
        return res

      # Inserta un barco en una posicion dada en la tabla.
      #
      # @param [Integer] fila, posicion fila
      # @param [Integer] columna, posicion columna
      # @param [Object] barco, barco a ser posicionado
      #
      insertarBarco: (fila, columna, barco) ->
        fila =  parseInt(fila)
        columna = parseInt(columna)
        if barco.getOrientacion() == "horizontal"
          tamanio = columna + barco.getTamanio()-1
          for indice in [columna..tamanio]
            @celdas[fila][indice].setIdBarco(barco.getIdentificador())
            @celdas[fila][indice]
              .setEstado(servicioCelda.ESTADO_CELDA_BLOQUEADO)
        else
          tamanio = fila + barco.getTamanio()-1
          for indice in [fila..tamanio]
            @celdas[indice][columna].setIdBarco(barco.getIdentificador())
            @celdas[indice][columna]
              .setEstado(servicioCelda.ESTADO_CELDA_BLOQUEADO)

      
      # Genera una coordenada aleatoria de una Tabla.
      #
      # @return [String] "fila-columna", contiene la fila y columna
      # separados por el caracter "-"
      #
      coordenadaAleatoria: ->
        fil = Math.floor(Math.random()*@dimension)
        col = Math.floor(Math.random()*@dimension)
        return "#{fil}-#{col}"

      # Llena la lista de barcos "barcos".
      #
      generarMatrizBarcos: ->
        #for indice in [0..(@dimension-1)]
        @barcos[0] = new servicioBarco(1, 4, './images/barco4H.png',
                                       30, 120, 'horizontal')
        @barcos[1] = new servicioBarco(2, 3, './images/barco3V.png',
                                       90, 30, 'vertical')
        @barcos[2] = new servicioBarco(3, 3, './images/barco3H.png',
                                       30, 90, 'horizontal')
        @barcos[3] = new servicioBarco(4, 2, './images/barco2V.png',
                                       60, 30, 'vertical')
        @barcos[4] = new servicioBarco(5, 2, './images/barco2H.png',
                                       30, 60, 'horizontal')
        @barcos[5] = new servicioBarco(6, 2, './images/barco2V.png',
                                       60, 30, 'vertical')
        @barcos[6] = new servicioBarco(7, 1, './images/barco1H.png',
                                       30, 30, 'horizontal')
        @barcos[7] = new servicioBarco(8, 1, './images/barco1H.png',
                                       30, 30, 'horizontal')
        @barcos[8] = new servicioBarco(9, 1, './images/barco1V.png',
                                       30, 30, 'vertical')
        @barcos[9] = new servicioBarco(10, 1, './images/barco1V.png',
                                       30, 30, 'vertical')

      
      # Llena la tabla aleatoriamente de barcos.
      #
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

      # Obtiene una lista de Barcos.
      #
      # @return [Array] barcos, lista de Objetos Barco
      #
      getBarcos: ->
        @barcos

      # Obtiene una lista de Barcos.
      #
      # @return [String] idJugador, identificador del jugador
      #
      getIdJugador: ->
        @idJugador

      # Verifica si una fila y columna son validas dentro la tabla.
      #
      # @param [Integer] fila, posicion fila
      # @param [Integer] columna, posicion columna
      #
      # @return [Boolean] respuesta, TRUE si se encuentra dentro la
      # tabla false en caso contrario
      #
      filaColumnaValidas: (fila, columna) ->
        respuesta = false
        if((fila >= 0 && fila < @dimension) &&
            (columna >= 0 && columna < @dimension))
          respuesta = true
        return respuesta

      # Comprueba si es posible atacar una posicion en la tabla.
      #
      # @param [Integer] fila, posicion fila
      # @param [Integer] columna, posicion columna
      #
      # @return [Boolean] respuesta, TRUE si es posible atacar false
      # en caso contrario
      #
      esPosibleAtacar: (fila, columna) ->
        respuesta = false
        if(@filaColmnaValidas(fila, columna))
          celda = @celdas[fila][columna]
          if(celda.getEstado() == 'libre')
            respuesta = true
        return respuesta

      # Realiza un ataque a un tablero.
      #
      # @param [Integer] fila, posicion fila
      # @param [Integer] columna, posicion columna
      #
      # @return [String] resultadoAtaque, una cadena que puede ser:
      #                 "ataque-fallido" o  "ataque-repetido"
      #
      atacar: (fila, columna) ->
        resultadoAtaque = 'ataque-erroneo'
        if(@filaColumnaValidas(fila, columna))
          celda = @celdas[fila][columna]
          if(celda.getEstado() == 'libre' || celda.getEstado() == 'bloqueado')
            resultadoAtaque = 'ataque-exitoso'
            nuevoEstadoCelda = 'atacado'
            idBarco = celda.getIdBarco()
            if(idBarco > 0)
              resultadoAtaque = @atacarBarco(fila, columna, idBarco)
              if(resultadoAtaque != 'ataque-fallido')
                nuevoEstadoCelda = resultadoAtaque
            else
              resultadoAtaque = 'ataque-fallido'
            @celdas[fila][columna].setEstado(nuevoEstadoCelda)
          else
            resultadoAtaque = 'ataque-repetido'
        return resultadoAtaque

      # Realiza un ataque a un barco.
      #
      # @param [Integer] fila, posicion fila
      # @param [Integer] columna, posicion columna
      # @param [String] idBarco, identificador del barco
      #
      # @return [String] resultadoAtaque, una cadena puede ser:
      #                 "ataque-fallido", "barco-hundido" o "pieza-atacada"
      #
      atacarBarco: (fila, columna, idBarco) ->
        indiceBarco = @getIndiceBarco(idBarco)
        resultadoAtaque = 'ataque-fallido'
        if(indiceBarco >= 0)
          barco = @barcos[indiceBarco]
          resultadoAtaque = barco.atacar(fila, columna)
        return resultadoAtaque

      # Obtiene el identificador de un barco.
      #
      # @param [Integer] idBarco, identificador del barco
      #
      # @return [Integer] indice, identificador del barco
      #
      getIndiceBarco: (idBarco) ->
        indice = 0
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

      # Obtiene una cadena con el contenido de la tabla.
      #
      # @return [String] res, cadena con la informacion del contenido
      # de la tabla
      #
      mostrarTabla: ->
        res = '\n'
        for fila in @celdas
          for celda in fila
            if celda.getIdBarco() != 0
              res += '#{celda.getIdBarco()}'
            else
              res += '-'
          res += '\n'
        return res

      # Obtiene la cantidad de barcos vivos.
      #
      # @return [Integer] total, total de barcos vivos
      #
      totalBarcosVivos: ->
        total = 0
        for barco in @barcos
          if barco.estadoBarco() == 'vivo'
            total++
        return total


