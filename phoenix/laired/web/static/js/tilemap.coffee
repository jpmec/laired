

module = angular.module 'laired.Tilemap', []


module.factory 'TilemapsApiResource',
($resource)->
  $resource('/api/tilemaps/:id')




module.factory 'TilemapFactory',
(TilesetFactory)->
  console.log('TilemapFactory')

  (tilemap_api_object, object)->

    if not object?
      object = angular.copy(tilemap_api_object)

    _.forEach object.tilesets, (tileset)->
      TilesetFactory tileset, tileset

    object.pixelsWidth = ()->
      object.width * object.tilewidth

    object.pixelsHeight = ()->
      object.height * object.tileheight

    object




module.factory 'TilemapPreloaderFactory',
($location, ImagesLocation, Tilemap)->
  console.log('TilemapGamePreloaderFactory')

  (tilemap)->
    preload: (game)->
      console.log('TilemapPreloader.preload')

      _.forEach tilemap.tilesets, (tileset)->

        image_key = "#{tileset.name}_image"
        image_path = "tilemaps/tiles/#{tileset.image}"

        console.log("TilemapPreloader.preload loading '#{image_key}' from '#{image_path}'")
        game.load.image image_key, image_path

      game.load.tilemap(
        tilemap.name,
        null,
        tilemap,
        Phaser.Tilemap.TILED_JSON
      )




module.factory 'TilemapCreaterFactory',
()->
  console.log('TilemapCreaterFactory')

  (tilemap)->
    console.log('TilemapCreater')

    create: (game)->
      console.log('TilemapCreater.create')

      console.log("TilemapCreater.create adding tilemap '#{tilemap.name}'")
      map = game.add.tilemap(tilemap.name)

      console.log('TilemapCreater.create adding tilesets images')
      _.forEach tilemap.tilesets, (tileset)->
        tileset_key = "#{tileset.name}"
        image_key = "#{tileset.name}_image"

        console.log("TilemapCreater.create adding tileset '#{tileset_key}' image '#{image_key}'")
        map.addTilesetImage tileset_key, image_key

      console.log('TilemapCreater.create creating layers')
      _.forEach tilemap.layers, (layer)->
        layer = map.createLayer layer.name




module.controller 'TilemapController',
($scope, TilemapsApiResource)->

  $scope.tilemap = null

  $scope.initialize = ()->
    console.debug('TilemapsController.initialize')

    resource = TilemapsApiResource.get {id: 1}
    resource.$promise.then (data)->
        $scope.tilemap = data

  $scope.initialize()



