angular
  .module('teamboard.controllers')
  .controller("TeamController", [ '$scope','$location','$resource','$routeParams', 'Team', 'SweetAlert',
    ($scope, $location, $resource, $routeParams, Team, SweetAlert)->
      Team.get($routeParams.team_id).then ((results) ->
        $scope.team = results
        return
      ), (error) ->
        return
      $scope.onDelete = () ->
        SweetAlert.swal {
          title: 'Watch out!'
          text: 'Deleting this team will also delete all projects attached to it. Are you sure ?'
          type: 'warning'
          showCancelButton: true
          confirmButtonColor: '#DD6B55'
          confirmButtonText: 'Yes, delete it!'
        }, ->
          Team.get($routeParams.team_id).then ((team) ->
            console.log(team)
            team.delete()
            $location.path('/teams');
            return
          ), (error) ->
            console.log(error)
            return
          return
  ])