angular
  .module('teamboard.controllers')
  .controller("TeamController", [ '$scope','$location','$resource','$routeParams','CurrentUser','Membership','Managership','Team','SweetAlert',
    ($scope, $location, $resource, $routeParams, CurrentUser, Membership, Managership, Team, SweetAlert)->

      init = () ->
        getTeam()
        CurrentUser.getUser().then (data) ->
          $scope.currentUser = data

      getTeam = () ->
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

      $scope.addUserToTeam = () ->
        if $scope.newUserForm.newUser.$error.email
          console.log 'sup'
          return
        new Membership({
          team_id: $routeParams.team_id,
          email: $scope.newUser
        })
        .create()
        .then ((result) ->
          getTeam()
          return
        ), (error) ->
          console.log(error)
          return


      $scope.addManagerToTeam = () ->
        if $scope.newManagerForm.newManager.$error.email
          console.log 'yo'
          return
        new Managership({
          team_id: $routeParams.team_id,
          email: $scope.newManager
        })
        .create()
        .then ((result) ->
          getTeam()
          return
        ), (error) ->
          console.log(error)
          return

      init()
  ])