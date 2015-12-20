

module = angular.module 'laired.StuffViewer', []




module.factory 'StuffViewerPreloaderFactory',
($location, ImagesLocation, StuffPreloaderFactory)->
  console.log('StuffViewerPreloader')

  (stuff)->
    preload: (game)->
      console.log('StuffViewerPreloader.preload')

      game.stage.backgroundColor = '#000000'
      game.load.baseURL = ImagesLocation.url()

      StuffPreloaderFactory(stuff).preload(game)




module.factory 'StuffViewerCreaterFactory',
(StuffCreaterFactory)->
  console.log('StuffViewerCreater')

  (stuff)->
    create: (game)->
      console.log('StuffViewerCreater.create')

      StuffCreaterFactory(stuff).create(game)




module.factory 'StuffViewerUpdater',
()->
  console.log('StuffViewerUpdater')

  update: (game)->
#    console.log('TilemapViewerUpdater.update')
    null




module.factory 'StuffViewerFactory',
(StuffViewerPreloaderFactory, StuffViewerCreaterFactory, StuffViewerUpdater)->
  console.log('StuffViewerFactory')

  (stuff, kwargs)->
    console.log('StuffViewerFactory creating ' + JSON.stringify(kwargs))

    kwargs_ = _.merge({
        width: 100
        height: 100
        id: 'stuff_viewer_div'
      }
    , kwargs)

    new Phaser.Game(
      kwargs_.width, kwargs_.height,
      Phaser.AUTO,
      kwargs_.id,
      {
        preload: StuffViewerPreloaderFactory(stuff).preload,
        create: StuffViewerCreaterFactory(stuff).create,
        update: StuffViewerUpdater.update
      }
    )




module.controller 'StuffViewerController',
($scope, StuffsApiResource, Stuff, StuffFactory, StuffViewerFactory)->
  console.log('StuffViewerController')

  $scope.game = null
  $scope.stuff = Stuff


  $scope.initialize = ()->
    console.debug('StuffsController.initialize')

    resource = StuffsApiResource.get {id: 1}
    resource.$promise.then (data)->
        console.debug('StuffsController.initialize resource promise then ' + JSON.stringify(data))

        Stuff.object = StuffFactory(data)
        $scope.game = StuffViewerFactory Stuff.object

  $scope.initialize()




module.directive 'stuffViewer',
()->
  console.log('stuffViewer')

  {
    scope:
      id: '='
    template: '<div id="stuff_viewer_div">{{id}}{{object | json}}</div>'
    controller: ($scope, StuffsApiResource, Stuff, StuffFactory, StuffViewerFactory)->

      $scope.initialize = ()->
        console.debug('stuffViewer.controller.initialize')

        resource = StuffsApiResource.get {id: $scope.id}
        resource.$promise.then (data)->
          console.debug('stuffViewer.controller.initialize resource promise then ' + JSON.stringify(data))

          Stuff.object = StuffFactory(data)

          $scope.game = StuffViewerFactory Stuff.object


      $scope.initialize()
  }
