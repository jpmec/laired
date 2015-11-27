

module = angular.module 'laired.Tilemap', []


module.factory 'TilemapsResource',
($resource)->
  $resource('/api/tilemaps/:id')




module.controller 'TilemapController',
($scope, TilemapsResource)->

  $scope.tilemap = null

  $scope.initialize = ()->
    console.debug('TilemapsController.initialize')

    resource = TilemapsResource.get {id: 1}
    resource.$promise.then (data)->
        $scope.tilemap = data

  $scope.initialize()



