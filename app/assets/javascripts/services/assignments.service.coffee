angular.module('teamboard.services').factory 'Assignment', ['railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/assignments"
    name: 'assignment'
]