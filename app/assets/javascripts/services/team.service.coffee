angular.module('teamboard.services').factory 'Team', ['railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/teams"
    name: 'team'
]
