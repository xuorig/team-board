angular.module('teamboard.services').factory 'CommentNested', ['railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/board_items/{{boardItemId}}/comments"
    name: 'comment'
]

angular.module('teamboard.services').factory 'Comment', ['railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/comments"
    name: 'comment'
]