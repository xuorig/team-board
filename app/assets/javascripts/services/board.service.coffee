angular.module('teamboard.services').factory 'Board', ['railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/projects/{{project_id}}/boards/{{id}}"
    name: 'board'
]