angular
  .module('teamboard.controllers')
  .controller("BoardItemController", [ '$scope', '$routeParams', '_', 'BoardItem'
    ($scope, $routeParams, _, BoardItem)->
      $scope.$watch 'item', ((oldVal, newVal) ->
        if !_.isEqual(oldVal, newVal)
          updateItem(oldVal, newVal)
          console.log('object changed')
      ), true

      updateItem = (oldVal, newVal) ->
        BoardItem.get({boardId: $routeParams.board_id, id: newVal.id}).then (boardItem) ->
          console.log boardItem
          boardItem.title = newVal.title
          boardItem.noteContent = newVal.noteContent
          boardItem.position = newVal.position
          boardItem.uiColumn = newVal.uiColumn
          boardItem.update()
          return
  ])