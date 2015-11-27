

module = angular.module 'laired.TilesetViewer', []



module.factory 'TilesetTilemapFactory',
()->
  console.log('TilesetTilemapFactory')

  (tileset)->

    tile_count = tileset.tileCount()

    {
      height: 1,
      layers: [
        {
          data: [1..tile_count],
          height: 1,
          name: 'tileset',
          opacity: 1,
          type: 'tilelayer',
          visible: true,
          width: tile_count,
          x: 0,
          y: 0
        }
      ],
      orientation: "orthogonal",
      tileheight: tileset.tileheight,
      tilesets: [tileset],
      tilewidth: tileset.tilewidth,
      version: 1,
      width: 4
    }




module.factory 'TilesetViewerPreloader',
($location, ImagesLocation, Tileset, TilesetTilemapFactory)->
  console.log('TilesetViewerPreloader')

  preload: (game)->
    console.log('TilesetViewerPreloader.preload')

    game.stage.backgroundColor = '#000000'
    game.load.baseURL = ImagesLocation.url()

    tileset = Tileset.object
    console.log('TilesetViewerPreloader.preload loading ' + JSON.stringify(tilemap))

    game.load.image('tileset', "tilemaps/tiles/#{tileset.image}")

    tilemap = TilesetTilemapFactory(tileset)

    game.load.tilemap(
      'tilemap',
      null,
      tilemap,
      Phaser.Tilemap.TILED_JSON
    )





module.factory 'TilesetViewerCreater',
()->
  console.log('TilesetViewerCreater')

  create: (game)->
    console.log('TilesetViewerCreater.create')

    console.log('TilesetViewerCreater.create adding tilemap')
    map = game.add.tilemap('tilemap')

    console.log('TilesetViewerCreater.create adding tilesetimage')
    map.addTilesetImage('tileset', 'tileset')

    console.log('TilesetViewerCreater.create creating layer')
    layer = map.createLayer('tileset')




module.factory 'TilesetViewerUpdater',
()->
  console.log('TilesetViewerUpdater')

  update: (game)->
#    console.log('TilemapViewerUpdater.update')
    null




module.factory 'TilesetViewerFactory',
(TilesetViewerPreloader, TilesetViewerCreater, TilesetViewerUpdater)->
  console.log('TilesetViewerFactory')

  ()->
    new Phaser.Game(
      670, 480,
      Phaser.AUTO,
      'tileset_viewer_div',
      {
        preload: TilesetViewerPreloader.preload,
        create: TilesetViewerCreater.create,
        update: TilesetViewerUpdater.update
      }
    )




module.controller 'TilesetViewerController',
($scope, TilesetsApiResource, Tileset, TilesetFactory, TilesetViewerFactory)->
  console.log('TilesetViewerController')

  $scope.game = null
  $scope.tileset = Tileset


  $scope.initialize = ()->
    console.debug('TilesetsController.initialize')

    resource = TilesetsApiResource.get {id: 1}
    resource.$promise.then (data)->
        console.debug('TilesetsController.initialize resource promise then ' + JSON.stringify(data))

        Tileset.object = TilesetFactory(data)

        $scope.game = TilesetViewerFactory()

  $scope.initialize()
