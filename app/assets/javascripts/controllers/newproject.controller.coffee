angular
  .module('teamboard.controllers')
  .controller("NewProjectController", [ '$scope', '$location', 'Project', 'Team', 'User', 'CurrentUser', '_'
    ($scope, $location, Project, Team, User, CurrentUser, _)->
      init = () ->
        $scope.formData = {}
        $scope.formData.team = null
        getTeams()

      getTeams = () ->
        currentUser = null
        CurrentUser.getUser().then (data) ->
          currentUser = data
        Team.query().then ((results) ->
          # Only show teams where user is manager or owner
          $scope.teams = _.filter(results, (team) ->
            if team.owner.id == currentUser.id
              return true
            if _.findWhere(team.managers, {id: currentUser.id})
              return true
          )
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