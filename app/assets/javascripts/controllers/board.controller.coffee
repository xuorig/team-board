angular
  .module('teamboard.controllers')
  .controller("BoardController", [ '$scope','$timeout', '$location','$resource','$routeParams','Board','BoardItemNested', 'BoardItem', 'SweetAlert', '_',
    ($scope, $timeout, $location, $resource, $routeParams, Board, BoardItemNested, BoardItem, SweetAlert, _) ->
      init = () ->
        $scope.sortableOptions = {
          'ui-floating': true,
          connectWith: ".item-column",
          cursor: "pointer",
          stop: (e, ui) ->
            destinationListIndex = $scope.splitItems.indexOf(ui.item.sortable.droptargetModel)
            destinationPosition = $scope.splitItems[destinationListIndex].indexOf(ui.item.sortable.model)
            $scope.updateItemPosition(ui.item.sortable.model, destinationListIndex, destinationPosition)
        }
        $scope.splitItems = []
        $scope.firstCol = []
        $scope.secondCol = []
        $scope.thirdCol = []
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
          $scope.firstCol = $scope.splitItems[0]
          $scope.secondCol = $scope.splitItems[1]
          $scope.thirdCol = $scope.splitItems[2]
          console.log($scope.splitItems)
          return
        ), (error) ->
          return

      $scope.updateItemPosition = (item, column, pos) ->
        BoardItem.get(item.id).then (boardItem) ->
          boardItem.position = pos + 1
          boardItem.uiColumn = column
          boardItem.update()
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

        new BoardItemNested(newItem).create()

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