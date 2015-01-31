angular
  .module('teamboard.controllers')
  .controller("TeamController", [ '$scope','$resource','$routeParams', 'Team',
    ($scope, $resource, $routeParams, Team)->
      Team.get($routeParams.team_id).then ((results) ->
        $scope.team = results
        console.log(results)
        return
      ), (error) ->
        return
  ])