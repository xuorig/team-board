angular.module('teamboard').config([ '$routeProvider', '$locationProvider',
  ($routeProvider, $locationProvider)->
    $routeProvider
      .when('/', {
        templateUrl: "index.html",
        controller: 'HomeController'
      })
      .when('/boards', {
        templateUrl: "boards.html",
        controller: "BoardController" 
      })
      .when('/projects', {
        templateUrl: "projects.html",
        controller: "BoardController"
      })
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