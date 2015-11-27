

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
          name: "#{tileset.name}_layer",
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




module.factory 'TilesetViewerPreloaderFactory',
($location, ImagesLocation, TilesetTilemapFactory)->
  console.log('TilesetViewerPreloader')

  (tileset)->
    preload: (game)->
      console.log('TilesetViewerPreloader.preload')

      game.stage.backgroundColor = '#000000'
      game.load.baseURL = ImagesLocation.url()

      game.load.image("#{tileset.name}_image", "tilemaps/tiles/#{tileset.image}")

      game.load.tilemap(
        "#{tileset.name}_tilemap",
        null,
        TilesetTilemapFactory(tileset),
        Phaser.Tilemap.TILED_JSON
      )





module.factory 'TilesetViewerCreaterFactory',
()->
  console.log('TilesetViewerCreater')

  (tileset)->
    create: (game)->
      console.log('TilesetViewerCreater.create')

      console.log('TilesetViewerCreater.create adding tilemap')
      map = game.add.tilemap("#{tileset.name}_tilemap")

      console.log('TilesetViewerCreater.create adding tilesetimage')
      map.addTilesetImage(tileset.name, "#{tileset.name}_image")

      console.log('TilesetViewerCreater.create creating layer')
      layer = map.createLayer("#{tileset.name}_layer")




module.factory 'TilesetViewerUpdater',
()->
  console.log('TilesetViewerUpdater')

  update: (game)->
#    console.log('TilemapViewerUpdater.update')
    null




module.factory 'TilesetViewerFactory',
(TilesetViewerPreloaderFactory, TilesetViewerCreaterFactory, TilesetViewerUpdater)->
  console.log('TilesetViewerFactory')

  (tileset, kwargs)->
    console.log('TilesetViewerFactory creating ' + JSON.stringify(kwargs))

    kwargs_ = _.merge({
        width: tileset.tileCount() * tileset.tilewidth
        height: tileset.tileheight
        id: 'tileset_viewer_div'
      }
    , kwargs)

    new Phaser.Game(
      kwargs_.width, kwargs_.height,
      Phaser.AUTO,
      kwargs_.id,
      {
        preload: TilesetViewerPreloaderFactory(tileset).preload,
        create: TilesetViewerCreaterFactory(tileset).create,
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
        $scope.game = TilesetViewerFactory Tileset.object

  $scope.initialize()
