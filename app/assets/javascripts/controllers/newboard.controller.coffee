angular
  .module('teamboard.controllers')
  .controller("NewBoardController", [ '$scope', '$location', '$routeParams', 'BoardNested',
    ($scope, $location, $routeParams, BoardNested)->
      $scope.formData = {}

      $scope.createBoard = () ->
        new BoardNested({
            name: $scope.formData.name,
            description: $scope.formData.description
            projectId: $routeParams.project_id
        })
        .create()
        .then ((result) ->
          $location.path('/projects/' + $routeParams.project_id)
          window.humane.log("Created New Board " + $scope.formData.name)
          return
        ), (error) ->
          return
    ])