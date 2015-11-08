
module = angular.module 'laired.Place', []


module.factory 'PlaceFactory',
(ShovelFactory, DirtFactory)->
  console.log('PlaceFactory')

  place:
    game:
      preload: (place, game)->
        console.log('place.game.preload')

        shovel = ShovelFactory.shovel
        shovel.game.preload(shovel, game)

        game.load.image('dirt', 'dirt.png');

      create: (place, game)->
        console.log('place.game.create')

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
