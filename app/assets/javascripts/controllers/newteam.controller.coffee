angular
  .module('teamboard.controllers')
  .controller("NewTeamController", [ '$scope', '$location', 'Team','SweetAlert'
    ($scope, $location, Team, SweetAlert)->
      $scope.formData = {}
      $scope.createTeam = () ->
        SweetAlert.swal("Good job!", "You clicked the button!", "success");
        # new Team({
        #     name: $scope.formData.name,
        #     description: $scope.formData.description
        # })
        # .create()
        # .then ((result) ->
        #   console.log(result)
        #   $location.path('/teams');
        #   return
        # ), (error) ->
        #   console.log(error)
        #   return
    ])