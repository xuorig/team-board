angular
  .module('teamboard.controllers')
  .controller("MenuController", [ '$scope','$location'
    ($scope, $location)->
      $scope.isCurrentPath = (path) ->
        $location.path() is path
  ])