angular.module('teamboard',[
  'templates',
  'ngRoute',
  'teamboard.services'
  'teamboard.controllers',
  'ngResource',
  'ngAnimate',
  'oitozero.ngSweetAlert',
  'ui-bootstrap',
])

angular.module('teamboard').config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]

controllers = angular.module('teamboard.controllers',[])

controllers.controller("HomeController", [ '$scope',
  ($scope)->
])

controllers.controller("BoardController", [ '$scope',
  ($scope)->
])