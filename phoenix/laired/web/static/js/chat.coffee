
module = angular.module 'laired.Chat', []


module.controller 'ChatController',
($scope, AngelFactory)->

  $scope.chat = {
    "new_message":  '',
    "messages": [
      'Hello world'
    ]
  }

  $scope.submit = ()->
    console.log('submit')
    $scope.chat.messages.unshift($scope.chat.new_message)
    $scope.chat.new_message = ''

