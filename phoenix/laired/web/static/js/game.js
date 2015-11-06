

var lairedApp = angular.module('lairedApp', []);




lairedApp.factory('GameInputFactory', function() {
    console.log('GameInputFactory')

    return {
        input: {
            create: function(game, input) {
                input.cursors = game.input.keyboard.createCursorKeys();
                input.actionButton = game.input.keyboard.addKey(Phaser.Keyboard.ALT);
            }
        }
    }
});




lairedApp.factory('HeroFactory', function() {
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




lairedApp.factory('GamePreloader', function(
    HeroFactory
) {
    console.log('GamePreloader')

    return {
        preload: function preload(game) {
            game.stage.backgroundColor = '#000000';

            game.load.baseURL = 'images/';

            var hero = HeroFactory.hero
            hero.preload(game, hero)

            game.load.image('dirt', 'dirt.png');
        }
    };
});




lairedApp.factory('GameCreater', function(
    GameInputFactory,
    HeroFactory
) {
    console.log('GameCreater')

    // var platforms;

    return {
        create: function(game) {
            var input = GameInputFactory.input
            input.create(game, input)

            var hero = HeroFactory.hero
            hero.create(game, hero)



            // platforms = game.add.physicsGroup();

            // platforms.create(0, 0, 'dirt');
            // platforms.create(50, 50, 'dirt');
            // platforms.create(100, 100, 'dirt');
            // platforms.create(150, 150, 'dirt');
            // platforms.create(200, 200, 'dirt');
            // platforms.create(250, 250, 'dirt');
            // platforms.create(300, 300, 'dirt');
            // platforms.create(350, 350, 'dirt');


            // platforms.setAll('body.immovable', true);
        }
    };
});




lairedApp.factory('GameUpdater', function(
    GameInputFactory,
    HeroFactory
) {
    console.log('GameUpdater')

    return {
        update: function(game) {
            var input = GameInputFactory.input
            var hero = HeroFactory.hero

            hero.update(game, hero, input)
        }
    };
});




lairedApp.factory('GameFactory', function(
    GamePreloader,
    GameCreater,
    GameUpdater
) {
    console.log('GameFactory')
    return {
        game: new Phaser.Game(
            670, 480,
            Phaser.AUTO,
            'game_div',
            {
                preload: GamePreloader.preload,
                create: GameCreater.create,
                update: GameUpdater.update
            }
        )
    }
});




lairedApp.controller('GameController', function ($scope, GameFactory) {
    $scope.game = GameFactory.game
});




lairedApp.controller('ChatController', function ($scope) {

  $scope.chat = {
    "new_message":  'whazzup',
    "messages": [
        'Hello world'
    ]
  }

  $scope.submit = function() {
    console.log('submit')
    $scope.chat.messages.unshift($scope.chat.new_message)
    $scope.chat.new_message = ''
  }

});

