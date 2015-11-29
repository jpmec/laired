

module = angular.module 'laired.SpriteSheetViewer', []




module.factory 'SpriteSheetSpriteFactory',
()->
  console.log('SpriteSheetSpriteFactory')

  (sprite_sheet)->
    {
      spritesheets: [
        sprite_sheet
      ]
    }




module.factory 'SpriteSheetViewerPreloaderFactory',
($location, ImagesLocation, SpriteSheetSpriteFactory)->
  console.log('SpriteSheetViewerPreloader')

  (sprite_sheet)->
    preload: (game)->
      console.log('SpriteSheetViewerPreloader.preload')

      game.stage.backgroundColor = '#000000'
      game.load.baseURL = ImagesLocation.url()

      game.load.image("#{sprite_sheet.name}_image", "sprites/#{sprite_sheet.image}")




module.factory 'SpriteSheetViewerCreaterFactory',
()->
  console.log('SpriteSheetViewerCreater')

  (sprite_sheet)->
    create: (game)->
      console.log('SpriteSheetViewerCreater.create')




module.factory 'SpriteSheetViewerUpdater',
()->
  console.log('SpriteSheetViewerUpdater')

  update: (game)->
#    console.log('TilemapViewerUpdater.update')
    null




module.factory 'SpriteSheetViewerFactory',
(SpriteSheetViewerPreloaderFactory, SpriteSheetViewerCreaterFactory, SpriteSheetViewerUpdater)->
  console.log('SpriteSheetViewerFactory')

  (sprite_sheet, kwargs)->
    console.log('SpriteSheetViewerFactory creating ' + JSON.stringify(kwargs))

    kwargs_ = _.merge({
        width: sprite_sheet.imagewidth
        height: sprite_sheet.imageheight
        id: 'sprite_sheet_viewer_div'
      }
    , kwargs)

    new Phaser.Game(
      kwargs_.width, kwargs_.height,
      Phaser.AUTO,
      kwargs_.id,
      {
        preload: SpriteSheetViewerPreloaderFactory(sprite_sheet).preload,
        create: SpriteSheetViewerCreaterFactory(sprite_sheet).create,
        update: SpriteSheetViewerUpdater.update
      }
    )




module.controller 'SpriteSheetViewerController',
($scope, SpriteSheetsApiResource, SpriteSheet, SpriteSheetFactory, SpriteSheetViewerFactory)->
  console.log('SpriteSheetViewerController')

  $scope.game = null
  $scope.sprite_sheet = SpriteSheet


  $scope.initialize = ()->
    console.debug('SpriteSheetsController.initialize')

    resource = SpriteSheetsApiResource.get {id: 1}
    resource.$promise.then (data)->
        console.debug('SpriteSheetsController.initialize resource promise then ' + JSON.stringify(data))

        SpriteSheet.object = SpriteSheetFactory(data)
        $scope.game = SpriteSheetViewerFactory SpriteSheet.object

  $scope.initialize()




module.directive 'imgSpriteSheet',
()->
  console.log('imgSpriteSheet')

  {
    template: "<img src={{image_src}} alt={{image_name}} width={{image_width}} height={{image_height}}>"
    controller: ($scope, ImagesLocation, SpriteSheetsApiResource, SpriteSheetFactory)->

      $scope.image_src = null
      $scope.image_name = null
      $scope.image_width = null
      $scope.image_height = null

      $scope.initialize = ()->
        console.debug('imgSpriteSheet.controller.initialize')

        resource = SpriteSheetsApiResource.get {id: 1}
        resource.$promise.then (data)->
          console.debug('imgSpriteSheet.controller.initialize resource promise then ' + JSON.stringify(data))

          object = SpriteSheetFactory(data)

          $scope.image_name = object.name
          $scope.image_width = object.imagewidth * 4
          $scope.image_height = object.imageheight * 4
          $scope.image_src = "#{ImagesLocation.url()}/sprites/#{object.image}"

      $scope.initialize()
  }
