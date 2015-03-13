angular
  .module('teamboard.controllers')
  .controller("BoardItemController", [ '$scope', '$routeParams', '_', 'BoardItem'
    ($scope, $routeParams, _, BoardItem)->
      # $scope.$watch 'item', ((oldVal, newVal) ->
      #   if !_.isEqual(oldVal, newVal)
      #     updateItem(oldVal, newVal)
      #     console.log('object changed')
      # ), true

      updateItem = () ->
        console.log $scope.item
        # BoardItem.get(id).then (boardItem) ->
        #   console.log newTitle
        #   console.log newContent
        #   boardItem.title = newTitle
        #   boardItem.noteContent = newContent
        #   boardItem.update()
        #   return
  ])