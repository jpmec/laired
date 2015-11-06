
var lairedApp = angular.module('lairedApp',
    [
        'lairedHero'
    ]
);




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




lairedApp.factory('GamePreloader', function(
    HeroFactory
) {
    console.log('GamePreloader')

    return {
        preload: function preload(game) {
            game.stage.backgroundColor = '#000000';

            game.load.baseURL = 'images/';

            var hero = HeroFactory.hero
            hero.game.preload(hero, game)

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
            hero.game.create(hero, game)



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

            hero.game.update(hero, game, input)
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

