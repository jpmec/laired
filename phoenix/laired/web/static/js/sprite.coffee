

module = angular.module 'laired.Sprite', []




module.factory 'Sprite',
()->
  console.log('Sprite')
  object:
    null




module.factory 'SpriteFactory',
()->
  console.log('SpriteFactory')

  (sprite_api_object, object)->

    if not object?
      object = angular.copy(sprite_api_object)

    object




module.factory 'SpritesApiResource',
($resource)->
  console.debug('SpritesApiResource')

  $resource('/api/sprites/:id')

