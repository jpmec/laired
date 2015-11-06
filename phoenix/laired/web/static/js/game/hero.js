var lairedHero = angular.module('lairedHero', []);


lairedHero.factory('HeroFactory', function() {
    console.log('HeroFactory')

    return {
        hero: {
            preload: function(game, hero) {
                game.load.spritesheet('hero', 'hero.png', 32, 48);
            },

            create: function(game, hero) {
                hero.sprite = game.add.sprite(100, 200, 'hero');
                game.physics.arcade.enable(hero.sprite);

                hero.sprite.body.collideWorldBounds = true;

                hero.sprite.body.bounce.y = 0.2;
                hero.sprite.body.gravity.y = 500;

                hero.sprite.animations.add('left', [0, 1, 2, 3], 10, true);
                hero.sprite.animations.add('right', [5, 6, 7, 8], 10, true);
            },

            update: function(game, hero, input) {

                hero.sprite.body.velocity.x = 0;

                if (input.cursors.left.isDown)
                {
                    // if (input.actionButton.isDown && hero.sprite.body.touching.left)
                    // {
                    //     console.log('input.actionButton.isDown left');
                    // }
                    // else
                    // {
                    hero.sprite.body.velocity.x = -250;
                    hero.sprite.animations.play('left');
                    // }
                }
                else if (input.cursors.right.isDown)
                {
                    // if (input.actionButton.isDown && hero.sprite.body.touching.right)
                    // {
                    //     console.log('input.actionButton.isDown right');
                    // }
                    // else
                    // {
                    hero.sprite.body.velocity.x = 250;
                    hero.sprite.animations.play('right');
                    // }
                }
                else {
                    hero.sprite.animations.stop();
                    hero.sprite.frame = 4;
                }

                if (input.cursors.up.isDown && (hero.sprite.body.onFloor() || hero.sprite.body.touching.down))
                {
                    hero.sprite.body.velocity.y = -400;
                }


            }
        }
    }
});


