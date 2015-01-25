teamboard = angular.module('teamboard',[
  'templates',
  'ngRoute',
  'controllers',
  'ngResource',
  'ngAnimate',
])

teamboard.config([ '$routeProvider', '$locationProvider',
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
      .when('/calendar', {
        templateUrl: "calendar.html",
        controller: "BoardController"
      })
      .when('/about', {
        templateUrl: "about.html",
        controller: "BoardController"
      })
])

controllers = angular.module('controllers',[])

controllers.controller("MenuController", [ '$scope','$location'
  ($scope, $location)->
    $scope.isCurrentPath = (path) ->
      $location.path() is path
])

controllers.controller("HomeController", [ '$scope',
  ($scope)->
])

controllers.controller("TeamsController", [ '$scope','$resource'
  ($scope, $resource)->
    teams = $resource('/api/teams/', {format: 'json' })
    $scope.teams = teams.query()
])

controllers.controller("BoardController", [ '$scope',
  ($scope)->
])