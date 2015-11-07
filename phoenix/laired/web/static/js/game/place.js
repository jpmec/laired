var lairedPlace = angular.module('lairedPlace', []);



lairedPlace.factory('PlaceFactory', function(
    ShovelFactory
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

                create: function(hero, game) {
                    console.log('place.game.create')

                    var shovel = ShovelFactory.shovel
                    shovel.game.create(shovel, game)
                },

                update: function(hero, game) {

                }
            }
        }
    }
});
