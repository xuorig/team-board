angular
  .module('teamboard.controllers')
  .controller("ProjectController", [ '$scope','$location','$resource','$routeParams','Project','SweetAlert',
    ($scope, $location, $resource, $routeParams, Project, SweetAlert)->
      getProject = () ->
        Project.get($routeParams.project_id).then ((results) ->
          $scope.project = results
          return
        ), (error) ->
          return

      $scope.onDelete = () ->
        SweetAlert.swal {
          title: 'Watch out!'
          text: 'Deleting this project will also delete all boards attached to it. Are you sure ?'
          type: 'warning' 
          showCancelButton: true
          confirmButtonColor: '#DD6B55'
          confirmButtonText: 'Yes, delete it!'
        }, ->
          Project.get($routeParams.project_id).then ((project) ->
            project.delete()
            $location.path('/projects');
            window.humane.log("Deleted Project")
            return
          ), (error) ->
            console.log(error)
            return
          return

      getProject()
  ])