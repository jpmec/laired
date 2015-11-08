module = angular.module 'laired.Thing.Dirt', []


module.factory 'DirtFactory',
()->
  console.log('DirtFactory')


  dirt:
    game:
      preload: (dirt, game)->
        console.log('dirt.game.preload')
        game.load.image('dirt', 'sprites/dirt.png')

      create: (dirt, game, group)->
        console.log('dirt.game.create')

        if group
          dirt.game.sprite = group.create(300, 500, 'dirt')
        else
          dirt.game.sprite = game.add.sprite(300, 500, 'dirt');

        dirt.game.sprite.thing = dirt
        game.physics.arcade.enable(dirt.game.sprite);
        dirt.game.sprite.body.collideWorldBounds = true;
        dirt.game.sprite.checkCollision = true
        dirt.game.sprite.immovable = true

      update: (dirt, game, input)->
        dirt.game.sprite.body.velocity.x = 0;
