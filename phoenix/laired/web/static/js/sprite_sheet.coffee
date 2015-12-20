

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
()->
  console.log('SpriteSheetPreloaderFactory')

  (sprite_sheet)->
    console.log('SpriteSheetPreloader')

    preload: (game)->
      console.log('SpriteSheetPreloader.preload')

#      game.load.image("#{sprite_sheet.name}_image", "sprites/#{sprite_sheet.image}")

      game.load.spritesheet("#{sprite_sheet.name}_spritesheet", "sprites/#{sprite_sheet.image}", sprite_sheet.imagewidth, sprite_sheet.imageheight)




module.factory 'SpriteSheetCreaterFactory',
()->
  console.log('SpriteSheetCreaterFactory')

  (sprite_sheet)->
    console.log('SpriteSheetCreater')

    create: (game)->
      console.log('SpriteSheetCreater.create')


