angular.module('teamboard',[
  'templates',
  'ngRoute',
  'teamboard.services'
  'teamboard.controllers',
  'ngResource',
  'ngAnimate',
  'oitozero.ngSweetAlert',
  'ui.bootstrap',
  'ui.sortable',
  'ui.calendar',
  'xeditable',
])

angular.module('teamboard').config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]

angular.module('teamboard').run( ['editableOptions', (editableOptions) ->
  editableOptions.theme = 'bs3'
])

angular.module('teamboard.services', ['rails']);

controllers = angular.module('teamboard.controllers',[])

controllers.controller("HomeController", [ '$scope',
  ($scope)->
])

controllers.controller("BoardController", [ '$scope',
  ($scope)->
])