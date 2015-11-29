

module = angular.module 'laired.SpriteViewer', []




module.factory 'SpriteViewerPreloaderFactory',
($location, ImagesLocation, SpriteTilemapFactory)->
  console.log('SpriteViewerPreloader')

  (sprite)->
    preload: (game)->
      console.log('SpriteViewerPreloader.preload')

      game.stage.backgroundColor = '#000000'
      game.load.baseURL = ImagesLocation.url()




module.factory 'SpriteViewerCreaterFactory',
()->
  console.log('SpriteViewerCreater')

  (sprite)->
    create: (game)->
      console.log('SpriteViewerCreater.create')




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
        width: sprite.width
        height: sprite.height
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




module.controller 'SpriteViewerController',
($scope, SpritesApiResource, Sprite, SpriteFactory, SpriteViewerFactory)->
  console.log('SpriteViewerController')

  $scope.game = null
  $scope.sprite = Sprite


  $scope.initialize = ()->
    console.debug('SpritesController.initialize')

    resource = SpritesApiResource.get {id: 1}
    resource.$promise.then (data)->
        console.debug('SpritesController.initialize resource promise then ' + JSON.stringify(data))

        Sprite.object = SpriteFactory(data)
        $scope.game = SpriteViewerFactory Sprite.object

  $scope.initialize()
