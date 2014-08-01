'use strict'

define [
 "angular"
 "css!generalStyle"
 "ngResource"
 "ngRoute"
 "controllers"
 "directives"
 "services"
 "ngDragDrop"
 "dragAndDrop"
 "crearbarcos"
 "archivoControladorBarco"
 "ngResource"
], (angular) ->
  battleShipsApp = angular.module "battleShipsApp", [
    "ngResource"
    "ngRoute"
    "battleShipsControllers"
    "battleShipsDirectives"
    "battleShipsServices"
    "ngDragDrop"
  ]

  # Sets the URL routes for partial views.
  battleShipsApp.config [
    "$routeProvider"
  , ($routeProvider) ->
      $routeProvider.when("/",
        templateUrl: "panel_inicial.html"
      ).otherwise
        redirectTo: "/panel_inicial.html"
  ]

  battleShipsApp
