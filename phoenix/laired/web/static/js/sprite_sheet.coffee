

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


