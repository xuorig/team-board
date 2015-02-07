angular
  .module('teamboard.controllers')
  .controller("ProjectsController", [ '$scope','$resource','Project',
    ($scope, $resource, Project)->
      Project.query().then ((results) ->
        $scope.projects = results
        return
      ), (error) ->
        # do something about the error
        return
  ])