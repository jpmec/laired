

module = angular.module 'laired.HeroViewer', []




module.factory 'HeroViewerPreloaderFactory',
($location, ImagesLocation, HeroPreloaderFactory)->
  console.log('HeroViewerPreloader')

  (hero)->
    preload: (game)->
      console.log('HeroViewerPreloader.preload')

      game.stage.backgroundColor = '#000000'
      game.load.baseURL = ImagesLocation.url()

      HeroPreloaderFactory(hero).preload(game)




module.factory 'HeroViewerCreaterFactory',
(HeroCreaterFactory)->
  console.log('HeroViewerCreater')

  (hero)->
    create: (game)->
      console.log('HeroViewerCreater.create')

      HeroCreaterFactory(hero).create(game)




module.factory 'HeroViewerUpdater',
()->
  console.log('HeroViewerUpdater')

  update: (game)->
#    console.log('TilemapViewerUpdater.update')
    null




module.factory 'HeroViewerFactory',
(HeroViewerPreloaderFactory, HeroViewerCreaterFactory, HeroViewerUpdater)->
  console.log('HeroViewerFactory')

  (hero, kwargs)->
    console.log('HeroViewerFactory creating ' + JSON.stringify(kwargs))

    kwargs_ = _.merge({
        width: 100
        height: 100
        id: 'hero_viewer_div'
      }
    , kwargs)

    new Phaser.Game(
      kwargs_.width, kwargs_.height,
      Phaser.AUTO,
      kwargs_.id,
      {
        preload: HeroViewerPreloaderFactory(hero).preload,
        create: HeroViewerCreaterFactory(hero).create,
        update: HeroViewerUpdater.update
      }
    )




module.controller 'HeroViewerController',
($scope, HerosApiResource, Hero, HeroFactory, HeroViewerFactory)->
  console.log('HeroViewerController')

  $scope.game = null
  $scope.hero = Hero


  $scope.initialize = ()->
    console.debug('HerosController.initialize')

    resource = HerosApiResource.get {id: 1}
    resource.$promise.then (data)->
        console.debug('HerosController.initialize resource promise then ' + JSON.stringify(data))

        Hero.object = HeroFactory(data)
        $scope.game = HeroViewerFactory Hero.object

  $scope.initialize()




module.directive 'heroViewer',
()->
  console.log('heroViewer')

  {
    scope:
      id: '='
    template: '<div id="hero_viewer_div">{{id}}{{object | json}}</div>'
    controller: (
      $scope,
      $timeout,
      HerosApiResource,
      Hero,
      HeroFactory,
      HeroViewerFactory
    )->
      $scope.get = ()->
        console.debug('heroViewer.controller.get')

        resource = HerosApiResource.get {id: $scope.id}
        resource.$promise.then (data)->
          console.debug('heroViewer.controller.initialize resource promise then ' + JSON.stringify(data))

          Hero.object = HeroFactory(data)
          $scope.game = HeroViewerFactory Hero.object

        , (error)->
          console.debug('heroViewer.controller.initialize resource promise then error ' + JSON.stringify(error))

          $timeout ()->
            $scope.get()


      $scope.initialize = ()->
        console.debug('heroViewer.controller.initialize ' + $scope.id)
        $scope.get()


      $scope.initialize()
  }
