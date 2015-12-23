

module = angular.module 'laired.DisplayGroupViewer', []




module.factory 'DisplayGroupViewerPreloaderFactory',
($location, ImagesLocation, DisplayGroupPreloaderFactory)->
  console.log('DisplayGroupViewerPreloader')

  (display_group)->
    preload: (game)->
      console.log('DisplayGroupViewerPreloader.preload')

      game.stage.backgroundColor = '#000000'
      game.load.baseURL = ImagesLocation.url()

      DisplayGroupPreloaderFactory(display_group).preload(game)




module.factory 'DisplayGroupViewerCreaterFactory',
(DisplayGroupCreaterFactory)->
  console.log('DisplayGroupViewerCreater')

  (display_group)->
    create: (game)->
      console.log('DisplayGroupViewerCreater.create')

      DisplayGroupCreaterFactory(display_group).create(game)




module.factory 'DisplayGroupViewerUpdater',
()->
  console.log('DisplayGroupViewerUpdater')

  update: (game)->
#    console.log('TilemapViewerUpdater.update')
    null




module.factory 'DisplayGroupViewerFactory',
(DisplayGroupViewerPreloaderFactory, DisplayGroupViewerCreaterFactory, DisplayGroupViewerUpdater)->
  console.log('DisplayGroupViewerFactory')

  (display_group, kwargs)->
    console.log('DisplayGroupViewerFactory creating ' + JSON.stringify(kwargs))

    kwargs_ = _.merge({
        width: 100
        height: 100
        id: 'display_group_viewer_div'
      }
    , kwargs)

    new Phaser.Game(
      kwargs_.width, kwargs_.height,
      Phaser.AUTO,
      kwargs_.id,
      {
        preload: DisplayGroupViewerPreloaderFactory(display_group).preload,
        create: DisplayGroupViewerCreaterFactory(display_group).create,
        update: DisplayGroupViewerUpdater.update
      }
    )




module.controller 'DisplayGroupViewerController',
($scope, DisplayGroupsApiResource, DisplayGroup, DisplayGroupFactory, DisplayGroupViewerFactory)->
  console.log('DisplayGroupViewerController')

  $scope.game = null
  $scope.display_group = DisplayGroup


  $scope.initialize = ()->
    console.debug('DisplayGroupsController.initialize')

    resource = DisplayGroupsApiResource.get {id: 1}
    resource.$promise.then (data)->
        console.debug('DisplayGroupsController.initialize resource promise then ' + JSON.stringify(data))

        DisplayGroup.object = DisplayGroupFactory(data)
        $scope.game = DisplayGroupViewerFactory DisplayGroup.object

  $scope.initialize()




module.directive 'displayGroupViewer',
()->
  console.log('displayGroupViewer')

  {
    scope:
      id: '='
    template: '<div id="display_group_viewer_div">{{id}}{{object | json}}</div>'
    controller: (
      $scope,
      $timeout,
      DisplayGroupsApiResource,
      DisplayGroup,
      DisplayGroupFactory,
      DisplayGroupViewerFactory
    )->

      $scope.get = ()->
        console.debug('displayGroupViewer.controller.get ' + $scope.id)

        resource = DisplayGroupsApiResource.get {id: $scope.id}
        resource.$promise.then (data)->
          console.debug('display_groupViewer.controller.initialize resource promise then data ' + JSON.stringify(data))

          DisplayGroup.object = DisplayGroupFactory(data)

          $scope.game = DisplayGroupViewerFactory DisplayGroup.object

        , (error)->
          console.debug('displayGroupViewer.controller.initialize resource promise then error ' + JSON.stringify(error))

          $timeout ()->
            $scope.get()


      $scope.initialize = ()->
        console.debug('displayGroupViewer.controller.initialize ' + $scope.id)
        $scope.get()

      $scope.initialize()
  }
