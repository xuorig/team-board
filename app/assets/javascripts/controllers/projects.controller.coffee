angular
  .module('teamboard.controllers')
  .controller("TeamsController", [ '$scope','$resource', 'Project',
    ($scope, $resource, Project)->
      Project.query().then ((results) ->
        $scope.teams = results
        return
      ), (error) ->
        # do something about the error
        return
  ])