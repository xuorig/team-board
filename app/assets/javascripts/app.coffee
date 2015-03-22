angular.module('teamboard',[
  'templates',
  'ngRoute',
  'teamboard.services'
  'teamboard.controllers',
  'teamboard.directives',
  'ngResource',
  'ngAnimate',
  'oitozero.ngSweetAlert',
  'ui.bootstrap',
  'ui.sortable',
  'ui.calendar',
  'xeditable',
  'ng-context-menu',
])

angular.module('teamboard').config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]

angular.module('teamboard').run( ['editableOptions', (editableOptions) ->
  editableOptions.theme = 'bs3'
])

angular.module('teamboard.services', ['rails']);
angular.module('teamboard.directives', [])

controllers = angular.module('teamboard.controllers',[])

controllers.controller("HomeController", [ '$scope',
  ($scope)->
])

controllers.controller("BoardController", [ '$scope',
  ($scope)->
])