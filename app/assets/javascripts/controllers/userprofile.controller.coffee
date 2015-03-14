angular
  .module('teamboard.controllers')
  .controller("ProfileController", [ '$scope', 'CurrentUser', 'Project'
    ($scope, CurrentUser, Project)->
      init = () ->
        $scope.currentUser = null
        $scope.projects = []

        CurrentUser.getUser().then (data) ->
          $scope.currentUser = data

        Project.query().then ((results) ->
          $scope.projects = results
          return
        ), (error) ->
          # do something about the error
          return

      init()
  ])