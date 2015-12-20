

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




module.factory 'SpritePreloaderFactory',
(SpriteSheetPreloaderFactory)->
  console.log('SpritePreloaderFactory')

  (sprite)->
    console.log('SpritePreloader')

    preload: (game)->
      console.log('SpritePreloader.preload')

      _.forEach sprite.spritesheets, (spritesheet)->
        SpriteSheetPreloaderFactory(spritesheet).preload(game)




module.factory 'SpriteCreaterFactory',
(SpriteSheetCreaterFactory)->
  console.log('SpriteCreaterFactory')

  (sprite)->
    console.log('SpriteCreate')

    create: (game)->
      console.log('SpritePreloader.create')

      _.forEach sprite.spritesheets, (spritesheet)->
        SpriteSheetCreaterFactory(spritesheet).create(game)

      _.forEach sprite.spritesheets, (spritesheet)->
        sprite_ = game.add.sprite(sprite.x, sprite.y, "#{spritesheet.name}_spritesheet")

