var lairedDirt = angular.module('lairedDirt', []);


lairedDirt.factory('DirtFactory', function() {
    console.log('DirtFactory')

    return {
        dirt: {
            game: {
                preload: function(dirt, game) {
                    console.log('dirt.game.preload')

                    game.load.image('dirt', 'sprites/dirt.png');
                },

                create: function(dirt, game, group) {
                    console.log('dirt.game.create')


                    if (group) {
                        dirt.game.sprite = group.create(300, 500, 'dirt')
                    }
                    else {
                        dirt.game.sprite = game.add.sprite(300, 500, 'dirt');
                    }

                    dirt.game.sprite.thing = dirt

                    game.physics.arcade.enable(dirt.game.sprite);

                    dirt.game.sprite.body.collideWorldBounds = true;

                    dirt.game.sprite.checkCollision = true
                    dirt.game.sprite.immovable = true

                    //dirt.game.sprite.body.bounce.y = 0.2;
                    //dirt.game.sprite.body.gravity.y = 500;
                },

                update: function(dirt, game, input) {
                    dirt.game.sprite.body.velocity.x = 0;
                }
            }
        }
    }
});


