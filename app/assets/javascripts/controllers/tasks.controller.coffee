angular
  .module('teamboard.controllers')
  .controller("TasksController", [ '$scope', 'CurrentUser', 'BoardItem'
    ($scope, CurrentUser, BoardItem)->
      init = () ->
        $scope.tasks = []
        getTasks()
      getTasks = () ->
        # TO DO: ONLY TASKS WHERE USER IS ASSIGNED
        BoardItem.query({has_due_date: true}).then ((items) ->
          $scope.tasks = items
        )
      init()

  ])