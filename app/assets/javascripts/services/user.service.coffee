angular.module('teamboard.services').factory 'User', ['railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/users"
    name: 'user'
]
