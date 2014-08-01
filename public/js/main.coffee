require.config
  paths:
  # 3rd party libraries
    angular: 'lib/angular.min'
    jquery: 'lib/jquery-2.0.3.min'
    bootstrap: 'lib/bootstrap.min'

  #Angular libraries
    ngRoute: 'lib/angular-route'
    ngResource: 'lib/angular-resource'
    ngDragDrop: 'lib/angular-dragdrop.min'

  # Angular modules
    app: 'app'
    controllers: 'controllers/controllers'
    directives: 'directives/directives'
    services: 'services/services'

  #Angular controllers
    exampleController: 'controllers/persons-controller'
    dragAndDrop: 'controllers/dragAndDrop'
    crearbarcos: 'controllers/barcoController'
    archivoControladorPieza: 'controllers/controladorPieza'

  #Angular services
    exampleService: 'services/example-service'
    archivoServicioPieza: 'services/servicioPieza'

  #Angular directives
    exampleDirective: 'directives/example-directive'

  #CSS styles
    generalStyle: '../styles/index'
    bootstrapStyle: '../styles/bootstrap.min'
    panelInicialStyle: '../styles/panel_inicial'

  shim:
    angular:
      deps: ['jquery']
      exports: 'angular'
    ngRoute:
      deps: ['angular']
    ngResource:
      deps: ['angular']
    ngDragDrop:
      deps: ['angular']
    bootstrap:
      deps: ['jquery']
      exports: 'bootstrap'

  map:
    '*':
      'css': 'lib/css.min'

require [
  'angular'
  'app'
  'css!bootstrapStyle'
  'css!panelInicialStyle'
  'bootstrap'
], (angular, app) ->
  # Starts manually the Angular application.
  angular.bootstrap document, [app.name]
