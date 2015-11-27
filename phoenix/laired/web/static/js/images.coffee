
module = angular.module 'laired.Images', []



module.factory 'ImagesLocation',
($location)->
  console.debug('ImagesLocation')

  url: ()->

    protocol = $location.protocol()
    host = $location.host()
    port = $location.port()

    "#{protocol}://#{host}:#{port}/images/"
