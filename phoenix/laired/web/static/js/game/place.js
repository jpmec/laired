var lairedPlace = angular.module('lairedPlace', []);



lairedPlace.factory('PlaceFactory', function(
    ShovelFactory,
    DirtFactory
) {
    console.log('PlaceFactory')

    return {
        place: {
            game: {
                preload: function(place, game) {
                    console.log('place.game.preload')

                    var shovel = ShovelFactory.shovel
                    shovel.game.preload(shovel, game)

                    game.load.image('dirt', 'dirt.png');
                },

                create: function(place, game) {
                    console.log('place.game.create')

                    place.game.stuff = game.add.group()
                    place.game.stuff.enableBody = true

                    place.game.things = game.add.group()
                    place.game.things.enableBody = true

                    var shovel = ShovelFactory.shovel
                    shovel.game.create(shovel, game, place.game.stuff)

                    var dirt = DirtFactory.dirt
                    dirt.game.create(dirt, game, place.game.things)
                },

                update: function(place, game) {
                }
            }
        }
    }
});
