

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

      if sprite.spritesheet
        SpriteSheetPreloaderFactory(sprite.spritesheet).preload(game)




module.factory 'SpriteCreaterFactory',
(SpriteSheetCreaterFactory)->
  console.log('SpriteCreaterFactory')

  (sprite)->
    console.log('SpriteCreate')

    create: (game)->
      console.log('SpritePreloader.create')

      SpriteSheetCreaterFactory(sprite.spritesheet).create(game)

      game_sprite = game.add.sprite(sprite.x, sprite.y, "#{sprite.spritesheet.name}_spritesheet", sprite.frame)



      _.forEach sprite.spriteanimations, (animation)->
        game_sprite.animations.add(animation.name, animation.frames, animation.framerate, animation.loop)

