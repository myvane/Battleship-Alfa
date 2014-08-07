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

verificarIdBarcoEstaArreglo = (idB) ->
  res = false
  for item in arregloCeldasDesahabilitadas
    if item.idBarco is idB
      res = true
  return res

#elimina las posiciones desabilitadas de un barco si esq este se mueve en la tabla
eliminarPosBarco = (idB) ->
  if arregloCeldasDesahabilitadas.length > 0
    if(verificarIdBarcoEstaArreglo(idB))
      arregloTemporal = []
      arregloCeldasD = parseInt(arregloCeldasDesahabilitadas.length)-1
      #console.log "arrPrim "+arregloCeldasDesahabilitadas.length
      for num in [0..arregloCeldasD]
        #console.log arregloCeldasDesahabilitadas[num].idBarco + " -- " + arregloCeldasDesahabilitadas[num].idCelda
        if(arregloCeldasDesahabilitadas[num].idBarco != idB)
          arregloTemporal.push(arregloCeldasDesahabilitadas[num])
      if(arregloCeldasDesahabilitadas.length != arregloTemporal.length)
        #console.log "arrTemporal"+arregloTemporal.legth
        arregloCeldasDesahabilitadas = arregloTemporal
      #console.log "arrPrim " +arregloCeldasDesahabilitadas.length

verificarIdBarcoEstaArregloBarcos = (idB) ->
  res = false
  for item in arregloBarcos
    if item.idBarco is idB
      res = true
  return res

eliminarBarcos = (idbarco) ->
  if arregloBarcos.length > 0
    if(verificarIdBarcoEstaArregloBarcos(idbarco))
      arregloTemporal = []
      arregloCeldasD = parseInt(arregloBarcos.length)-1
      #console.log "arrPrim "+arregloBarcos.length
      for num in [0..arregloCeldasD]
        #console.log arregloCeldasDesahabilitadas[num].idBarco + " -- " + arregloCeldasDesahabilitadas[num].idCelda
        if(arregloBarcos[num].idBarco != idbarco)
          arregloTemporal.push(arregloBarcos[num])
      if(arregloBarcos.length != arregloTemporal.length)
        #console.log "arrTemporal"+arregloTemporal.length
        arregloBarcos = arregloTemporal
      #console.log "arrPrim " +arregloBarcos.length

verificarCantidadBarcosTablero = () ->
  if(arregloBarcos.length is 30)
    habilitadoBotonJuego = false

#::::::::::::::::::::::funciones para que funcione el drag and drop y el habilitar y deshabilitar celdas
agregarPosicionCeldas = (idbarco, idCelda, fila, columna) ->
  eliminarPosBarco(idbarco)
  eliminarBarcos(idbarco)
  sp = idCelda.split('-')
  idCelda = "div-#{sp[1]}-#{sp[2]}"
  if(verticalidad is "vertical")
    #console.log "entra vertical de agregar"
    #--------------cabeza-------------------------------
    #agrego pocicion inicial
    obj = {idBarco:idbarco ,idCelda: idCelda, fila: fila, columna: columna}
    arregloCeldasDesahabilitadas.push(obj)
    arregloBarcos.push(obj)
    #console.log obj.idCelda + " - " + obj.idBarco

    #desabilita lado izquierdo de esa celda
    columnaIzquierda = parseInt(columna)-1
    obj = {idBarco:idbarco ,idCelda: "div-#{fila}-#{columnaIzquierda}", fila: fila, columna: columnaIzquierda}
    arregloCeldasDesahabilitadas.push(obj)
    #console.log obj.idCelda + " - " + obj.idBarco

    #desabilita lado derecho de esa celda
    columnaDerecha = parseInt(columna)+1
    obj = {idBarco:idbarco ,idCelda: "div-#{fila}-#{columnaDerecha}", fila: fila, columna: columnaDerecha}
    arregloCeldasDesahabilitadas.push(obj)
    #console.log obj.idCelda + " - " + obj.idBarco

    #---------------------fila -1------------------------------------
    #desabilito columna -1 de pos inicial
    filaMenos1 = parseInt(fila)-1
    obj = {idBarco:idbarco ,idCelda: "div-#{filaMenos1}-#{columna}", fila: filaMenos1, columna: columna}
    arregloCeldasDesahabilitadas.push(obj)
    #console.log obj.idCelda + " - " + obj.idBarco

    #desabilita lado izquierdo de esa celda
    columnaIzquierda = parseInt(columna)-1
    obj = {idBarco:idbarco ,idCelda: "div-#{filaMenos1}-#{columnaIzquierda}", fila: filaMenos1, columna: columnaIzquierda}
    arregloCeldasDesahabilitadas.push(obj)
    #console.log obj.idCelda + " - " + obj.idBarco

    #desabilita lado derecho de esa celda
    columnaDerecha = parseInt(columna)+1
    obj = {idBarco:idbarco ,idCelda: "div-#{filaMenos1}-#{columnaDerecha}", fila: filaMenos1, columna: columnaDerecha}
    arregloCeldasDesahabilitadas.push(obj)
    #console.log obj.idCelda + " - " + obj.idBarco

    #----------------for para desabilitar columna +1 en adelante--------------------------
    for tam in [1..tamBarco]
      fila = parseInt(fila)+1
      #desabilita lado izquierdo de esa celda
      columnaIzquierda = parseInt(columna)-1
      obj = {idBarco:idbarco ,idCelda: "div-#{fila}-#{columnaIzquierda}", fila: fila, columna: columnaIzquierda}
      arregloCeldasDesahabilitadas.push(obj)
      #console.log obj.idCelda + " - " + obj.idBarco

      #desabilita lado derecho de esa celda
      columnaDerecha = parseInt(columna)+1
      obj = {idBarco:idbarco ,idCelda: "div-#{fila}-#{columnaDerecha}", fila: fila, columna: columnaDerecha}
      arregloCeldasDesahabilitadas.push(obj)
      #console.log obj.idCelda + " - " + obj.idBarco

      #desabilita celda central
      obj = {idBarco:idbarco ,idCelda: "div-#{fila}-#{columna}", fila: fila, columna: columna}
      arregloCeldasDesahabilitadas.push(obj)
      arregloBarcos.push(obj)
      #console.log obj.idCelda + " - " + obj.idBarco

  else if(verticalidad is "horizontal")
    #console.log "entra horizontal de agregar"
    #------------------------------cabeza--------------------------------
    #agrego pocicion inicial
    obj = {idBarco:idbarco ,idCelda: idCelda, fila: fila, columna: columna}
    arregloCeldasDesahabilitadas.push(obj)
    arregloBarcos.push(obj)
    #console.log obj.idCelda + " - " + obj.idBarco

    #desabilita una celda arriba de esa celda
    filaArriba = parseInt(fila)-1
    obj = {idBarco:idbarco ,idCelda: "div-#{filaArriba}-#{columna}", fila: filaArriba, columna: columna}
    arregloCeldasDesahabilitadas.push(obj)
    #console.log obj.idCelda + " - " + obj.idBarco

    #desabilita una celda abajo de esa celda
    filaAbajo = parseInt(fila)+1
    obj = {idBarco:idbarco ,idCelda: "div-#{filaAbajo}-#{columna}", fila: filaAbajo, columna: columna}
    arregloCeldasDesahabilitadas.push(obj)
    #console.log obj.idCelda + " - " + obj.idBarco

    #------------------------------columna -1--------------------------------
    #agrego pocicion inicial
    columnaMenos1 = parseInt(columna)-1
    obj = {idBarco:idbarco ,idCelda: "div-#{fila}-#{columnaMenos1}", fila: fila, columna: columnaMenos1}
    arregloCeldasDesahabilitadas.push(obj)
    #console.log obj.idCelda + " - " + obj.idBarco

    #desabilita una celda arriba de esa celda
    filaArriba = parseInt(fila)-1
    obj = {idBarco:idbarco ,idCelda: "div-#{filaArriba}-#{columnaMenos1}", fila: filaArriba, columna: columnaMenos1}
    arregloCeldasDesahabilitadas.push(obj)
    #console.log obj.idCelda + " - " + obj.idBarco

    #desabilita una celda abajo de esa celda
    filaAbajo = parseInt(fila)+1
    obj = {idBarco:idbarco ,idCelda: "div-#{filaAbajo}-#{columnaMenos1}", fila: filaAbajo, columna: columnaMenos1}
    arregloCeldasDesahabilitadas.push(obj)
    #console.log obj.idCelda + " - " + obj.idBarco

    #----------------for para desabilitar columna +1 en adelante--------------------------
    for tam in [1..tamBarco]
      columna = parseInt(columna)+1
      #desabilita una celda arriba de esa celda
      filaArriba = parseInt(fila)-1
      obj = {idBarco:idbarco ,idCelda: "div-#{filaArriba}-#{columna}", fila: filaArriba, columna: columna}
      arregloCeldasDesahabilitadas.push(obj)
      #console.log obj.idCelda + " - " + obj.idBarco

      #desabilita una celda abajo de esa celda
      filaAbajo = parseInt(fila)+1
      obj = {idBarco:idbarco ,idCelda: "div-#{filaAbajo}-#{columna}", fila: filaAbajo, columna: columna}
      arregloCeldasDesahabilitadas.push(obj)
      #console.log obj.idCelda + " - " + obj.idBarco

      #desabilita la celda central
      obj = {idBarco:idbarco ,idCelda: "div-#{fila}-#{columna}", fila: fila, columna: columna}
      arregloCeldasDesahabilitadas.push(obj)
      arregloBarcos.push(obj)
      #console.log obj.idCelda + " - " + obj.idBarco
  verificarCantidadBarcosTablero()


verificarCeldasDesabilitadas = (id) ->
  res = true
  sp = id.split("-")
  idFinal = id
  columnaFinal = sp[2]
  filaFinal = sp[1]
  if verticalidad is "horizontal"
    columnaFinal = parseInt(sp[2])+parseInt(tamBarco)-1
    idFinal = "div-#{sp[1]}-#{columnaFinal}"
  if verticalidad is "vertical"
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


allowDrop = (ev) ->
  ev.preventDefault()

drag = (item, ev) ->
  ev.dataTransfer.setData("Text" , ev.target.id)

drop = (item, ev) ->
  ev.preventDefault()
  idSplite = item.id.split("-")
  if(habilitarFuncionalidad)
    if(verificarCeldasDesabilitadas(item.id))
      agregarPosicionCeldas(idBarco,item.id,idSplite[1],idSplite[2])
      data = ev.dataTransfer.getData("Text")
      ev.target.appendChild(document.getElementById(data));
  #console.log "--------------------------------------------" + arregloBarcos.length


verificarCeldasAlRotar = (identificadorDiv) ->
  res = true
  sp = identificadorDiv.split("-")
  idFinal = identificadorDiv
  columnaFinal = sp[2]
  filaFinal = sp[1]
  if verticalidad is "vertical"
    columnaFinal = parseInt(sp[2])+parseInt(tamBarco)-1
    idFinal = "div-#{sp[1]}-#{columnaFinal}"
    #console.log "si es horizontal -" + columnaFinal + "-- " + idFinal
  if verticalidad is "horizontal"
    filaFinal = parseInt(sp[1])+parseInt(tamBarco)-1
    idFinal = "div-#{filaFinal}-#{sp[2]}"
    #console.log "si es vertical -" + filaFinal + "-- " + idFinal
  if((filaFinal > dimension) || (columnaFinal > dimension))
    #console.log "entraaa condicion para q no salga"
    res = false

  for i in arregloCeldasDesahabilitadas
    #console.log idFinal
    if !(i.idBarco is idBarco)
      #console.log "idBarcofor= "+i.idBarco + " es igual barco = " + idBarco
      if(i.idCelda is idFinal)
        #console.log "idCelda="+i.idCelda + "es igual a la cola =" + idFinal
        res = false
    #if (i.idCelda is id)
    #  res = false
  return res


define ['controllers', 'archivoServicioBarco','archivoServicioTabla','archivoDirectivaTabla'], (controllers) ->
  controllers.controller 'controladorTabla', ($scope, servicioBarco, servicioTabla) ->
    $scope.barco1 = new servicioBarco 1, 1, 'images/barco1H.png', 30, 30, "horizontal"
    $scope.barco2 = new servicioBarco 2, 1, 'images/barco1H.png', 30, 30, "horizontal"
    $scope.barco3 = new servicioBarco 3, 1, 'images/barco1H.png', 30, 30, "horizontal"
    $scope.barco4 = new servicioBarco 4, 1, 'images/barco1H.png', 30, 30, "horizontal"
    $scope.barco5 = new servicioBarco 5, 2, 'images/barco2H.png', 60, 30, "horizontal"
    $scope.barco6 = new servicioBarco 6, 2, 'images/barco2H.png', 60, 30, "horizontal"
    $scope.barco7 = new servicioBarco 7, 2, 'images/barco2H.png', 60, 30, "horizontal"
    $scope.barco8 = new servicioBarco 8, 3, 'images/barco3H.png', 100, 30, "horizontal"
    $scope.barco9 = new servicioBarco 9, 3, 'images/barco3H.png', 100, 30, "horizontal"
    $scope.barco10 = new servicioBarco 10, 4, 'images/barco4H.png', 120, 30, "horizontal"
    $scope.barcos = [$scope.barco1,$scope.barco2,$scope.barco3,$scope.barco4,$scope.barco5,$scope.barco6,$scope.barco7,$scope.barco8,$scope.barco9,$scope.barco10]
    $scope.tablaJugador = new servicioTabla "jugador", 10
    $scope.celdas = [1..$scope.tablaJugador.getDimension()]
    dimension = $scope.tablaJugador.getDimension()
    $scope.cambiarOrientacion = (barco) ->
      if(habilitarFuncionalidad)
        if(idDiv != 0)
          if(verificarCeldasAlRotar(idDiv))
            sp = idDiv.split("-")
            barco.setOrientacion(barco.tamanio, barco.ancho, barco.alto)
            verticalidad = barco.orientacion
            #console.log verticalidad
            agregarPosicionCeldas(barco.identificador, idDiv, sp[1], sp[2])
        else
          barco.setOrientacion(barco.tamanio, barco.ancho, barco.alto)
          verticalidad = barco.orientacion

    $scope.setValor = () ->
      $scope.valor = habilitadoBotonJuego

    #---- funcion ng-mousedown
    $scope.obtenerTamanioBarco = (barco) ->
      idBarco = barco.identificador
      verticalidad = barco.orientacion
      tamBarco = barco.tamanio

    $scope.cambiarIdDiv = (fila,columna) ->
      idDiv = "div-#{fila}-#{columna}"

    #funcion que llama el ng-click del boton jugar para cambiar los valores en los servicios
    $scope.guardarValores = () ->
      habilitarFuncionalidad = false
      for barco in $scope.barcos
        $scope.tablaJugador.agregarBarco(barco)
      $scope.arregloObjetosBarco = arregloBarcos
      #barco = {idBarco:idbarco ,idCelda: "div-#{fila}-#{columna}", fila: fila, columna: columna}
      for cont in [0..9]
        arreglo = []
        for barco in $scope.arregloObjetosBarco
          if barco.idBarco is cont+1
            obj = {fila: barco.fila, columna: barco.columna}
            arreglo.push(obj)
        $scope.barcos[cont].setPiezas(arreglo)

#funciones ataque jugador
    $scope.tablaEnemigo = new servicioTabla("enemigo",10)

    $scope.atacar = () ->
      fila = $scope.directivaGetFilaAtaque()
      columna = $scope.directivaGetColumnaAtaque()
      fila = parseInt(fila) - 1
      columna = parseInt(columna) - 1
      resultadoAtaque = $scope.tablaJugador.atacar(fila, columna)
      if(resultadoAtaque == "ataque-erroneo")
        alert("Ataque erroneo")
      else
        if(resultadoAtaque == "ataque-repetido")
          alert("Ataque repetido")
        else
          # resultadoAtaque = 'ataque-erroneo'
          $scope.directivaAtacar(fila+1, columna+1, resultadoAtaque, "enemigo")

#funciones atacar robot
    $scope.randomInt = (menor , mayor) ->
      [menor, mayor] = [1 , menor] unless mayor?
      [menor, mayor] = [mayor , menor] if menor > mayor
      Math.floor(Math.random() * (mayor - menor + 1) + menor)

    $scope.devolverPosicionAleatoria = (objFCInicial, objFCFinal) ->
      $scope.numRandomicoFila = $scope.randomInt(objFCInicial.fila, objFCFinal.fila)
      $scope.numRandomicoColumna = $scope.randomInt(objFCInicial.columna, objFCFinal.columna)
      $scope.objRes = {fila: $scope.numRandomicoFila, columna: $scope.numRandomicoColumna}
      return $scope.objRes

    $scope.bandera = true

    ###$scope.verificarSiHayBarco = (objValorPosicion) ->
      #llamar a directiva para cambiar de color la celda atacada
      $scope.barco = $scope.tabla.getExistePiezaBarco(objValorPosicion.fila, objValorPosicion.columna)
      if($scope.barco?)
        $scope.barco.setPieza()
        #continuar jugando


          #verificar barco
          #si barco.getPiezasVivas == 0 entonses banderaAtaque = false entonses le toca al otro jugador
          #si barco.getPiezasVivas != 0 entonses banderaAtaque = true entonses continuarAtacando
        ###

    $scope.atacarRobot = () ->
      if($scope.bandera)
        $scope.filaColumnaInicial = {fila: 0, columna: 0}
        $scope.filaColumnaFinal = {fila: 9, columna: 9}
        $scope.valorPosicion = $scope.devolverPosicionAleatoria($scope.filaColumnaInicial , $scope.filaColumnaFinal)
        $scope.directivaAtacar($scope.valorPosicion.fila, $scope.valorPosicion.columna, "pieza-atacada", "jugador")
        console.log $scope.valorPosicion
        ###if($scope.estaLibre is "libre")
        else
          console.log "entra else"
          $scope.atacarRobot()
      else
        #este scope se setea en la funcion de atacar jugador
        $scope.bandera = true
  ###