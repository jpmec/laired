

module = angular.module 'laired.Tileset', []


module.factory 'TilesetFactory',
()->
  console.log('TilesetFactory')

  (tileset_api_object)->

    object = angular.copy(tileset_api_object)

    object.tileCountWidth = ()->
        object.imagewidth / (object.tilewidth + object.spacing)
    object.tileCountHeight = ()->
        object.imageheight / (object.tileheight + object.spacing)
    object.tileCount = ()->
        object.tileCountWidth() * object.tileCountHeight()

    object




module.factory 'Tileset',
()->
  console.log('Tileset')
  object:
    null





module.factory 'TilesetsApiResource',
($resource)->
  console.debug('TilesetsApiResource')

  $resource('/api/tilesets/:id')




module.controller 'TilesetController',
($scope, TilesetsApiResource)->

  $scope.tileset = null

  $scope.initialize = ()->
    console.debug('TilesetController.initialize')

    resource = TilesetsApiResource.get {id: 1}
    resource.$promise.then (data)->
        $scope.tileset = data

  $scope.initialize()



