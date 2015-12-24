

module = angular.module 'laired.BagViewer', []




module.factory 'BagViewerPreloaderFactory',
($location, ImagesLocation, BagPreloaderFactory)->
  console.log('BagViewerPreloader')

  (bag)->
    preload: (game)->
      console.log('BagViewerPreloader.preload')

      game.stage.backgroundColor = '#000000'
      game.load.baseURL = ImagesLocation.url()

      BagPreloaderFactory(bag).preload(game)




module.factory 'BagViewerCreaterFactory',
(BagCreaterFactory)->
  console.log('BagViewerCreater')

  (bag)->
    create: (game)->
      console.log('BagViewerCreater.create')

      BagCreaterFactory(bag).create(game)




module.factory 'BagViewerUpdater',
()->
  console.log('BagViewerUpdater')

  update: (game)->
#    console.log('TilemapViewerUpdater.update')
    null




module.factory 'BagViewerFactory',
(BagViewerPreloaderFactory, BagViewerCreaterFactory, BagViewerUpdater)->
  console.log('BagViewerFactory')

  (bag, kwargs)->
    console.log('BagViewerFactory creating ' + JSON.stringify(kwargs))

    kwargs_ = _.merge({
        width: 100
        height: 100
        id: 'bag_viewer_div'
      }
    , kwargs)

    new Phaser.Game(
      kwargs_.width, kwargs_.height,
      Phaser.AUTO,
      kwargs_.id,
      {
        preload: BagViewerPreloaderFactory(bag).preload,
        create: BagViewerCreaterFactory(bag).create,
        update: BagViewerUpdater.update
      }
    )




module.controller 'BagViewerController',
($scope, BagsApiResource, Bag, BagFactory, BagViewerFactory)->
  console.log('BagViewerController')

  $scope.game = null
  $scope.bag = Bag


  $scope.initialize = ()->
    console.debug('BagsController.initialize')

    resource = BagsApiResource.get {id: 1}
    resource.$promise.then (data)->
        console.debug('BagsController.initialize resource promise then ' + JSON.stringify(data))

        Bag.object = BagFactory(data)
        $scope.game = BagViewerFactory Bag.object

  $scope.initialize()




module.directive 'bagViewer',
()->
  console.log('bagViewer')

  {
    scope:
      id: '='
    template: '<div id="bag_viewer_div">{{id}}{{object | json}}</div>'
    controller: (
      $scope,
      $timeout,
      BagsApiResource,
      Bag,
      BagFactory,
      BagViewerFactory
    )->
      $scope.get = ()->
        console.debug('bagViewer.controller.get')

        resource = BagsApiResource.get {id: $scope.id}
        resource.$promise.then (data)->
          console.debug('bagViewer.controller.initialize resource promise then ' + JSON.stringify(data))

          Bag.object = BagFactory(data)
          $scope.game = BagViewerFactory Bag.object

        , (error)->
          console.debug('bagViewer.controller.initialize resource promise then error ' + JSON.stringify(error))

          $timeout ()->
            $scope.get()


      $scope.initialize = ()->
        console.debug('bagViewer.controller.initialize ' + $scope.id)
        $scope.get()


      $scope.initialize()
  }
