

module = angular.module 'laired.SpriteSheet', []




module.factory 'SpriteSheet',
()->
  console.log('SpriteSheet')
  object:
    null




module.factory 'SpriteSheetFactory',
()->
  console.log('SpriteSheetFactory')

  (sprite_sheet_api_object, object)->

    if not object?
      object = angular.copy(sprite_sheet_api_object)

    object




module.factory 'SpriteSheetsApiResource',
($resource)->
  console.debug('SpriteSheetsApiResource')

  $resource('/api/sprite_sheets/:id')




module.factory 'SpriteSheetPreloaderFactory',
(SpriteSheetSpriteFactory)->
  console.log('SpriteSheetPreloaderFactory')

  (sprite_sheet)->
    console.log('SpriteSheetPreloader')

    preload: (game)->
      console.log('SpriteSheetPreloader.preload')

      game.load.image("#{sprite_sheet.name}_image", "sprites/#{sprite_sheet.image}")


