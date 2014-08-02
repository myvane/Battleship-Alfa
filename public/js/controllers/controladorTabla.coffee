'use strict'

define ['controllers', 'archivoServicioBarco','archivoServicioTabla'], (controllers) ->
  controllers.controller 'controladorTabla', ($scope, servicioBarco, servicioTabla) ->
    $scope.barco1 = new servicioBarco 1, 1, 'images/barco1H.png', 20, 20, "horizontal"
    $scope.barco2 = new servicioBarco 2, 2, 'images/barco2H.png', 40, 20, "horizontal"
    $scope.barco3 = new servicioBarco 3, 2, 'images/barco2H.png', 40, 20, "horizontal"
    $scope.barco4 = new servicioBarco 4, 3, 'images/barco3H.png', 60, 20, "horizontal"
    $scope.barco5 = new servicioBarco 5, 4, 'images/barco4H.png', 80, 20, "horizontal"
    $scope.barcos = [$scope.barco1,$scope.barco2,$scope.barco3,$scope.barco4,$scope.barco5]
    $scope.cambiarOrientacion = (barco) ->
      barco.setOrientacion(barco.tamanio, barco.ancho, barco.alto)

    $scope.tabla = new servicioTabla 10
    #$scope
    $scope.celdas = [1..$scope.tabla.getDimension()]
