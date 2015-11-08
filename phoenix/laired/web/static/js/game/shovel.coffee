var module = angular.module('laired.Stuff.Shovel', []);


module.factory'ShovelFactory',
()->
  console.log('ShovelFactory')

    shovel:
      name: 'shovel'
      description: 'used to dig dirt'

      weight: 5

      physics:
        body:
          bounce:
            y: 0.2
          gravity:
            y: 500

      hold:
        hand:
          right: true
        game:
          sprite:
            x: 20
            y: 20

      ability:
        dig:
          rate: 0.1

      game:
        actions:
          dig: (shovel)->
            console.log('shovel.game.actions.dig')

        preload: (shovel, game)->
          console.log('shovel.game.preload')
          game.load.image('shovel', 'sprites/stuff/shovel.png')

        create: (shovel, game, group)->
          console.log('shovel.game.create')

          if (group) {
            shovel.game.sprite = group.create(200, 200, 'shovel')
          }
          else {
            shovel.game.sprite = game.add.sprite(200, 200, 'shovel')
          }

          shovel.game.sprite.stuff = shovel
          game.physics.arcade.enable(shovel.game.sprite)
          shovel.game.sprite.body.collideWorldBounds = true
          shovel.game.sprite.body.bounce.y = shovel.physics.body.bounce.y
          shovel.game.sprite.body.gravity.y = shovel.physics.body.gravity.y

        update: (shovel, game, input)->
          shovel.game.sprite.body.velocity.x = 0
