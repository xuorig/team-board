angular
  .module('teamboard.controllers')
  .controller("DashboardController", [ '$scope', 'CurrentUser', 'Board', 'Comment', 'BoardItem'
    ($scope, CurrentUser, Board, Comment, BoardItem)->
      init = () ->
        $scope.currentUser = null
        $scope.boards = []
        $scope.comments = []
        $scope.itemsDueSoon = []

        CurrentUser.getUser().then (data) ->
          $scope.currentUser = data

        Board.query({recently_updated: true, limit: 5}).then ((results) ->
          $scope.boards = results
          return
        ), (error) ->
          # do something about the error
          return

        Comment.query({limit: 5}).then ((data) ->
          $scope.comments = data
        )

        BoardItem.query({due_soon: true, limit: 10}).then ((data) ->
          $scope.itemsDueSoon = data
        )

      init()
  ])