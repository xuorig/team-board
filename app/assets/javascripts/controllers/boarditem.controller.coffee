angular
  .module('teamboard.controllers')
  .controller("BoardItemController", [ '$scope', '$routeParams', '_', 'Team', 'BoardItem', 'CommentNested', 'Comment', 'SweetAlert', '$modal'
    ($scope, $routeParams, _, Team, BoardItem, CommentNested, Comment, SweetAlert, $modal)->
      init = () ->
        $scope.$watch 'item', ((newVal, oldVal) ->
          if !_.isEqual(oldVal, newVal)
            console.log 'update item !!!'
            updateItem(newVal)
        ), true

        $scope.$on('update-'+$scope.item.id, (event, args) ->
          fetchChanges($scope.item.id)
        )

        $scope.olderComments = []
        $scope.toShowComments = []
        $scope.commentOptions = {}
        getComments()

      $scope.onAssignMembers = () ->
        Team.get($scope.board.team.id).then ((team) ->
          modalInstance = $modal.open(
            templateUrl: 'firstloginmodal.html'
            controller: 'AssignMembersController'
            size: 'sm'
            resolve: info: ->
              {
                teamUsers: team.allUsers
                itemId: $scope.item.id
                assignees: $scope.item.assignees
              }
          )
          return
        ), (error) ->
          return


      getComments = () ->
        CommentNested.query({}, {boardItemId: $scope.item.id}).then ((results) ->
          $scope.toShowComments = results
          $scope.olderComments = $scope.toShowComments.splice(0, Math.max(results.length - 2, 0))
          return
        ), (error) ->
          # do something about the error
          return

      fetchChanges = (id) ->
        BoardItem.get(id).then (bi) ->
          $scope.item.title = bi.title
          $scope.item.noteContent = bi.noteContent
          $scope.item.color = bi.color
          $scope.item.dueDate = bi.dueDate
          getComments()
          return

      updateItem = (newVal) ->
        BoardItem.get(newVal.id).then (boardItem) ->
          boardItem.title = newVal.title
          boardItem.noteContent = newVal.noteContent
          boardItem.color = newVal.color
          boardItem.dueDate = newVal.dueDate
          boardItem.update()
          return

      $scope.deleteNote = () ->
        SweetAlert.swal {
          title: 'Careful!'
          text: 'Are you sure you want to delete this note?'
          type: 'warning'
          showCancelButton: true
          confirmButtonColor: '#DD6B55'
          confirmButtonText: 'Yes, delete it!'
        }, ->
          _deleteNote()
          return


      _deleteNote = () ->
        BoardItem.get($scope.item.id).then ((boardItem) ->
          boardItem.delete().then (res) ->
            window.humane.log("Deleted Note")
            #remove item from $scope
            _.each($scope.splitItems, (column, index) ->
              $scope.splitItems[index] = _.without(column, $scope.item)
            )
          ), (error) ->
              window.humane.log "Error Deleting Note"
              return
            return

      $scope.postComment = () ->
        new CommentNested({
          boardItemId: $scope.item.id,
          content: $scope.newComment
        })
        .create()
        .then ((note) ->
          getComments()
        )

        $scope.newComment = null

      $scope.calendar = {}

      $scope.changeNoteColor = (color) ->
        $scope.item.color = color

      $scope.calendar.today = ->
        $scope.item.dueDate = new Date
        return

      $scope.calendar.clear = ->
        $scope.item.dueDate = null
        return

      $scope.calendar.toggleMin = ->
        $scope.calendar.minDate = if $scope.calendar.minDate then null else new Date
        return
      $scope.calendar.toggleMin()

      $scope.calendar.open = ($event) ->
        $event.preventDefault()
        $event.stopPropagation()
        $scope.calendar.opened = true
        return

      $scope.calendar.dateOptions =
        formatYear: 'yy'
        startingDay: 1
      $scope.calendar.formats = [
        'dd-MMMM-yyyy'
        'yyyy/MM/dd'
        'dd.MM.yyyy'
        'shortDate'
      ]
      $scope.calendar.format = $scope.calendar.formats[0]

      init()
  ])