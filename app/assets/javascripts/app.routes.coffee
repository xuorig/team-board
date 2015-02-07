angular.module('teamboard').config([ '$routeProvider', '$locationProvider',
  ($routeProvider, $locationProvider)->
    $routeProvider
      .when('/', {
        templateUrl: "index.html",
        controller: 'HomeController'
      })
      # BOARDS
      .when('/boards', {
        templateUrl: "boards.html",
        controller: "BoardController" 
      })
      # PROJECTS
      .when('/projects', {
        templateUrl: "projects.html",
        controller: "ProjectsController"
      })
      .when('/projects/new', {
        templateUrl: "newproject.html",
        controller: "NewProjectController"
      })
      .when('/projects/:project_id', {
        templateUrl: "project.html",
        controller: "ProjectController"
      })
      # TEAMS
      .when('/teams', {
        templateUrl: "teams.html",
        controller: "TeamsController"
      })
      .when('/teams/new', {
        templateUrl: "newteam.html",
        controller: "NewTeamController"
      })
      .when('/teams/:team_id', {
        templateUrl: "team.html",
        controller: "TeamController"
      })
      .when('/calendar', {
        templateUrl: "calendar.html",
        controller: "BoardController"
      })
      .when('/about', {
        templateUrl: "about.html",
        controller: "BoardController"
      })
])