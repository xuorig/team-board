angular
  .module('teamboard.controllers')
  .controller("BoardController", [ '$scope','$timeout', '$location','$resource','$routeParams','Board','SweetAlert', '_',
    ($scope, $timeout, $location, $resource, $routeParams, Board, SweetAlert, _) ->

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
        firstItem = $scope.splitItems[0][0]
        nextPos = 1
        if firstItem
          nextPos = firstItem.position + 1

        $scope.splitItems[0].unshift({
            title: "Untitled Note",
            noteContent: "No Content",
            position: nextPos,
            uiColumn: 1
          })
        
        # Start edit of new note
        $timeout( () ->
          title = $("ul[ng-model]").first().children().first().find("h3")
          title.click()
          title.siblings().find("input").focus()
          title.siblings().find("input").select()
        )


        console.log($scope.splitItems)

      $scope.splitItems = []
      getBoard()
  ])