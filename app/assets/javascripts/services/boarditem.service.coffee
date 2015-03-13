angular.module('teamboard.services').factory 'BoardItemNested', ['railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/boards/{{boardId}}/board_items"
    name: 'board_item'
]

angular.module('teamboard.services').factory 'BoardItem', ['railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/board_items"
    name: 'board_item'
]