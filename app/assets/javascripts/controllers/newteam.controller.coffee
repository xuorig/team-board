angular
  .module('teamboard.controllers')
  .controller("NewTeamController", [ '$scope', '$location', 'Team', 'User', '_'
    ($scope, $location, Team, User)->
      $scope.formData = {}
      $scope.formData.members = []

      $scope.createTeam = () ->
        emails = []
        emails.push(e.email) for e, r in $scope.formData.members
        new Team({
            name: $scope.formData.name,
            description: $scope.formData.description
            users: emails
        })
        .create()
        .then ((result) ->
          console.log(result)
          $location.path('/teams')
          window.humane.log("Created Team " + $scope.formData.name)
          return
        ), (error) ->
          console.log(error)
          return

      # check if the user exists, TODO: Send invitation email if it doesnt.
      $scope.userExists = (email) ->
        User
          .query({email: email})
          .then (
            (exists) ->
              return true
          ), (error) ->
            return false

      $scope.appendMemberToList = () ->
        $scope.userExists($scope.member).then (
          (res) ->
            $scope.formData.members.push({
              email: $scope.member,
              registered: res
            }) 
            $scope.member = null
        )

      $scope.removeMemberFromList = (email) ->
        console.log("YO");
        $scope.formData.members = _.without($scope.formData.members, _.findWhere($scope.formData.members, email: email))

    ])