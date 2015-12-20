

module = angular.module 'laired.DisplayGroup', []




module.factory 'DisplayGroup',
()->
  console.log('DisplayGroup')
  object:
    null




module.factory 'DisplayGroupFactory',
()->
  console.log('DisplayGroupFactory')

  (display_group_api_object, object)->

    if not object?
      object = angular.copy(display_group_api_object)

    object




module.factory 'DisplayGroupsApiResource',
($resource)->
  console.debug('DisplayGroupsApiResource')

  $resource('/api/display_groups/:id')




module.factory 'DisplayGroupPreloaderFactory',
(SpritePreloaderFactory)->
  console.log('DisplayGroupPreloaderFactory')

  (display_group)->
    console.log('DisplayGroupPreloader')

    preload: (game)->
      console.log('DisplayGroupPreloader.preload')

      _.forEach display_group.sprites, (sprite)->
        SpritePreloaderFactory(sprite).preload(game)




module.factory 'DisplayGroupCreaterFactory',
(SpriteCreaterFactory)->
  console.log('DisplayGroupCreaterFactory')

  (display_group)->
    console.log('DisplayGroupCreater')

    create: (game)->
      console.log('DisplayGroupCreater.create')

      _.forEach display_group.sprites, (sprite)->
        SpriteCreaterFactory(sprite).create(game)
