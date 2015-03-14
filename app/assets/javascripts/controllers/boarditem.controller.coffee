angular
  .module('teamboard.controllers')
  .controller("BoardItemController", [ '$scope', '$routeParams', '_', 'BoardItem'
    ($scope, $routeParams, _, BoardItem)->
      $scope.$watch 'item', ((newVal, oldVal) ->
        if !_.isEqual(oldVal, newVal)
          updateItem(newVal)
      ), true

      updateItem = (newVal) ->
        BoardItem.get(newVal.id).then (boardItem) ->
          boardItem.title = newVal.title
          boardItem.noteContent = newVal.noteContent
          boardItem.update()
          return
  ])