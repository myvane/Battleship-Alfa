'use strict'

define ['directives'], (directives) ->
  directives.directive 'tablajuego', () ->
    restrict: 'E'
    link: (scope, element, attrs) ->
      scope.crearCabeceraTabla = (cantidadColumnas) ->
        thead = document.createElement("thead")
        tr = document.createElement("tr")
        th = document.createElement("th")
        th.classList.add('header')
        tr.appendChild(th)
        for columna in [1..cantidadColumnas]
          th = document.createElement("th")
          th.classList.add('header')
          th.innerHTML = columna
          tr.appendChild(th)
        thead.appendChild(tr)
        return thead

      scope.crearContenidoTabla = (cantidadFilas, idJugador) ->
        tbody = document.createElement("tbody")
        for fila in [1..cantidadFilas]
          tr = document.createElement("tr")
          for columna in [0..cantidadFilas]
            td = document.createElement("td")
            if(columna == 0)
              td.innerHTML = fila
              td.classList.add('header')
            else
              div = document.createElement("div")
              div.id = ("div-#{fila}-#{columna}-#{idJugador}")
              div.classList.add('celda')
              td.appendChild(div)
            tr.appendChild(td)
          tbody.appendChild(tr)
        return tbody

      scope.crearTabla = (objetoTabla) ->
        dimension = objetoTabla.getDimension()
        idJugador = objetoTabla.getIdJugador()

        tabla = document.createElement("table")
        tabla.id = "tabla-#{idJugador}"
        thead = scope.crearCabeceraTabla(dimension)
        tbody = scope.crearContenidoTabla(dimension, idJugador)

        tabla.appendChild(thead)
        tabla.appendChild(tbody)

        return tabla

      scope.directivaGetFilaAtaque = () ->
        fila = document.getElementById("fila").value

      scope.directivaGetColumnaAtaque = () ->
        columna = document.getElementById("columna").value

      scope.directivaAtacar = (fila, columna, resultadoAtaque,idJugador) ->
        celda = document.getElementById("div-#{fila}-#{columna}-#{idJugador}")
        if(resultadoAtaque == "ataque-fallido")
          celda.classList.add('atacado')
        else
          # resultadoAtaque = 'ataque-exitoso'
          celda.classList.add('barco-atacado')

      idTabla = attrs.id
      objetoTabla = scope.tablaJugador
      if(idTabla == "enemigo")
        objetoTabla = scope.tablaEnemigo
      tablaHTML = scope.crearTabla(objetoTabla)
      #scope.agregarBarcos(objetoTabla)
      element.append(tablaHTML)
