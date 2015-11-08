
var lairedGame = angular.module('lairedGame', []);




lairedGame.factory('GameInputFactory', function() {
    console.log('GameInputFactory')

    return {
        input: {
            create: function(game, input) {
                input.cursors = game.input.keyboard.createCursorKeys();
                input.altButton = game.input.keyboard.addKey(Phaser.Keyboard.ALT);
                input.ctrlButton = game.input.keyboard.addKey(Phaser.Keyboard.CONTROL);
                input.shiftButton = game.input.keyboard.addKey(Phaser.Keyboard.SHIFT);
            }
        }
    }
});




lairedGame.factory('GamePreloader', function(
    HeroFactory,
    PlaceFactory
) {
    console.log('GamePreloader')

    return {
        preload: function preload(game) {
            game.stage.backgroundColor = '#000000';
            game.load.baseURL = 'images/';

            var hero = HeroFactory.hero
            hero.game.preload(hero, game)

            var place = PlaceFactory.place
            place.game.preload(place, game)
        }
    };
});




lairedGame.factory('GameCreater', function(
    GameInputFactory,
    HeroFactory,
    PlaceFactory
) {
    console.log('GameCreater')

    // var platforms;

    return {
        create: function(game) {
            var input = GameInputFactory.input
            input.create(game, input)

            var hero = HeroFactory.hero
            hero.game.create(hero, game)

            var place = PlaceFactory.place
            place.game.create(place, game)

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




lairedGame.factory('GameUpdater', function(
    GameInputFactory,
    HeroFactory,
    PlaceFactory
) {
    console.log('GameUpdater')

    return {
        update: function(game) {
            var input = GameInputFactory.input

            var hero = HeroFactory.hero
            var place = PlaceFactory.place


            game.physics.arcade.overlap(
                hero.game.sprite,
                place.game.stuff,
                function(hero_sprite, stuff_sprite) {
                    hero_sprite.hero.interaction.overlapStuff(hero_sprite.hero, stuff_sprite.stuff, input)
                }
            );


            game.physics.arcade.overlap(
                hero.game.sprite,
                place.game.things,
                function(hero_sprite, thing_sprite) {
                    hero_sprite.hero.interaction.overlapThing(hero_sprite.hero, thing_sprite.thing, input)
                }
            );

            game.physics.arcade.collide(
                hero.game.sprite,
                place.game.things
            );


            hero.game.update(hero, game, input)
            place.game.update(place, game)
        }
    };
});




lairedGame.factory('GameFactory', function(
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




lairedGame.controller('GameController', function ($scope, GameFactory) {
    $scope.game = GameFactory.game
});




