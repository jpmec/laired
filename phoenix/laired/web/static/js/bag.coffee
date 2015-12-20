

module = angular.module 'laired.Bag', []


module.factory 'BagsApiResource',
($resource)->
  $resource('/api/bags/:id')

