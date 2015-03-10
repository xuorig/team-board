angular.module('teamboard.services').factory 'BoardItem', ['railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/boards/{{boardId}}/board_items"
    name: 'board_item'
]