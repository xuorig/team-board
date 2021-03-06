angular
  .module('teamboard.controllers')
  .controller("BoardController", [ '$scope','$timeout', '$location','$resource','$routeParams','Board',
    'BoardItemNested', 'BoardItem', 'SweetAlert', '_', 'CurrentUser'
    ($scope, $timeout, $location, $resource, $routeParams, Board, BoardItemNested, BoardItem, SweetAlert, _, CurrentUser) ->
      $scope.currentUser = null
      init = () ->
        # UI SORTABLE OPTIONS
        $scope.sortableOptions = {
          'ui-floating': true,
          placeholder: 'note-placeholder',
          connectWith: ".item-column",
          cursor: "pointer",
          stop: (e, ui) ->
            if $scope.isReadOnly
              return
            destinationListIndex = $scope.splitItems.indexOf(ui.item.sortable.droptargetModel)
            destinationIndex = $scope.splitItems[destinationListIndex].indexOf(ui.item.sortable.model)
            numOfitems = $scope.splitItems[destinationListIndex].length
            newPosition = numOfitems - destinationIndex
            $scope.updateItemPosition(ui.item.sortable.model, destinationListIndex, newPosition)
          update: (e, ui) ->
            if $scope.isReadOnly
              ui.item.sortable.cancel()
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
          CurrentUser.getUser().then (data) ->
            $scope.currentUser = data
            $scope.isReadOnly = isReadOnly(data, results)
            if not $scope.isReadOnly
              setUpSSE()
            return
        ), (error) ->
          return

      isReadOnly = (user, board) ->
        board.readonly && board.team.owner.id != user.id

      setUpSSE = () ->
        # SERVER SENT EVENTS
        $timeout( () ->
          source = new EventSource('/api/boards/' + $routeParams.board_id + '/events')

          $scope.$on '$destroy', () ->
            source.close()

          source.addEventListener 'changed', (e) ->
            data = JSON.parse(e.data).change
            user = JSON.parse(e.data).user
            if data.hb or user == $scope.currentUser.id
              # DO NOTHING
            else if data.board_item
              $scope.$broadcast('update-'+data.board_item)
            else if data.position_changed or data.new_item
              getBoard()
        )
        # TO DO: POLLING FOR BROWSERS THAT DONT SUPPORT EVENTSOURCE

      $scope.updateItemPosition = (item, column, pos) ->
        BoardItem.get(item.id).then (boardItem) ->
          boardItem.position = pos
          boardItem.uiColumn = column
          boardItem.update()
          return

      $scope.onAddNote = () ->
        firstItem = $scope.splitItems[0][0]
        nextPos = 1
        if firstItem
          nextPos = firstItem.position + 1

        newItem = {
          title: "Untitled Note",
          noteContent: "No Content",
          position: nextPos,
          uiColumn: 0,
          boardId: $routeParams.board_id,
          assignees: []
        }

        new BoardItemNested(newItem).create().then ((createdItem) ->
          $scope.splitItems[0].unshift(createdItem)
          # Start edit of new note
          $timeout( () ->
            title = $("ul[ng-model]").first().children().first().find("h3")
            title.click()
            title.siblings().find("input").focus()
            title.siblings().find("input").select()
          )

        ), (error) ->
          return

      init()
  ])
