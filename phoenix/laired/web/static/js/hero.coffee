

module = angular.module 'laired.Hero', []




module.factory 'HerosApiResource',
($resource)->
  console.debug('HerosApiResource')

  $resource('/api/heros/:id')




module.factory 'Hero',
()->
  console.log('Hero')
  object:
    null




module.factory 'HeroFactory',
()->
  console.log('HeroFactory')

  (hero_api_object, object)->
    console.log('HeroFactory creating from ' + JSON.stringify(hero_api_object) + ' into ' + JSON.stringify(object))

    if not object?
      object = _.cloneDeep(hero_api_object)

    object




module.factory 'HeroPreloaderFactory',
(
  BagPreloaderFactory
  DisplayGroupPreloaderFactory
)->
  console.log('HeroPreloaderFactory')

  (hero)->
    console.log('HeroPreloader')

    preload: (game)->
      console.log('HeroPreloader.preload')

#      if hero.bag
#        BagPreloaderFactory(hero.bag).preload(game)

      if hero.display_group
        DisplayGroupPreloaderFactory(hero.display_group).preload(game)




module.factory 'HeroCreaterFactory',
(
  BagCreaterFactory
  DisplayGroupCreaterFactory
)->
  console.log('HeroCreaterFactory')

  (hero)->
    console.log('HeroCreater')

    create: (game)->
      console.log('HeroCreater.create')

#      if hero.bag
#        BagCreaterFactory(hero.bag).create(game)

      if hero.display_group
        DisplayGroupCreaterFactory(hero.display_group).create(game)
