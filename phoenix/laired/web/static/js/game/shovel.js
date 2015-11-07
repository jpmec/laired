var lairedShovel = angular.module('lairedShovel', []);


lairedShovel.factory('ShovelFactory', function() {
    console.log('ShovelFactory')

    return {
        shovel: {
            ability: {
                dig: {
                    velocity: 250
                }
            },

            game: {
                actions: {
                    dig: function(shovel) {
                        console.log('shovel.game.actions.dig')

                        var velocity = shovel.ability.jump.velocity

                        shovel.game.sprite.body.velocity.y = -velocity;
                    }
                },

                preload: function(shovel, game) {
                    console.log('shovel.game.preload')

                    game.load.image('shovel', 'sprites/things/shovel.png');
                },

                create: function(shovel, game) {
                    console.log('shovel.game.create')

                    shovel.game.sprite = game.add.sprite(100, 200, 'shovel');
                    game.physics.arcade.enable(shovel.game.sprite);

                    shovel.game.sprite.body.collideWorldBounds = true;

                    shovel.game.sprite.body.bounce.y = 0.2;
                    shovel.game.sprite.body.gravity.y = 500;
                },

                update: function(shovel, game, input) {
                    shovel.game.sprite.body.velocity.x = 0;
                }
            }
        }
    }
});


