var lairedHero = angular.module('lairedHero', []);


lairedHero.factory('HeroFactory', function() {
    console.log('HeroFactory')

    return {
        hero: {

            bag: {
                size: 2,
                items: []
            },

            hold: {
                hand: {
                    left: null,
                    right: null
                }
            },

            ability: {
                jump: {
                    velocity: 300
                },

                run: {
                    velocity: 250
                }
            },

            interaction: {
                overlapThing: function(hero, thing, input) {
                },

                overlapStuff: function(hero, stuff, input) {
                    if (input.ctrlButton.isDown) {
                        hero.game.action.get.stuff(hero, stuff)
                    }
                }
            },

            game: {
                action: {
                    jump: function(hero) {
                        console.log('hero.game.actions.jump')

                        var velocity = hero.ability.jump.velocity

                        hero.game.sprite.body.velocity.y = -velocity;
                    },

                    run: {
                        stop: function(hero) {
                            hero.game.sprite.animations.stop();
                            hero.game.sprite.frame = 4;
                        },

                        left: function(hero) {
//                            console.log('hero.game.actions.run.left')

                            var velocity = hero.ability.run.velocity;

                            hero.game.sprite.body.velocity.x = -velocity;
                            hero.game.sprite.animations.play('left');
                        },

                        right: function(hero) {
//                            console.log('hero.game.actions.run.right')

                            var velocity = hero.ability.run.velocity;

                            hero.game.sprite.body.velocity.x = velocity;
                            hero.game.sprite.animations.play('right');
                        }
                    },

                    get: {
                        stuff: function(hero, stuff) {
                            console.log('hero getting stuff')

                            stuff.game.sprite.kill();

                            if (stuff.hold.hand.right) {
                                if (hero.hold.hand.right) {
                                    holding = hero.hold.hand.right
                                    hero.hold.hand.right = null

                                    if (hero.hold.hand.left === holding) {
                                        hero.hold.hand.left = null
                                    }

                                    hero.bag.items.push(holding);
                                }
                            }

                            else if (stuff.hold.hand.left) {
                                if (hero.hold.hand.left) {
                                    holding = hero.hold.hand.left
                                    hero.hold.hand.left = null

                                    if (hero.hold.hand.right === holding) {
                                        hero.hold.hand.right = null
                                    }

                                    hero.bag.items.push(holding);
                                }
                            }


                            if (stuff.hold.hand.right) {
                                if (hero.hold.hand.right) {
                                    console.log('hero holding something in right hand')
                                }
                                else {
                                    hero.hold.hand.right = stuff
                                }
                            }

                            else if (stuff.hold.hand.left) {
                                if (hero.hold.hand.left) {
                                    console.log('hero holding something in left hand')
                                }
                                else {
                                    hero.hold.hand.left = stuff
                                }
                            }
                        }
                    }
                },

                preload: function(hero, game) {
                    console.log('hero.game.preload')

                    game.load.spritesheet('hero', 'hero.png', 32, 48);
                },

                create: function(hero, game) {
                    console.log('hero.game.create')

                    hero.game.sprite = game.add.sprite(100, 200, 'hero');
                    hero.game.sprite.hero = hero

                    game.physics.arcade.enable(hero.game.sprite);

                    hero.game.sprite.body.collideWorldBounds = true;

                    hero.game.sprite.body.bounce.y = 0.2;
                    hero.game.sprite.body.gravity.y = 500;

                    hero.game.sprite.animations.add('left', [0, 1, 2, 3], 10, true);
                    hero.game.sprite.animations.add('right', [5, 6, 7, 8], 10, true);
                },

                update: function(hero, game, input) {

                    hero.game.sprite.body.velocity.x = 0;

                    if (input.cursors.left.isDown)
                    {
                        // if (input.actionButton.isDown && hero.sprite.body.touching.left)
                        // {
                        //     console.log('input.actionButton.isDown left');
                        // }
                        // else
                        // {
                        hero.game.action.run.left(hero)
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
                        hero.game.action.run.right(hero);
                        // }
                    }
                    else {
                        hero.game.action.run.stop(hero);
                    }

                    if (input.cursors.up.isDown && (hero.game.sprite.body.onFloor() || hero.game.sprite.body.touching.down))
                    {
                        hero.game.action.jump(hero);
                    }
                }
            }
        }
    }
});





lairedHero.controller('HeroController', function($scope, HeroFactory) {
    console.log('HeroController')

    $scope.hero = HeroFactory.hero


});

