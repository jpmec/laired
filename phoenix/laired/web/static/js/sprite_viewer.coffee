

module = angular.module 'laired.SpriteViewer', []




module.factory 'SpriteViewerPreloaderFactory',
($location, ImagesLocation, SpritePreloaderFactory)->
  console.log('SpriteViewerPreloader')

  (sprite)->
    preload: (game)->
      console.log('SpriteViewerPreloader.preload')

      game.stage.backgroundColor = '#000000'
      game.load.baseURL = ImagesLocation.url()

      SpritePreloaderFactory(sprite).preload(game)




module.factory 'SpriteViewerCreaterFactory',
(SpriteCreaterFactory)->
  console.log('SpriteViewerCreater')

  (sprite)->
    create: (game)->
      console.log('SpriteViewerCreater.create')

      SpriteCreaterFactory(sprite).create(game)




module.factory 'SpriteViewerUpdater',
()->
  console.log('SpriteViewerUpdater')

  update: (game)->
#    console.log('TilemapViewerUpdater.update')
    null




module.factory 'SpriteViewerFactory',
(SpriteViewerPreloaderFactory, SpriteViewerCreaterFactory, SpriteViewerUpdater)->
  console.log('SpriteViewerFactory')

  (sprite, kwargs)->
    console.log('SpriteViewerFactory creating ' + JSON.stringify(kwargs))

    kwargs_ = _.merge({
        width: sprite.spritesheet.framewidth
        height: sprite.spritesheet.frameheight
        id: 'sprite_viewer_div'
      }
    , kwargs)

    new Phaser.Game(
      kwargs_.width, kwargs_.height,
      Phaser.AUTO,
      kwargs_.id,
      {
        preload: SpriteViewerPreloaderFactory(sprite).preload,
        create: SpriteViewerCreaterFactory(sprite).create,
        update: SpriteViewerUpdater.update
      }
    )




module.directive 'spriteViewer',
()->
  console.log('spriteViewer')

  {
    scope:
      id: '='
    template: '<div id="sprite_viewer_div">{{id}}{{object | json}}</div>'
    controller: (
      $scope,
      $timeout,
      SpritesApiResource,
      Sprite,
      SpriteFactory,
      SpriteViewerFactory
    )->

      $scope.get = ()->
        console.debug('spriteViewer.controller.get ' + $scope.id)

        resource = SpritesApiResource.get {id: $scope.id}
        resource.$promise.then (data)->
          console.debug('spriteViewer.controller.initialize resource promise then ' + JSON.stringify(data))

          Sprite.object = SpriteFactory(data)

          $scope.game = SpriteViewerFactory Sprite.object
        , (error)->
          console.debug('spriteViewer.controller.initialize resource promise then error ' + JSON.stringify(error))

          $timeout ()->
            $scope.get()

      $scope.initialize = ()->
        console.debug('spriteViewer.controller.initialize')
        $scope.get()


      $scope.initialize()
  }
