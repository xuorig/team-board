§angular.module('teamboard.services').factory 'CommentsNested', ['railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/board_items/{{boardItemId}}/comments"
    name: 'comment'
]

angular.module('teamboard.services').factory 'Comments', ['railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/comments"
    name: 'comment'
]