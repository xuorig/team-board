angular.module('teamboard.services').factory 'Managership', ['railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/managerships"
    name: 'managership'
]