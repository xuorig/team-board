angular
  .module('teamboard.controllers')
  .controller("TeamController", [ '$scope','$location','$resource','$routeParams','CurrentUser','Membership','Managership','Team','SweetAlert',
    ($scope, $location, $resource, $routeParams, CurrentUser, Membership, Managership, Team, SweetAlert)->

      init = () ->
        $scope.addForms = {}
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
            team.delete()
            $location.path('/teams');
            window.humane.log("Deleted Team " + $scope.team.name)
            return
          ), (error) ->
            console.log(error)
            return
          return

      $scope.onAddUser = () ->
        if $scope.addForms.newUserForm.newUser.$error.email || !$scope.addForms.newUser
          return
        email = $scope.addForms.newUser
        if $scope.addForms.addAsManager then $scope.addManagerToTeam(email) else $scope.addUserToTeam(email)
        $scope.addForms.newUser = null

      $scope.addUserToTeam = (email) ->
        new Membership({
          team_id: $routeParams.team_id,
          email: email
        })
        .create()
        .then ((result) ->
          getTeam()
          return
        ), (error) ->
          console.log(error)
          return


      $scope.addManagerToTeam = (email) ->
        new Managership({
          team_id: $routeParams.team_id,
          email: email
        })
        .create()
        .then ((result) ->
          getTeam()
          return
        ), (error) ->
          console.log(error)
          return

      $scope.onRemoveUser = (user_id) ->
        Membership.query({
          team_id: $routeParams.team_id,
          user_id: user_id
        }).then ((ms) ->
          ms[0].delete().then ((result) ->
            getTeam()
          ), (error) ->
            console.log(error)
            return
        ), (error) ->
          console.log(error)
          return


      $scope.onRemoveManager = (user_id) ->
        Managership.query({
          team_id: $routeParams.team_id,
          manager_id: user_id
        }).then ((managerships) ->
          console.log managerships
          managerships[0].delete().then ((result) ->
            getTeam()
          ), (error) ->
            console.log(error)
            return
        ), (error) ->
          console.log(error)
          return

      $scope.demoteManager = (user_id, user_email) ->
        $scope.onRemoveManager user_id
        $scope.addUserToTeam user_email

      init()
  ])