

module = angular.module 'laired.TilemapViewer', []




module.factory 'Tilemap',
()->
  console.log('Tilemap')

  object: null




module.factory 'TilemapViewerPreloaderFactory',
($location, ImagesLocation, Tilemap)->
  console.log('TilemapViewerPreloaderFactory')

  (tilemap)->
    preload: (game)->
      console.log('TilemapViewerPreloader.preload')

      game.stage.backgroundColor = '#000000';
      game.load.baseURL = ImagesLocation.url()

      _.forEach tilemap.tilesets, (tileset)->

        image_key = "#{tileset.name}_image"
        image_path = "tilemaps/tiles/#{tileset.image}"

        console.log("TilemapViewerPreloader.preload loading '#{image_key}' from '#{image_path}'")
        game.load.image image_key, image_path


      game.load.tilemap(
        tilemap.name,
        null,
        tilemap,
        Phaser.Tilemap.TILED_JSON
      )





module.factory 'TilemapViewerCreaterFactory',
()->
  console.log('TilemapViewerCreaterFactory')

  (tilemap)->
    console.log('TilemapViewerCreater')

    create: (game)->
      console.log('TilemapViewerCreater.create')

      console.log("TilemapViewerCreater.create adding tilemap '#{tilemap.name}'")
      map = game.add.tilemap(tilemap.name)

      console.log('TilemapViewerCreater.create adding tilesets images')
      _.forEach tilemap.tilesets, (tileset)->
        tileset_key = "#{tileset.name}"
        image_key = "#{tileset.name}_image"

        console.log("TilemapViewerCreater.create adding tileset '#{tileset_key}' image '#{image_key}'")
        map.addTilesetImage tileset_key, image_key

      console.log('TilemapViewerCreater.create creating layers')
      _.forEach tilemap.layers, (layer)->
        layer = map.createLayer layer.name
      # layer.resizeWorld();
      # layer.wrap = true;




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
