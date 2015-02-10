angular
  .module('teamboard.controllers')
  .controller("BoardController", [ '$scope','$location','$resource','$routeParams','Board','SweetAlert',
    ($scope, $location, $resource, $routeParams, Board, SweetAlert)->
      getBoard = () ->
        Board.get($routeParams.board_id).then ((results) ->
          $scope.board = results
          return
        ), (error) ->
          return
      getBoard()
  ])