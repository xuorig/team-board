angular
  .module('teamboard.controllers')
  .controller("BoardItemController", [ '$scope', '$routeParams', '_', 'BoardItem', 'CommentNested', 'Comment'
    ($scope, $routeParams, _, BoardItem, CommentNested, Comment)->
      $scope.itemId = null
      $scope.init = (itemId) ->
        $scope.itemId = itemId
        $scope.$watch 'item', ((newVal, oldVal) ->
          if !_.isEqual(oldVal, newVal)
            updateItem(newVal)
        ), true

        $scope.olderComments = []
        $scope.toShowComments = []
        $scope.commentOptions = {}
        getComments()

      getComments = () ->
        CommentNested.query({}, {boardItemId: $scope.itemId}).then ((results) ->
          $scope.toShowComments = results
          $scope.olderComments = $scope.toShowComments.splice(0, Math.max(results.length - 2, 0))
          console.log results
          return
        ), (error) ->
          # do something about the error
          return

      updateItem = (newVal) ->
        console.log newVal
        BoardItem.get(newVal.id).then (boardItem) ->
          boardItem.title = newVal.title
          boardItem.noteContent = newVal.noteContent
          boardItem.color = newVal.color
          boardItem.update()
          return

      $scope.deleteNote = () ->
        BoardItem.get($scope.itemId).then (boardItem) ->
          boardItem.delete().then (res) ->
            #remove item from $scope
            _.each($scope.splitItems, (column, index) ->
              $scope.splitItems[index] = _.without(column, $scope.item)
            ) 
            return

      $scope.postComment = () ->
        new CommentNested({
          boardItemId: $scope.itemId,
          content: $scope.newComment
        }).create()

        getComments()
        $scope.newComment = null

      $scope.changeNoteColor = (color) ->
        $scope.item.color = color
  ])