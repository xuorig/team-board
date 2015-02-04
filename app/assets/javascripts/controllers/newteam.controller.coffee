angular
  .module('teamboard.controllers')
  .controller("NewTeamController", [ '$scope', '$location', 'Team', 'User'
    ($scope, $location, Team, User)->
      $scope.formData = {}
      $scope.formData.members = []
      $scope.createTeam = () ->
        new Team({
            name: $scope.formData.name,
            description: $scope.formData.description
        })
        .create()
        .then ((result) ->
          console.log(result)
          $location.path('/teams')
          return
        ), (error) ->
          console.log(error)
          return
      $scope.appendMemberToList = () ->
        $scope.formData.members.push($scope.member)
        $scope.member = null
      $scope.userExists = (email) ->
        User
          .query({email: email})
          .then (
            (exists) ->
              console.log("exists")
              return
          ), (error) ->
            console.log(error)
            return


    ])