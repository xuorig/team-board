angular
  .module('teamboard.controllers')
  .controller("NewProjectController", [ '$scope', '$location', 'Project', 'Team', 'User', '_'
    ($scope, $location, Project, Team, User)->
      init = () ->
        $scope.formData = {}
        $scope.formData.team = null
        getTeams()

      getTeams = () ->  
        Team.query().then ((results) ->
          $scope.teams = results
          console.log $scope.teams
          return
        ), (error) ->
          # do something about the error
          return

      $scope.createProject = () ->
        new Project({
            name: $scope.formData.name,
            description: $scope.formData.description
            team_id: $scope.formData.team.id 
        })
        .create()
        .then ((result) ->
          console.log(result)
          $location.path('/projects')
          return
        ), (error) ->
          console.log(error)
          return

      $scope.assignToTeam = () ->
        $scope.formData.team = {
          id: $scope.assignedTeam.id,
          name: $scope.assignedTeam.name
        }

      $scope.deassignTeam = () ->
        $scope.formData.team = null

      init()

    ])