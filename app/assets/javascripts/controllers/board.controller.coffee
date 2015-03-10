angular
  .module('teamboard.controllers')
  .controller("BoardController", [ '$scope','$timeout', '$location','$resource','$routeParams','Board','BoardItem', 'SweetAlert', '_',
    ($scope, $timeout, $location, $resource, $routeParams, Board, BoardItem, SweetAlert, _) ->
      init = () ->
        $scope.sortableOptions = {
          'ui-floating': true,
          connectWith: ".item-column",
          cursor: "pointer"
        }
        $scope.splitItems = []
        getBoard()

      splitItemsInColumns = (items, numberOfColumns) ->
        splitItems = [[],[],[]] # 3 cols
        lists = _.groupBy(items, (element, index) ->
          return element.uiColumn
        )
        _.each lists, (list, key) ->
          splitItems[key] = _.sortBy(list, (item) -> return item.position).reverse()

        return splitItems

      getBoard = () ->
        Board.get($routeParams.board_id).then ((results) ->
          $scope.board = results
          $scope.splitItems = splitItemsInColumns($scope.board.items, 3)
          console.log($scope.splitItems)
          return
        ), (error) ->
          return

      $scope.onAddNote = () ->
        console.log($scope.splitItems)
        firstItem = $scope.splitItems[0][0]
        nextPos = 1
        if firstItem
          nextPos = firstItem.position + 1

        newItem = {
          title: "Untitled Note",
          noteContent: "No Content",
          position: nextPos,
          uiColumn: 0,
          boardId: $routeParams.board_id
        }

        new BoardItem(newItem).create()

        $scope.splitItems[0].unshift(newItem)
        
        # Start edit of new note
        $timeout( () ->
          title = $("ul[ng-model]").first().children().first().find("h3")
          title.click()
          title.siblings().find("input").focus()
          title.siblings().find("input").select()
        )

      init()
  ])