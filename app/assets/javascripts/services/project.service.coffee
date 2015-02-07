angular.module('teamboard.services').factory 'Project', ['railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/projects"
    name: 'project'
]