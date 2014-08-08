'use strict'

arregloCeldasDesahabilitadas = []
arregloBarcos = []
tamBarco = 0
verticalidad = ""
idBarco = 0
dimension = 0
idDiv = 0
habilitadoBotonJuego = true
habilitarFuncionalidad = true

# Verifica si el identificador del barco esta en
# el arreglo de celdas desabilitadas
#
# @idB [Integer] identificador de un Barco
#
verificarIdBarcoEstaArreglo = (idB) ->
  res = false
  for item in arregloCeldasDesahabilitadas
    if item.idBarco is idB
      res = true
  return res

# Elimina las posiciones desabilitadas de un barco
#
# @idB [Integer] identificador de un Barco
#
eliminarPosBarco = (idB) ->
  if arregloCeldasDesahabilitadas.length > 0
    if(verificarIdBarcoEstaArreglo(idB))
      arregloTemporal = []
      arregloCeldasD = parseInt(arregloCeldasDesahabilitadas.length)-1
      for num in [0..arregloCeldasD]
        if(arregloCeldasDesahabilitadas[num].idBarco != idB)
          arregloTemporal.push(arregloCeldasDesahabilitadas[num])
      if(arregloCeldasDesahabilitadas.length != arregloTemporal.length)
        arregloCeldasDesahabilitadas = arregloTemporal

# Verifica si el identificador del barco esta en
# el arreglo de barcos
#
# @idB [Integer] identificador de un Barco
#
verificarIdBarcoEstaArregloBarcos = (idB) ->
  res = false
  for item in arregloBarcos
    if item.idBarco is idB
      res = true
  return res

# Elimina barcos de un arreglo de barcos si esque este se mueve
#
# @idBarco2 [Integer] identificador de un Barco
#
eliminarBarcos = (idBarco2) ->
  if arregloBarcos.length > 0
    if(verificarIdBarcoEstaArregloBarcos(idBarco2))
      arregloTemporal = []
      arregloCeldasD = parseInt(arregloBarcos.length)-1
      for num in [0..arregloCeldasD]
        if(arregloBarcos[num].idBarco != idBarco2)
          arregloTemporal.push(arregloBarcos[num])
      if(arregloBarcos.length != arregloTemporal.length)
        arregloBarcos = arregloTemporal

# Verifica si todos los barcos estan el tablero para poder empezar el juego
#
verificarCantidadBarcosTablero = () ->
  if(arregloBarcos.length is 30)
    habilitadoBotonJuego = false

# Agrega al arreglo de celdas deshabilitadas
# las posiciones donde un barco esta posecionado
# mas las posiciones adyacentes a ese barco
#
# @idBarco2 [Integer] identificador de un Barco
# @idCelda [String] identificador de una celda
# @fila [Integer] posicion de una pieza en el eje x de un tablero
# @columna [Integer] posicion de una pieza en el eje y de un tablero
#
agregarPosicionCeldas = (idBarco2, idCelda, fila, columna) ->
  eliminarPosBarco(idBarco2)
  eliminarBarcos(idBarco2)
  if(verticalidad is 'vertical')
    #--------cabeza-------------
    #agrego pocicion inicial
    obj = {
      idBarco:idBarco2
      idCelda: idCelda
      fila: fila
      columna: columna
    }
    arregloCeldasDesahabilitadas.push(obj)
    arregloBarcos.push(obj)

    #desabilita lado izquierdo de esa celda
    columnaIzquierda = parseInt(columna)-1
    obj = {
      idBarco:idBarco2
      idCelda: "div-#{fila}-#{columnaIzquierda}"
      fila: fila
      columna: columnaIzquierda
    }
    arregloCeldasDesahabilitadas.push(obj)

    #desabilita lado derecho de esa celda
    columnaDerecha = parseInt(columna)+1
    obj = {
      idBarco:idBarco2
      idCelda: "div-#{fila}-#{columnaDerecha}"
      fila: fila
      columna: columnaDerecha
    }
    arregloCeldasDesahabilitadas.push(obj)

    #---------fila -1 ---------------
    #desabilito columna -1 de pos inicial
    filaMenos1 = parseInt(fila)-1
    obj = {
      idBarco:idBarco2
      idCelda: "div-#{filaMenos1}-#{columna}"
      fila: filaMenos1
      columna: columna
    }
    arregloCeldasDesahabilitadas.push(obj)

    #desabilita lado izquierdo de esa celda
    columnaIzquierda = parseInt(columna)-1
    obj = {
      idBarco:idBarco2
      idCelda: "div-#{filaMenos1}-#{columnaIzquierda}"
      fila: filaMenos1
      columna: columnaIzquierda
    }
    arregloCeldasDesahabilitadas.push(obj)

    #desabilita lado derecho de esa celda
    columnaDerecha = parseInt(columna)+1
    obj = {
      idBarco:idBarco2
      idCelda: "div-#{filaMenos1}-#{columnaDerecha}"
      fila: filaMenos1
      columna: columnaDerecha}
    arregloCeldasDesahabilitadas.push(obj)

    #-------for para desabilitar columna +1 ---------
    for tam in [1..tamBarco]
      fila = parseInt(fila)+1
      #desabilita lado izquierdo de esa celda
      columnaIzquierda = parseInt(columna)-1
      obj = {
        idBarco:idBarco2
        idCelda: "div-#{fila}-#{columnaIzquierda}"
        fila: fila
        columna: columnaIzquierda
      }
      arregloCeldasDesahabilitadas.push(obj)

      #desabilita lado derecho de esa celda
      columnaDerecha = parseInt(columna)+1
      obj = {
        idBarco:idBarco2
        idCelda: "div-#{fila}-#{columnaDerecha}"
        fila: fila
        columna: columnaDerecha}
      arregloCeldasDesahabilitadas.push(obj)

      #desabilita celda central
      obj = {
        idBarco:idBarco2
        idCelda: "div-#{fila}-#{columna}"
        fila: fila
        columna: columna
      }
      arregloCeldasDesahabilitadas.push(obj)
      arregloBarcos.push(obj)

  else if(verticalidad is 'horizontal')
    #-------------cabeza-----------------
    #agrego pocicion inicial
    obj = {
      idBarco:idBarco2
      idCelda: idCelda
      fila: fila
      columna: columna
    }
    arregloCeldasDesahabilitadas.push(obj)
    arregloBarcos.push(obj)

    #desabilita una celda arriba de esa celda
    filaArriba = parseInt(fila)-1
    obj = {
      idBarco:idBarco2
      idCelda: "div-#{filaArriba}-#{columna}"
      fila: filaArriba
      columna: columna
    }
    arregloCeldasDesahabilitadas.push(obj)

    #desabilita una celda abajo de esa celda
    filaAbajo = parseInt(fila)+1
    obj = {
      idBarco:idBarco2
      idCelda: "div-#{filaAbajo}-#{columna}"
      fila: filaAbajo
      columna: columna
    }
    arregloCeldasDesahabilitadas.push(obj)

    #------------- columna -1 --------------
    #agrego pocicion inicial
    columnaMenos1 = parseInt(columna)-1
    obj = {
      idBarco:idBarco2
      idCelda: "div-#{fila}-#{columnaMenos1}"
      fila: fila
      columna: columnaMenos1
    }
    arregloCeldasDesahabilitadas.push(obj)

    #desabilita una celda arriba de esa celda
    filaArriba = parseInt(fila)-1
    obj = {
      idBarco:idBarco2
      idCelda: "div-#{filaArriba}-#{columnaMenos1}"
      fila: filaArriba
      columna: columnaMenos1
    }
    arregloCeldasDesahabilitadas.push(obj)

    #desabilita una celda abajo de esa celda
    filaAbajo = parseInt(fila)+1
    obj = {
      idBarco:idBarco2
      idCelda: "div-#{filaAbajo}-#{columnaMenos1}"
      fila: filaAbajo
      columna: columnaMenos1
    }
    arregloCeldasDesahabilitadas.push(obj)

    #----- for para desabilitar columna +1 ------------
    for tam in [1..tamBarco]
      columna = parseInt(columna)+1
      #desabilita una celda arriba de esa celda
      filaArriba = parseInt(fila)-1
      obj = {
        idBarco:idBarco2
        idCelda: "div-#{filaArriba}-#{columna}"
        fila: filaArriba
        columna: columna
      }
      arregloCeldasDesahabilitadas.push(obj)

      #desabilita una celda abajo de esa celda
      filaAbajo = parseInt(fila)+1
      obj = {
        idBarco:idBarco2
        idCelda: "div-#{filaAbajo}-#{columna}"
        fila: filaAbajo
        columna: columna
      }
      arregloCeldasDesahabilitadas.push(obj)

      #desabilita la celda central
      obj = {
        idBarco:idBarco2
        idCelda: "div-#{fila}-#{columna}"
        fila: fila
        columna: columna
      }
      arregloCeldasDesahabilitadas.push(obj)
      arregloBarcos.push(obj)
  verificarCantidadBarcosTablero()

# Verifica si una celda esta desabilitada para
# poder posecionar un barco
#
# @id [Integer] identificador de una Celda
#
verificarCeldasDesabilitadas = (id) ->
  res = true
  sp = id.split("-")
  idFinal = id
  columnaFinal = sp[2]
  filaFinal = sp[1]
  if verticalidad is 'horizontal'
    columnaFinal = parseInt(sp[2])+parseInt(tamBarco)-1
    idFinal = "div-#{sp[1]}-#{columnaFinal}"
  if verticalidad is 'vertical'
    filaFinal = parseInt(sp[1])+parseInt(tamBarco)-1
    idFinal = "div-#{filaFinal}-#{sp[2]}"
  if((filaFinal > dimension) || (columnaFinal > dimension))
    res = false
  for i in arregloCeldasDesahabilitadas
    if !(i.idBarco is idBarco)
      if(i.idCelda is idFinal)
        res = false
      if (i.idCelda is id)
        res = false
  return res

# Funcion de HTML5 que permite que un objeto se posecione
#
# @ev [Event] evento de interfaz
#
allowDrop = (ev) ->
  ev.preventDefault()

# Funcion de HTML5 que permite que un objeto se mueva
#
# @item [Integer] identificador de un Barco
# @ev [Event] evento de interfaz
#
drag = (item, ev) ->
  ev.dataTransfer.setData('Text' , ev.target.id)

# Funcion de HTML5 que permite que un objeto pueda contener a otro
#
# @item [String] identificador de una Celda
# @ev [Event] evento de interfaz
#
drop = (item, ev) ->
  ev.preventDefault()
  idSplite = item.id.split("-")
  nuevoId = "div-#{idSplite[1]}-#{idSplite[2]}"
  if(habilitarFuncionalidad)
    if(verificarCeldasDesabilitadas(nuevoId))
      agregarPosicionCeldas(idBarco,nuevoId,idSplite[1],idSplite[2])
      data = ev.dataTransfer.getData('Text')
      ev.target.appendChild(document.getElementById(data))

# Verifica si al rotar un barco este no choque con otro
#
# @identificadorDiv [String] identificador de una celda
#
verificarCeldasAlRotar = (identificadorDiv) ->
  res = true
  sp = identificadorDiv.split("-")
  idFinal = identificadorDiv
  columnaFinal = sp[2]
  filaFinal = sp[1]
  if verticalidad is 'vertical'
    columnaFinal = parseInt(sp[2])+parseInt(tamBarco)-1
    idFinal = "div-#{sp[1]}-#{columnaFinal}"
  if verticalidad is 'horizontal'
    filaFinal = parseInt(sp[1])+parseInt(tamBarco)-1
    idFinal = "div-#{filaFinal}-#{sp[2]}"
  if((filaFinal > dimension) || (columnaFinal > dimension))
    res = false
  for i in arregloCeldasDesahabilitadas
    if !(i.idBarco is idBarco)
      if(i.idCelda is idFinal)
        res = false
  return res

define ['controllers', 'archivoServicioBarco','archivoServicioTabla',
          'archivoDirectivaTabla'], (controllers) ->
  controllers.controller 'controladorTabla', ($scope,
    servicioBarco, servicioTabla) ->
    #Creando los objetos barco para el Tablero Jugador
    $scope.barco1 = new servicioBarco(1, 1, 'images/barco1H.png',
      30, 30, 'horizontal')
    $scope.barco2 = new servicioBarco(2, 1, 'images/barco1H.png',
      30, 30, 'horizontal')
    $scope.barco3 = new servicioBarco(3, 1, 'images/barco1H.png',
      30, 30, 'horizontal')
    $scope.barco4 = new servicioBarco(4, 1, 'images/barco1H.png',
      30, 30, 'horizontal')
    $scope.barco5 = new servicioBarco(5, 2, 'images/barco2H.png',
      60, 30, 'horizontal')
    $scope.barco6 = new servicioBarco(6, 2, 'images/barco2H.png',
      60, 30, 'horizontal')
    $scope.barco7 = new servicioBarco(7, 2, 'images/barco2H.png',
      60, 30, 'horizontal')
    $scope.barco8 = new servicioBarco(8, 3, 'images/barco3H.png',
      100, 30, 'horizontal')
    $scope.barco9 = new servicioBarco(9, 3, 'images/barco3H.png',
      100, 30, 'horizontal')
    $scope.barco10 = new servicioBarco(10, 4, 'images/barco4H.png',
      120, 30, 'horizontal')
    $scope.barcos = [
      $scope.barco1
      $scope.barco2
      $scope.barco3
      $scope.barco4
      $scope.barco5
      $scope.barco6
      $scope.barco7
      $scope.barco8
      $scope.barco9
      $scope.barco10
    ]
    #Creando la tabla Jugador
    $scope.tablaJugador = new servicioTabla 'jugador', 10
    $scope.celdas = [1..$scope.tablaJugador.getDimension()]
    dimension = $scope.tablaJugador.getDimension()

    # Funcion para cambiar la orientacion de un barco
    #
    # @barco [Object] objeto Barco
    #
    $scope.cambiarOrientacion = (barco) ->
      if(habilitarFuncionalidad)
        if(idDiv != 0)
          if(verificarCeldasAlRotar(idDiv))
            sp = idDiv.split("-")
            barco.setOrientacion(barco.tamanio, barco.ancho, barco.alto)
            verticalidad = barco.orientacion
            agregarPosicionCeldas(barco.identificador, idDiv, sp[1], sp[2])
        else
          barco.setOrientacion(barco.tamanio, barco.ancho, barco.alto)
          verticalidad = barco.orientacion

    $scope.valor = true
    $scope.valorTablero = true

    # Funcion para obtener el tamanio de un Barco,
    # la verticalidad y el identificador de un barco
    # seleccionado por el mouse
    #
    # @barco [Object] objeto Barco
    #
    $scope.obtenerTamanioBarco = (barco) ->
      $scope.valor = habilitadoBotonJuego
      idBarco = barco.identificador
      verticalidad = barco.orientacion
      tamBarco = barco.tamanio

    # Cambia el identificador de un div a otro seleccionado por mouse
    #
    # @fila [Integer] posicion en el eje x de un tablero
    # @columna [Integer] posicion en el eje y de un tablero
    #
    $scope.cambiarIdDiv = (fila,columna) ->
      idDiv = "div-#{fila}-#{columna}"

    $scope.arregloPosiciones = []

    # Guarda las posiciones de los barcos en el tablero
    # Cambia el identificador de un barco en una celda
    # Cambia la fila, columna de una pieza de acuerdo
    # a su posicion en el tablero
    #
    $scope.guardarValores = () ->
      habilitadoBotonJuego = true
      habilitarFuncionalidad = false
      $scope.valorTablero = false
      $scope.valor = true
      for barco in $scope.barcos
        $scope.tablaJugador.agregarBarco(barco)
      $scope.arregloObjetosBarco = arregloBarcos
      for cont in [0..9]
        arreglo = []
        for barco in $scope.arregloObjetosBarco
          if barco.idBarco is cont+1
            obj = {
              fila: barco.fila
              columna: barco.columna
              idBarco: barco.idBarco
            }
            arreglo.push(obj)
        $scope.barcos[cont].setPiezas(arreglo)
        $scope.tablaJugador.setIdBarcoCelda(arreglo)
      for i in [0..$scope.tablaJugador.getDimension()-1]
        for j in [0..$scope.tablaJugador.getDimension()-1]
          $scope.arregloPosiciones.push({fila: i, columna: j})

    # Genera un numero aleatorio
    #
    # @menor [Integer] numero menor de un rango
    # @mayor [Integer] numero mayor de un rango
    #
    $scope.randomInt = (menor , mayor) ->
      [menor, mayor] = [1 , menor] unless mayor?
      [menor, mayor] = [mayor , menor] if menor > mayor
      Math.floor(Math.random() * (mayor - menor + 1) + menor)

    $scope.piezasPosiblesAtaque = []

    # Funcion aleatoria para atacar al jugador
    #
    $scope.atacarAlJugador = ->
      if $scope.juegoTerminado == false
        posicionAleatoria = null
        if($scope.piezasPosiblesAtaque.length <= 0)
          indiceAleatorio = $scope.randomInt(0 ,
              $scope.arregloPosiciones.length-1)
          posicionAleatoria = $scope.arregloPosiciones[indiceAleatorio]
          $scope.arregloPosiciones.splice(indiceAleatorio, 1)
        else
          posicionAleatoria = $scope.piezasPosiblesAtaque.pop()
        resultadoAtaque = $scope.tablaJugador.atacar(posicionAleatoria.fila,
            posicionAleatoria.columna)
        if(resultadoAtaque != 'ataque-erroneo')
          if(resultadoAtaque == 'ataque-repetido')
            $scope.atacarAlJugador()
          else
            $scope.directivaAtacar(parseInt(posicionAleatoria.fila)+1,
                  parseInt(posicionAleatoria.columna)+1,
                    resultadoAtaque, "jugador")
            if(resultadoAtaque == 'pieza-atacada')
              $scope.piezasPosiblesAtaque = [
                {
                  fila: posicionAleatoria.fila-1
                  columna: posicionAleatoria.columna
                }
                {
                  fila: posicionAleatoria.fila+1
                  columna: posicionAleatoria.columna
                }
                {
                  fila: posicionAleatoria.fila
                  columna: posicionAleatoria.columna-1
                }
                {
                  fila: posicionAleatoria.fila
                  columna: posicionAleatoria.columna+1
                }
              ]
              while($scope.piezasPosiblesAtaque.length > 0 &&
                  resultadoAtaque == 'pieza-atacada')
                posicionAleatoriaAtaque = $scope.randomInt(0 ,
                    $scope.piezasPosiblesAtaque.length - 1)
                posicionAtaque = $scope
                  .piezasPosiblesAtaque[posicionAleatoriaAtaque]
                resultadoAtaque = $scope.tablaJugador.atacar(
                  posicionAtaque.fila,posicionAtaque.columna)
                if resultadoAtaque != 'ataque-erroneo'
                  $scope.directivaAtacar(parseInt(posicionAtaque.fila)+1,
                      parseInt(posicionAtaque.columna)+1,
                        resultadoAtaque, "jugador")
                $scope.piezasPosiblesAtaque.splice(posicionAleatoriaAtaque, 1)
            else
              if(resultadoAtaque == 'barco-hundido')
                $scope.piezasPosiblesAtaque = []
                $scope.atacarAlJugador()
              $scope.directivaAtacar(parseInt(posicionAleatoria.fila)+1,
                  parseInt(posicionAleatoria.columna)+1,
                    resultadoAtaque, "jugador")
        $scope.terminarJuego()

    #Creando la tabla del Enemigo
    $scope.tablaEnemigo = new servicioTabla 'enemigo', 10
    $scope.tablaEnemigo.construirTablaEnemigo()
    $scope.juegoTerminado = false
    $scope.jugadorGanador = 'ninguno'

    # Funcion para atacar al robot
    #
    $scope.atacarAlRobot = ->
      if $scope.juegoTerminado == false
        atacandoRobot = true
        fila = $scope.directivaGetFilaAtaque()
        columna = $scope.directivaGetColumnaAtaque()
        fila = parseInt(fila) - 1
        columna = parseInt(columna) - 1
        resultadoAtaque = $scope.tablaEnemigo.atacar(fila, columna)
        if(resultadoAtaque == 'ataque-erroneo')
          alert('Ataque erroneo')
          atacandoRobot = false
        else
          if(resultadoAtaque == 'ataque-repetido')
            alert('Ataque repetido')
            atacandoRobot = false
          else
            $scope.directivaAtacar(fila+1, columna+1,
              resultadoAtaque, 'enemigo')
            if(resultadoAtaque == 'pieza-atacada')
              atacandoRobot = false
            if(resultadoAtaque == 'barco-hundido')
              atacandoRobot = false
              alert('Barco Hundido')
        $scope.terminarJuego()
        if(atacandoRobot)
          $scope.atacarAlJugador()

    # Funcion para terminaro el juego
    # muestra un mensaje al jugador si gano o perdio
    #
    $scope.terminarJuego = ->
      if($scope.tablaJugador.totalBarcosVivos() ==  0 ||
      $scope.tablaEnemigo.totalBarcosVivos() ==  0 )
        $scope.juegoTerminado = true
        mensaje = ''
        if($scope.tablaJugador.totalBarcosVivos() ==  0)
          $scope.jugadorGanador = 'enemigo'
          mensaje = 'PERDIO EL JUEGO'
        else
          $scope.jugadorGanador = 'jugador'
          mensaje = 'GANASTE EL JUEGO'
        alert "Juego Terminado ¡¡¡ #{mensaje} !!!"