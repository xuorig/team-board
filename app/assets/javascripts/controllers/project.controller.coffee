angular
  .module('teamboard.controllers')
  .controller("ProjectController", [ '$scope','$location','$resource','$routeParams','Project','SweetAlert',
    ($scope, $location, $resource, $routeParams, Project, SweetAlert)->
      getProject = () ->
        Project.get($routeParams.project_id).then ((results) ->
          console.log results
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
            return
          ), (error) ->
            console.log(error)
            return
          return

      $scope.addUserToProject = () ->
        # new Membership({
        #   team_id: $routeParams.team_id,
        #   email: $scope.newUser
        # })
        # .create()
        # .then ((result) ->
        #   getTeam()
        #   return
        # ), (error) ->
        #   console.log(error)
        #   return

      getProject()
  ])