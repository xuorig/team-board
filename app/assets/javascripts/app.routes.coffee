angular.module('teamboard').config([ '$routeProvider', '$locationProvider',
  ($routeProvider, $locationProvider)->
    $routeProvider
      .when('/', {
        templateUrl: "index.html",
        controller: 'DashboardController'
      })
      # USER
      .when('/profile', {
        templateUrl: "userprofile.html",
        controller: "ProfileController" 
      })
      .when('/settings', {
        templateUrl: "settings.html",
        controller: "SettingsController" 
      })
      # BOARDS
      .when('/boards', {
        templateUrl: "boards.html",
        controller: "BoardsController" 
      })
      .when('/boards/:board_id', {
        templateUrl: "board.html",
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
      # TASKS
      .when('/tasks', {
        templateUrl: "tasks.html",
        controller: "TasksController"
      })
      # CALENDAR
      .when('/calendar', {
        templateUrl: "calendar.html",
        controller: "CalendarController"
      })
      # ABOUT
      .when('/about', {
        templateUrl: "about.html",
        controller: "AboutController"
      })
])