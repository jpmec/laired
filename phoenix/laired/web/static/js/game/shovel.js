var lairedShovel = angular.module('lairedShovel', []);


lairedShovel.factory('ShovelFactory', function() {
    console.log('ShovelFactory')

    return {
        shovel: {
            name: 'shovel',
            description: 'used to dig dirt',

            weight: 5,

            hold: {
                hand: {
                    right: true
                },
                game: {
                    sprite: {
                        x: 20,
                        y: 20
                    }
                }
            },

            ability: {
                dig: {
                    rate: 0.1
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

                    game.load.image('shovel', 'sprites/stuff/shovel.png');
                },

                create: function(shovel, game, group) {
                    console.log('shovel.game.create')

                    if (group) {
                        shovel.game.sprite = group.create(200, 200, 'shovel')
                        shovel.game.sprite.stuff = shovel

                        game.physics.arcade.enable(shovel.game.sprite);

                        shovel.game.sprite.body.collideWorldBounds = true;

                        shovel.game.sprite.body.bounce.y = 0.2;
                        shovel.game.sprite.body.gravity.y = 500;

                    }
                    else {
                        shovel.game.sprite = game.add.sprite(200, 200, 'shovel');
                        game.physics.arcade.enable(shovel.game.sprite);

                        shovel.game.sprite.body.collideWorldBounds = true;

                        shovel.game.sprite.body.bounce.y = 0.2;
                        shovel.game.sprite.body.gravity.y = 500;

                    }
                },

                update: function(shovel, game, input) {
                    shovel.game.sprite.body.velocity.x = 0;
                }
            }
        }
    }
});


