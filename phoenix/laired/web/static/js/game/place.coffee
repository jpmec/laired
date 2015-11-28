
module = angular.module 'laired.Place', []


module.factory 'PlaceFactory',
(TilemapPreloaderFactory, ShovelFactory, DirtFactory)->
  console.log('PlaceFactory')

  place:
    game:
      preload: (place, game)->
        console.log('place.game.preload')

        TilemapPreloaderFactory(tilemap).preload(game)

#        game.load.tilemap('lair_tilemap', 'tilemaps/maps/lair.json', null, Phaser.Tilemap.TILED_JSON)
#        game.load.image('lair_tiles', 'tilemaps/tiles/lair.png')

        shovel = ShovelFactory.shovel
        shovel.game.preload(shovel, game)

        game.load.image('dirt', 'dirt.png')


      create: (place, game)->
        console.log('place.game.create')

        map = game.add.tilemap('lair_tilemap')
        map.addTilesetImage('lair', 'lair_tiles')

        layer = map.createLayer('World1')
        layer.resizeWorld();
        layer.wrap = true;

        place.game.stuff = game.add.group()
        place.game.stuff.enableBody = true

        place.game.things = game.add.group()
        place.game.things.enableBody = true

        shovel = ShovelFactory.shovel
        shovel.game.create(shovel, game, place.game.stuff)

        dirt = DirtFactory.dirt
        dirt.game.create(dirt, game, place.game.things)

      update: (place, game, input)->

        place.game.stuff.forEach(
          (stuff, game, input)->
            stuff.update(stuff, game, input)
          , this
          , true
          , game
          , input
        )

        place.game.things.forEach(
          (thing, game, input)->
            thing.update(thing, game, input)
          , this
          , true
          , game
          , input
        )
