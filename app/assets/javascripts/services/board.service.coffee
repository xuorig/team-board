angular.module('teamboard.services').factory 'Board', ['railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/boards"
    name: 'board'
]