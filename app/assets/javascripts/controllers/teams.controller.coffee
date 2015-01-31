angular
  .module('teamboard.controllers')
  .controller("TeamsController", [ '$scope','$resource', 'Team',
    ($scope, $resource, Team)->
      Team.query().then ((results) ->
        $scope.teams = results
        return
      ), (error) ->
        # do something about the error
        return
  ])