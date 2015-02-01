angular
  .module('teamboard.controllers')
  .controller("NewTeamController", [ '$scope', '$location', 'Team'
    ($scope, $location, Team)->
      $scope.formData = {}
      $scope.createTeam = () ->
        new Team({
            name: $scope.formData.name,
            description: $scope.formData.description
        })
        .create()
        .then ((result) ->
          console.log(result)
          $location.path('/teams');
          return
        ), (error) ->
          console.log(error)
          return
    ])