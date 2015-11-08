module = angular.module 'laired.Hero', []


module.factory 'HeroFactory',
()->
  console.log('HeroFactory')

  return {
    hero:
      bag:
        size: 2
        items: []

      hold:
        hand:
          left: null
          right: null

      ability:
        jump:
          velocity: 300

        run:
          velocity: 250

      interaction:
        overlapThing: (hero, thing, place, input)->
          null

        overlapStuff: (hero, stuff, place, input)->
          if input.ctrlButton.isDown
            hero.game.action.get.stuff(hero, stuff, place)

      game:
        action:
          jump: (hero)->
            velocity = hero.ability.jump.velocity
            hero.game.sprite.body.velocity.y = -velocity;

          run:
            stop: (hero)->
              hero.game.sprite.animations.stop()
              hero.game.sprite.frame = 4

            left: (hero)->
              velocity = hero.ability.run.velocity
              hero.game.sprite.body.velocity.x = -velocity
              hero.game.sprite.animations.play('left')

            right: (hero)->
              velocity = hero.ability.run.velocity;
              hero.game.sprite.body.velocity.x = velocity;
              hero.game.sprite.animations.play('right');

          get:
            stuff: (hero, stuff, place)->
              console.log('hero getting stuff')

              if stuff.hold.hand.right
                if hero.hold.hand.right
                  holding = hero.hold.hand.right
                  hero.hold.hand.right = null

                  if hero.hold.hand.left == holding
                    hero.hold.hand.left = null

                  hero.bag.items.push(holding)

              else if stuff.hold.hand.left
                if hero.hold.hand.left
                  holding = hero.hold.hand.left
                  hero.hold.hand.left = null

                  if hero.hold.hand.right == holding
                    hero.hold.hand.right = null

                  hero.bag.items.push(holding)

              if stuff.hold.hand.right
                if hero.hold.hand.right
                  console.log('hero holding something in right hand')
                else
                  hero.hold.hand.right = stuff
                  place.game.stuff.removeChild(stuff.game.sprite)
                  hero.game.sprite.addChild(stuff.game.sprite)
                  stuff.game.sprite.x = stuff.hold.game.sprite.x
                  stuff.game.sprite.y = stuff.hold.game.sprite.y
                  stuff.game.sprite.body.bounce.y = 0;
                  stuff.game.sprite.body.gravity.y = 0;

              else if stuff.hold.hand.left
                if hero.hold.hand.left
                  console.log('hero holding something in left hand')
                else
                  hero.hold.hand.left = stuff
                  place.game.stuff.removeChild(stuff.game.sprite)
                  hero.game.sprite.addChild(stuff.game.sprite)
                  stuff.game.sprite.x = stuff.hold.game.sprite.x
                  stuff.game.sprite.y = stuff.hold.game.sprite.y
                  stuff.game.sprite.body.bounce.y = 0;
                  stuff.game.sprite.body.gravity.y = 0;

          put:
            stuff: (hero, place)->
              console.log('hero putting stuff')

              if hero.hold.hand.right
                stuff = hero.hold.hand.right
                hero.hold.hand.right = null
                hero.game.sprite.removeChild(stuff.game.sprite)
                place.game.stuff.addChild(stuff.game.sprite)
                stuff.game.sprite.x = hero.game.sprite.x
                stuff.game.sprite.y = hero.game.sprite.y
                stuff.game.sprite.body.bounce.y = stuff.physics.body.bounce.y;
                stuff.game.sprite.body.gravity.y = stuff.physics.body.gravity.y;


              if hero.hold.hand.left
                stuff = hero.hold.hand.left
                hero.hold.hand.left = null
                hero.game.sprite.removeChild(stuff.game.sprite)
                place.game.stuff.addChild(stuff.game.sprite)
                stuff.game.sprite.x = hero.game.sprite.x
                stuff.game.sprite.y = hero.game.sprite.y
                stuff.game.sprite.body.bounce.y = stuff.physics.body.bounce.y;
                stuff.game.sprite.body.gravity.y = stuff.physics.body.gravity.y;


        preload: (hero, game)->
          console.log('hero.game.preload')
          game.load.spritesheet('hero', 'hero.png', 32, 48);


        create: (hero, game)->
          console.log('hero.game.create')

          hero.game.group = game.add.group()
          hero.game.group.hero = hero
          hero.game.group.enableBody = true
          game.physics.arcade.enable(hero.game.group);

          hero.game.sprite = game.add.sprite(100, 200, 'hero');
          hero.game.sprite.hero = hero
          hero.game.sprite.animations.add('left', [0, 1, 2, 3], 10, true);
          hero.game.sprite.animations.add('right', [5, 6, 7, 8], 10, true);

          game.physics.arcade.enable(hero.game.sprite);
          hero.game.sprite.enableBody = true
          hero.game.sprite.body.bounce.y = 0.2;
          hero.game.sprite.body.gravity.y = 500;
          hero.game.sprite.body.collideWorldBounds = true;

          hero.game.group.add(hero.game.sprite)

        update: (hero, game, input, place)->

          hero.game.sprite.body.velocity.x = 0

          if input.cursors.left.isDown
            hero.game.action.run.left(hero)

          else if input.cursors.right.isDown
            hero.game.action.run.right(hero)

          else
            hero.game.action.run.stop(hero)

          if input.cursors.up.isDown && (hero.game.sprite.body.onFloor() || hero.game.sprite.body.touching.down)
            hero.game.action.jump(hero)

          if input.ctrlButton.isDown
            if input.shiftButton.isDown
              hero.game.action.put.stuff(hero, place)
  }




module.controller 'HeroController',
($scope, HeroFactory)->
  console.log('HeroController')
  $scope.hero = HeroFactory.hero


