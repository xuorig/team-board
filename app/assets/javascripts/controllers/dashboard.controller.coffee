angular
  .module('teamboard.controllers')
  .controller("DashboardController", [ '$scope', 'CurrentUser', 'Project', 'Comment', 'BoardItem'
    ($scope, CurrentUser, Project, Comment, BoardItem)->
      init = () ->
        $scope.currentUser = null
        $scope.projects = []
        $scope.comments = []
        $scope.itemsDueSoon = []

        CurrentUser.getUser().then (data) ->
          $scope.currentUser = data

        Project.query().then ((results) ->
          $scope.projects = results
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