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

        $scope.comments = []
        getComments()

      getComments = () ->
        CommentNested.query({}, {boardItemId: $scope.itemId}).then ((results) ->
          $scope.comments = results
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