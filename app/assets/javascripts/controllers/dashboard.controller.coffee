angular
  .module('teamboard.controllers')
  .controller("DashboardController", [ '$scope', 'CurrentUser', 'Project'
    ($scope, CurrentUser, Project)->
      init = () ->
        $scope.currentUser = null
        $scope.projects = []
        $scope.comments = []

        CurrentUser.getUser().then (data) ->
          $scope.currentUser = data

        Project.query().then ((results) ->
          $scope.projects = results
          return
        ), (error) ->
          # do something about the error
          return

        # Comment.query({num: 10}).then ((data) ->
        #   $scope.comments = data
        # )

      init()
  ])