

module = angular.module 'laired.PlaceViewer', []



module.factory 'Place',
()->
  console.log('Place')

  object: null




module.factory 'PlaceViewerPreloaderFactory',
($location, ImagesLocation, PlacePreloaderFactory)->
  console.log('PlaceViewerPreloaderFactory')

  (place)->
    preload: (game)->
      console.log('PlaceViewerPreloader.preload')

      game.stage.backgroundColor = '#000000';
      game.load.baseURL = ImagesLocation.url()

      PlacePreloaderFactory(place).preload(game)




module.factory 'PlaceViewerCreaterFactory',
(PlaceCreaterFactory)->
  console.log('PlaceViewerCreaterFactory')

  (place)->
    console.log('PlaceViewerCreater')

    create: (game)->
      console.log('PlaceViewerCreater.create')

      PlaceCreaterFactory(place).create(game)




module.factory 'PlaceViewerUpdater',
()->
  console.log('PlaceViewerUpdater')

  update: (game)->
#    console.log('PlaceViewerUpdater.update')
    null




module.factory 'PlaceViewerFactory',
(PlaceViewerPreloaderFactory, PlaceViewerCreaterFactory, PlaceViewerUpdater)->
  console.log('PlaceViewerFactory')

  (place, kwargs)->
    kwargs_ = _.merge({
        width: place.pixelsWidth()
        height: place.pixelsHeight()
        id: 'place_viewer_div'
      }
    , kwargs)

    console.log('PlaceViewerFactory creating game ' + JSON.stringify(kwargs_))

    new Phaser.Game(
      kwargs_.width,
      kwargs_.height,
      Phaser.AUTO,
      kwargs_.id,
      {
        preload: PlaceViewerPreloaderFactory(place).preload,
        create: PlaceViewerCreaterFactory(place).create,
        update: PlaceViewerUpdater.update
      }
    )




module.controller 'PlaceViewerController',
($scope, PlacesApiResource, Place, PlaceFactory, PlaceViewerFactory)->
  console.log('PlaceViewerController')

  $scope.game = null
  $scope.place = Place


  $scope.initialize = ()->
    console.debug('PlaceViewerController.initialize')

    resource = PlacesApiResource.get {id: 1}
    resource.$promise.then (data)->
        console.debug('PlaceViewerController.initialize resource promise then ' + JSON.stringify(data))

        Place.object = PlaceFactory(data)
        $scope.game = PlaceViewerFactory Place.object

  $scope.initialize()
