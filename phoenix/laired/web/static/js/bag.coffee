

module = angular.module 'laired.Bag', []




module.factory 'BagsApiResource',
($resource)->
  console.debug('BagsApiResource')

  $resource('/api/bags/:id')




module.factory 'Bag',
()->
  console.log('Bag')
  object:
    null




module.factory 'BagFactory',
()->
  console.log('BagFactory')

  (bag_api_object, object)->
    console.log('BagFactory creating from ' + JSON.stringify(bag_api_object) + ' into ' + JSON.stringify(object))

    if not object?
      object = _.cloneDeep(bag_api_object)

    object




module.factory 'BagPreloaderFactory',
(StuffPreloaderFactory)->
  console.log('BagPreloaderFactory')

  (bag)->
    console.log('BagPreloader')

    preload: (game)->
      console.log('BagPreloader.preload')

      _.forEach bag.stuffs, (stuff)->
        StuffPreloaderFactory(stuff).preload(game)




module.factory 'BagCreaterFactory',
(StuffCreaterFactory)->
  console.log('BagCreaterFactory')

  (bag)->
    console.log('BagCreater')

    create: (game)->
      console.log('BagCreater.create')

      _.forEach bag.stuffs, (stuff)->
        StuffCreaterFactory(stuff).create(game)
