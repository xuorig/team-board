angular
  .module('teamboard.controllers')
  .controller("BoardController", [ '$scope','$location','$resource','$routeParams','Board','SweetAlert', '_',
    ($scope, $location, $resource, $routeParams, Board, SweetAlert, _) ->

      $scope.sortableOptions = {
        'ui-floating': true,
        connectWith: ".item-column",
        cursor: "pointer"
      }

      splitItemsInColumns = (items, numberOfColumns) ->
        lists = _.groupBy(items, (element, index) ->
          return element.uiColumn
        )
        _.each lists, (list, key) ->
          lists[key] = _.sortBy(list, (item) -> return item.position).reverse()

        return _.toArray(lists)

      getBoard = () ->
        Board.get($routeParams.board_id).then ((results) ->
          $scope.board = results
          $scope.splitItems = splitItemsInColumns($scope.board.items, 3)
          console.log($scope.splitItems)
          return
        ), (error) ->
          return

      $scope.onAddNote = () ->
        $scope.splitItems[0].unshift({
            title: "Untitled Note",
            noteContent: "No Content",
            position: $scope.splitItems[0][0].position + 1,
            uiColumn: 1
          })
        console.log($scope.splitItems)

      $scope.splitItems = []
      getBoard()
  ])