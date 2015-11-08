

module = angular.module 'laired.Game', []




module.factory 'GameInputFactory',
()->
  console.log('GameInputFactory')

  input:
    create: (game, input)->
      input.cursors = game.input.keyboard.createCursorKeys();
      input.altButton = game.input.keyboard.addKey(Phaser.Keyboard.ALT);
      input.ctrlButton = game.input.keyboard.addKey(Phaser.Keyboard.CONTROL);
      input.shiftButton = game.input.keyboard.addKey(Phaser.Keyboard.SHIFT);




module.factory 'GamePreloader',
(HeroFactory, PlaceFactory)->
  console.log('GamePreloader')

  preload: (game)->
    game.stage.backgroundColor = '#000000';
    game.load.baseURL = 'images/';

    hero = HeroFactory.hero
    hero.game.preload(hero, game)

    place = PlaceFactory.place
    place.game.preload(place, game)




module.factory 'GameCreater',
(GameInputFactory, HeroFactory, PlaceFactory)->
  console.log('GameCreater')

  create: (game)->
    input = GameInputFactory.input
    input.create(game, input)

    hero = HeroFactory.hero
    hero.game.create(hero, game)

    place = PlaceFactory.place
    place.game.create(place, game)




module.factory 'GameUpdater',
(GameInputFactory, HeroFactory, PlaceFactory)->
  console.log('GameUpdater')

  update: (game)->
    input = GameInputFactory.input
    hero = HeroFactory.hero
    place = PlaceFactory.place

    game.physics.arcade.overlap(
      hero.game.sprite,
      place.game.stuff,
      (hero_sprite, stuff_sprite)->
        hero_sprite.hero.interaction.overlapStuff(hero_sprite.hero, stuff_sprite.stuff, place, input)
    )

    game.physics.arcade.overlap(
      hero.game.sprite,
      place.game.things,
      (hero_sprite, thing_sprite)->
        hero_sprite.hero.interaction.overlapThing(hero_sprite.hero, thing_sprite.thing, place, input)
    )

    game.physics.arcade.collide(
      hero.game.sprite,
      place.game.things
    )

    hero.game.update(hero, game, input, place)
    place.game.update(place, game)




module.factory 'GameFactory',
(GamePreloader, GameCreater, GameUpdater)->
  console.log('GameFactory')

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




module.controller 'GameController',
($scope, GameFactory)->
  $scope.game = GameFactory.game
