'use strict'

define ['controllers', 'archivoServicioTabla'], (controllers) ->
  controllers.controller 'BarcoController', ($scope, servicioTabla) ->
    $scope.tabla = new servicioTabla 10
    alert $scope.tabla.getDimension()
    