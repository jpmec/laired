

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
      console.log('SpriteSheetPreloader.preload ' + JSON.stringify(sprite_sheet))

      game.load.spritesheet(
        "#{sprite_sheet.name}_spritesheet",
        "sprites/#{sprite_sheet.image}",
        sprite_sheet.framewidth,
        sprite_sheet.frameheight,
        sprite_sheet.framemax,
        sprite_sheet.framemargin,
        sprite_sheet.framespacing
      )




module.factory 'SpriteSheetCreaterFactory',
()->
  console.log('SpriteSheetCreaterFactory')

  (sprite_sheet)->
    console.log('SpriteSheetCreater')

    create: (game)->
      console.log('SpriteSheetCreater.create')


