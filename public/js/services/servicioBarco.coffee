'use strict'

define ['services','archivoServicioPieza'], (services) ->
  services.service 'servicioBarco', (servicioPieza) ->

    # Clase Barco, clase para crear objeto Barco
    #
    class Barco

      # Constante estado barco atacado
      @ESTADO_BARCO_ATACADO= 'atacado'

      # Constante estado barco completo
      @ESTADO_BARCO_COMPLETO = 'completo'

      # Construye un objeto Barco.
      #
      # @param [Integer] identificador es un numero entero que sirve para
      #   identificar al barco
      # @param [Integer] tamanio del barco, representa a la cantidad de
      #   piezas que tiene el barco
      # @param [String] url es la ruta hacia el archivo de imagen
      # @param [Integer] ancho es el valor del ancho de la imagen
      # @param [Integer] alto es es valor del alto de la imagen
      # @param [String] orientacion es el valor para la orientacion del barco.
      #   Sus valores pueden ser "vertical" u "horizontal"
      #
      constructor: (identificador, tamanio, url, ancho, alto, orientacion) ->
        @identificador = identificador
        @tamanio = tamanio
        @url = url
        @ancho = ancho
        @alto = alto
        @orientacion = orientacion
        @arregloPiezas = []
        @construirBarco()

      # Devuelve el identificador del Barco.
      #
      # @return [Integer] identificador del barco
      #
      getIdentificador: ->
        @identificador

      # Devuelve la ruta al archivo de imagen del Barco.
      #
      # @return [String] ruta del archivo de imagen
      #
      getUrl: ->
        @url

      # Devuelve la orientacion del Barco.
      #
      # @return [String] orientacion del barco. Los valores pueden ser
      #   'vertical' u 'horizontal'
      #
      getOrientacion: ->
        @orientacion

      # Modifica el valor del ancho de la imagen.
      #
      # @param [Integer] newAncho es el nuevo valor del ancho de la imagen
      #
      setAncho: (newAncho) ->
        @ancho = newAncho

      # Modifica el valor del alto de la imagen.
      #
      # @param [Integer] newAlto es el nuevo valor del alto de la imagen
      #
      setAlto: (newAlto) ->
        @alto = newAlto

      # Modifica la orientaicion del barco.
      #
      # @param [Integer] tamanio es el tamanio del barco
      # @param [Integer] w es el ancho del barco
      # @param [Integer] h el esl alto del barco
      #
      setOrientacion: (tamanio,w,h) ->

        if(@orientacion is 'vertical')
          @url = "images/barco#{tamanio}H.png"
          @orientacion = 'horizontal'
          @setAncho(h)
          @setAlto(w)
        else
          @url = "images/barco#{tamanio}V.png"
          @orientacion = 'vertical'
          @setAncho(h)
          @setAlto(w)

      # Construye un barco.
      #
      construirBarco: ->
        for tam in [1..@tamanio]
          @arregloPiezas.push(new servicioPieza 0, 0, 'vivo')

      # Modifica las piezas del barco.
      #
      # @param [Array] arreglos es una lista de piezas
      #
      setPiezas: (arreglos) ->
        arr = []
        arr = arreglos
        tamArreglo = parseInt(arr.length)-2
        for arreglo in [0..tamArreglo]
          @arregloPiezas[arreglo].setFila(arr[arreglo].fila-1)
          @arregloPiezas[arreglo].setColumna(arr[arreglo].columna-1)

      # Devuelve la lista de piezas del Barco.
      #
      # @retun [Array] lista de piezad del Barco
      #
      getPiezas: ->
        @arregloPiezas

      # Devuelve un pieza dal barco dado el indice.
      #
      # @param [Integer] indice es el indice de la Pieza en la lista
      # @return [Object] objeto Pieza de la lista de piezas
      getPieza: (indice) ->
        @arregloPiezas[indice]

      # Devuelve el tamanio del Barco
      #
      # @return [Integer] tamanio del barco
      #
      getTamanio: ->
        @tamanio

      # Cambia la posicion de las piezas
      #
      # @param [Integer] fila es la posicion de la fila en la tabla
      # @param [Integer] columna es la posicion de la columna en la tabla
      #
      setPosicionPiezas:(fila, columna) ->
        f = parseInt(fila)
        c = parseInt(columna)
        if @orientacion == 'horizontal'
          for indice in [0..@tamanio-1]
            @arregloPiezas[indice].setFila(f)
            @arregloPiezas[indice].setColumna(c)
            c++
        else
          for indice in [0..@tamanio-1]
            @arregloPiezas[indice].setFila(f)
            @arregloPiezas[indice].setColumna(c)
            f++

      # Realiza un ataque a una pieza del Barco si la pieza se encuentra
      # en la fila y columna pasadas como parametro y evuelve el resultado
      # del ataque.
      #
      # @param [Integer] fila es la fila de la pieza donde se desea atacar
      # @param [Integer] columna es la columna de la pieza donde se desea
      #   atacar
      # @return [String] resultado del ataque realizado. Sus valores pueden
      #   ser:
      #     'ataque-fallido' si ninguna pieza a sido atacada
      #     'barco-hundido'  si despues del ataque ya no existen piezas
      #                      vivas en el barco
      #     'pieza-atacada'  si despues del ataque un una pieza a sido
      #                      atacada y aun existen piezas vivas
      #
      atacar: (fila, columna) ->
        resultadoAtaque = 'ataque-fallido'
        indicePieza = @indicePiezaEnPosicion(fila, columna)
        if(indicePieza >= 0)
          pieza = @arregloPiezas[indicePieza]
          pieza.atacar()
          if(@cantidadPiezasVivas() == 0)
            resultadoAtaque = 'barco-hundido'
          else
            resultadoAtaque = 'pieza-atacada'
        return resultadoAtaque

      # Devuelve el indice de la pieza que se encuentra en la fila y columna
      # pasadas como parametros
      #
      # @param [Integer] fila es la fila en la tabla
      # @param [Integer] columna es la columna en la tabla
      # @return [Integer] indice de la pieza. Si no existe la pieza en la
      # fila y columna, entonces devuelve -1
      #
      indicePiezaEnPosicion: (fila, columna) ->
        indice = 0
        encontrado = false
        while(indice < @arregloPiezas.length && !encontrado)
          pieza = @arregloPiezas[indice]
          if(pieza.getFila() == fila && pieza.getColumna() == columna)
            encontrado = true
          else
            indice++
        if encontrado == false
          indice = -1
        return indice

      # Devuelve la cantidad de piezas vivas en el Barco
      #
      # @return [Integer] cantidad de pieza vivas
      #
      cantidadPiezasVivas: ->
        vivos = 0
        for pieza in @arregloPiezas
          if pieza.getEstado() == 'vivo'
            vivos++
        return vivos

      # Devuelve el estado del Barco. El barco esta vivo si aun existen piezas
      # viva, muerto en caso de que ya no existan piezas vivas.
      #
      # @return [String] estado del Barco. sus valores pueden ser:
      #     'vivo' si es que ecisten piezas vivas
      #     'muerto' si no existen piezas vivas
      #
      estadoBarco: ->
        estado = "vivo"
        if(@cantidadPiezasVivas() == 0)
          estado = "muerto"
        return estado
