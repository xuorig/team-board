angular.module('teamboard.services').factory 'Team', ['railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/projects"
    name: 'project'
]
