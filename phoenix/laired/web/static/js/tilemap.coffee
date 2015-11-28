

module = angular.module 'laired.Tilemap', []


module.factory 'TilemapsResource',
($resource)->
  $resource('/api/tilemaps/:id')




module.factory 'TilemapFactory',
()->
  console.log('TilemapFactory')

  (tilemap_api_object)->

    object = angular.copy(tilemap_api_object)

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




module.controller 'TilemapController',
($scope, TilemapsResource)->

  $scope.tilemap = null

  $scope.initialize = ()->
    console.debug('TilemapsController.initialize')

    resource = TilemapsResource.get {id: 1}
    resource.$promise.then (data)->
        $scope.tilemap = data

  $scope.initialize()



