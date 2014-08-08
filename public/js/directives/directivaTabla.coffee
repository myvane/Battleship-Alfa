'use strict'

define ['directives'], (directives) ->
  directives.directive 'tablajuego', () ->
    restrict: 'E'
    link: (scope, element, attrs) ->

      # Devuelve codigo html que contiene la cebecera de la tabla para la
      # vista.
      # 
      # @param [Integer] cantidadColumnas es la cantidad de conlumnas que
      #   tiene la tabla
      # @return [Object] objeto DOM con el thead de una tabla html
      #
      scope.crearCabeceraTabla = (cantidadColumnas) ->
        thead = document.createElement('thead')
        tr = document.createElement('tr')
        th = document.createElement('th')
        th.classList.add('header')
        tr.appendChild(th)
        for columna in [1..cantidadColumnas]
          th = document.createElement('th')
          th.classList.add('header')
          th.innerHTML = columna
          tr.appendChild(th)
        thead.appendChild(tr)
        return thead

      # Devuelve elementos del DOM del tbody de una tabla que contiene las
      # celdas de la tabla
      #
      # @param [Integer] cantidadFilas es la cantidad de filas de la tabla
      # @param [Integer] idJugador es el identificador del jugagor
      # @return [Object] objeto DOM con el tbody de una tabla html
      #
      scope.crearContenidoTabla = (cantidadFilas, idJugador) ->
        tbody = document.createElement('tbody')
        for fila in [1..cantidadFilas]
          tr = document.createElement('tr')
          for columna in [0..cantidadFilas]
            td = document.createElement('td')
            if(columna == 0)
              td.innerHTML = fila
              td.classList.add('header')
            else
              div = document.createElement('div')
              div.id = ("div-#{fila}-#{columna}-#{idJugador}")
              div.classList.add('celda')
              td.appendChild(div)
            tr.appendChild(td)
          tbody.appendChild(tr)
        return tbody

      # Crea una tabla HTML
      #
      # @param [Object] objetoTabla es un objeto Tabla
      # @return [Object] objeto DOM de la tabla HTML
      #
      scope.crearTabla = (objetoTabla) ->
        dimension = objetoTabla.getDimension()
        idJugador = objetoTabla.getIdJugador()

        tabla = document.createElement('table')
        tabla.id = "tabla-#{idJugador}"
        thead = scope.crearCabeceraTabla(dimension)
        tbody = scope.crearContenidoTabla(dimension, idJugador)

        tabla.appendChild(thead)
        tabla.appendChild(tbody)

        return tabla

      # Devuelve el valor del contenido en el textfield con id 'fila'
      #
      # @return [String] valor del contenido que se encuentra en el
      #   textfield ocn id 'fila'
      #
      scope.directivaGetFilaAtaque = ->
        fila = document.getElementById('fila').value


      # Devuelve el valor del contenido en el textfield con id 'columna'
      #
      # @return [String] valor del contenido que se encuentra en el
      #   textfield ocn id 'columna'
      #
      scope.directivaGetColumnaAtaque = ->
        columna = document.getElementById('columna').value


      # Agrega una clase al div del jugador que se enuentra en la fila y
      # columna pasadas como parametro de acuerdo al resultado de ataque.
      #
      # @param [Integer] fila es la fila de la vista
      # @param [Integer] columna es la columna de la vista
      # @param [String] resultadoAtaque es el resultado del ataque realizado
      #   en la tabla
      # @param [String] idJugador es el identificador del jugador
      #
      scope.directivaAtacar = (fila, columna, resultadoAtaque, idJugador) ->
        celda = document.getElementById("div-#{fila}-#{columna}-#{idJugador}")
        if(resultadoAtaque == 'ataque-fallido')
          celda.classList.add('atacado')
        else
          if(resultadoAtaque == 'pieza-atacada' || resultadoAtaque == 'barco-hundido')
            celda.classList.add('barco-atacado')

      idTabla = attrs.id
      objetoTabla = scope.tablaJugador
      if(idTabla == 'enemigo')
        objetoTabla = scope.tablaEnemigo
      tablaHTML = scope.crearTabla(objetoTabla)
      element.append(tablaHTML)
