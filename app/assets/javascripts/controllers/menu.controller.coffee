angular
  .module('teamboard.controllers')
  .controller("MenuController", [ '$scope','$location', 'CurrentUser'
    ($scope, $location, CurrentUser)->
      $scope.isCurrentPath = (path) ->
        $location.path() is path

      $scope.newTeams = 0

      $scope.getNew = () ->      
        CurrentUser.getUser().then (currUser) ->
          $scope.newTeams = currUser.newTeams

      $scope.removeBadge = () ->
        $(".badge").remove()
        return true

      $scope.getNew()

  ])