

module = angular.module 'laired.Stuff', []




module.factory 'StuffsApiResource',
($resource)->
  console.debug('StuffsApiResource')

  $resource('/api/stuffs/:id')




module.factory 'Stuff',
()->
  console.log('Stuff')
  object:
    null




module.factory 'StuffFactory',
()->
  console.log('StuffFactory')

  (stuff_api_object, object)->
    console.log('StuffFactory creating from ' + JSON.stringify(stuff_api_object) + ' into ' + JSON.stringify(object))

    if not object?
      object = _.cloneDeep(stuff_api_object)

    object




module.factory 'StuffPreloaderFactory',
()->
  console.log('StuffPreloaderFactory')

  (stuff)->
    console.log('StuffPreloader')

    preload: (game)->
      console.log('StuffPreloader.preload')

      # _.forEach place.tilemaps, (tilemap)->
      #   TilemapPreloaderFactory(tilemap).preload(game)




module.factory 'StuffCreaterFactory',
()->
  console.log('StuffCreaterFactory')

  (stuff)->
    console.log('StuffCreater')

    create: (game)->
      console.log('StuffCreater.create')

      # _.forEach place.tilemaps, (tilemap)->
      #   TilemapCreaterFactory(tilemap).create(game)




