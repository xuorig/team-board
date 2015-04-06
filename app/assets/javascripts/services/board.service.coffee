angular.module('teamboard.services').factory 'Board', ['railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/boards"
    name: 'board'
]

angular.module('teamboard.services').factory 'BoardNested', ['railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/projects/{{projectId}}/boards"
    name: 'board'
]