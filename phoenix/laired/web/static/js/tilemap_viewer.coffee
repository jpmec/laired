

module = angular.module 'laired.TilemapViewer', []




module.factory 'Tilemap',
()->
  console.log('Tilemap')

  object: null




module.factory 'TilemapViewerPreloaderFactory',
($location, ImagesLocation, TilemapPreloaderFactory)->
  console.log('TilemapViewerPreloaderFactory')

  (tilemap)->
    preload: (game)->
      console.log('TilemapViewerPreloader.preload')

      game.stage.backgroundColor = '#000000';
      game.load.baseURL = ImagesLocation.url()

      TilemapPreloaderFactory(tilemap).preload(game)




module.factory 'TilemapViewerCreaterFactory',
()->
  console.log('TilemapViewerCreaterFactory')

  (tilemap)->
    console.log('TilemapViewerCreater')

    create: (game)->
      console.log('TilemapViewerCreater.create')

      TilemapCreaterFactory(tilemap).preload(game)




module.factory 'TilemapViewerUpdater',
()->
  console.log('TilemapViewerUpdater')

  update: (game)->
#    console.log('TilemapViewerUpdater.update')
    null




module.factory 'TilemapViewerFactory',
(TilemapViewerPreloaderFactory, TilemapViewerCreaterFactory, TilemapViewerUpdater)->
  console.log('TilemapViewerFactory')

  (tilemap, kwargs)->
    kwargs_ = _.merge({
        width: tilemap.pixelsWidth()
        height: tilemap.pixelsHeight()
        id: 'tilemap_viewer_div'
      }
    , kwargs)

    new Phaser.Game(
      kwargs_.width,
      kwargs_.height,
      Phaser.AUTO,
      kwargs_.id,
      {
        preload: TilemapViewerPreloaderFactory(tilemap).preload,
        create: TilemapViewerCreaterFactory(tilemap).create,
        update: TilemapViewerUpdater.update
      }
    )




module.controller 'TilemapViewerController',
($scope, TilemapsResource, Tilemap, TilemapFactory, TilemapViewerFactory)->
  console.log('TilemapViewerController')

  $scope.game = null
  $scope.tilemap = Tilemap


  $scope.initialize = ()->
    console.debug('TilemapViewerController.initialize')

    resource = TilemapsResource.get {id: 1}
    resource.$promise.then (data)->
        console.debug('TilemapViewerController.initialize resource promise then ' + JSON.stringify(data))

        Tilemap.object = TilemapFactory(data)
        $scope.game = TilemapViewerFactory Tilemap.object

  $scope.initialize()
