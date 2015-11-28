
module = angular.module 'laired.Place', []




module.factory 'PlacesApiResource',
($resource)->
  $resource('/api/places/:id')




module.factory 'PlaceFactory',
(TilemapFactory)->
  console.log('PlaceFactory')

  (place_api_object, object = null)->

    if not object?
      object = angular.copy(place_api_object)

    _.forEach object.tilemaps, (tilemap)->
      TilemapFactory tilemap, tilemap

    object.pixelsWidth = ()->
      _.max(_.map(object.tilemaps, (tilemap)->tilemap.pixelsWidth()))

    object.pixelsHeight = ()->
      _.max(_.map(object.tilemaps, (tilemap)->tilemap.pixelsHeight()))

    object




module.factory 'PlacePreloaderFactory',
(TilemapPreloaderFactory)->
  console.log('PlacePreloaderFactory')

  (place)->
    preload: (game)->
      console.log('PlacePreloader.preload')

      _.forEach place.tilemaps, (tilemap)->
        TilemapPreloaderFactory(tilemap).preload(game)




module.factory 'PlaceCreaterFactory',
(TilemapCreaterFactory)->
  console.log('PlaceCreaterFactory')

  (place)->
    console.log('Place Creater')

    create: (game)->
      console.log('TilemapCreater.create')

      _.forEach place.tilemaps, (tilemap)->
        TilemapCreaterFactory(tilemap).create(game)




# module.factory 'PlaceFactory',
# (TilemapPreloaderFactory, ShovelFactory, DirtFactory)->
#   console.log('PlaceFactory')

#   place:
#     game:
#       preload: (place, game)->
#         console.log('place.game.preload')

#         TilemapPreloaderFactory(tilemap).preload(game)

# #        game.load.tilemap('lair_tilemap', 'tilemaps/maps/lair.json', null, Phaser.Tilemap.TILED_JSON)
# #        game.load.image('lair_tiles', 'tilemaps/tiles/lair.png')

#         shovel = ShovelFactory.shovel
#         shovel.game.preload(shovel, game)

#         game.load.image('dirt', 'dirt.png')


#       create: (place, game)->
#         console.log('place.game.create')

#         map = game.add.tilemap('lair_tilemap')
#         map.addTilesetImage('lair', 'lair_tiles')

#         layer = map.createLayer('World1')
#         layer.resizeWorld();
#         layer.wrap = true;

#         place.game.stuff = game.add.group()
#         place.game.stuff.enableBody = true

#         place.game.things = game.add.group()
#         place.game.things.enableBody = true

#         shovel = ShovelFactory.shovel
#         shovel.game.create(shovel, game, place.game.stuff)

#         dirt = DirtFactory.dirt
#         dirt.game.create(dirt, game, place.game.things)

#       update: (place, game, input)->

#         place.game.stuff.forEach(
#           (stuff, game, input)->
#             stuff.update(stuff, game, input)
#           , this
#           , true
#           , game
#           , input
#         )

#         place.game.things.forEach(
#           (thing, game, input)->
#             thing.update(thing, game, input)
#           , this
#           , true
#           , game
#           , input
#         )
