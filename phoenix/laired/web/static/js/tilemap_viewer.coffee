

module = angular.module 'laired.TilemapViewer', []




module.factory 'Tilemap',
()->
  console.log('Tilemap')

  object: null




module.factory 'TilemapViewerPreloader',
($location, Tilemap)->
  console.log('TilemapViewerPreloader')

  preload: (game)->
    console.log('TilemapViewerPreloader.preload')

    protocol = $location.protocol()
    host = $location.host()
    port = $location.port()

    game.stage.backgroundColor = '#000000';
    game.load.baseURL = "#{protocol}://#{host}:#{port}/images/";

    tilemap = Tilemap.object
    console.log('TilemapViewerPreloader.preload loading ' + JSON.stringify(tilemap))

    game.load.image('tileset', 'tilemaps/tiles/lair.png')

    game.load.tilemap(
      'tilemap',
      null,
      tilemap,
      Phaser.Tilemap.TILED_JSON
    )





module.factory 'TilemapViewerCreater',
()->
  console.log('TilemapViewerCreater')

  create: (game)->
    console.log('TilemapViewerCreater.create')

    console.log('TilemapViewerCreater.create adding tilemap')
    map = game.add.tilemap('tilemap')

    console.log('TilemapViewerCreater.create adding tilesetimage')
    map.addTilesetImage('tileset', 'tileset')

    console.log('TilemapViewerCreater.create creating layer')
    layer = map.createLayer('things')
    # layer.resizeWorld();
    # layer.wrap = true;




module.factory 'TilemapViewerUpdater',
()->
  console.log('TilemapViewerUpdater')

  update: (game)->
#    console.log('TilemapViewerUpdater.update')
    null




module.factory 'TilemapViewerFactory',
(TilemapViewerPreloader, TilemapViewerCreater, TilemapViewerUpdater)->
  console.log('TilemapViewerFactory')

  ()->
    new Phaser.Game(
      670, 480,
      Phaser.AUTO,
      'tilemap_viewer_div',
      {
        preload: TilemapViewerPreloader.preload,
        create: TilemapViewerCreater.create,
        update: TilemapViewerUpdater.update
      }
    )




module.controller 'TilemapViewerController',
($scope, TilemapsResource, Tilemap, TilemapViewerFactory)->
  console.log('TilemapViewerController')

  $scope.game = null
  $scope.tilemap = Tilemap


  $scope.initialize = ()->
    console.debug('TilemapsController.initialize')

    resource = TilemapsResource.get {id: 1}
    resource.$promise.then (data)->
        console.debug('TilemapsController.initialize resource promise then ' + JSON.stringify(data))

        Tilemap.object = data

        $scope.game = TilemapViewerFactory()

  $scope.initialize()
