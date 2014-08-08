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
 "archivoControladorTabla"
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
        templateUrl: "main.html"
      ).otherwise
        redirectTo: "/main.html"
  ]

  battleShipsApp
