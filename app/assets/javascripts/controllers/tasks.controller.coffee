angular
  .module('teamboard.controllers')
  .controller("TasksController", [ '$scope', 'CurrentUser', 'BoardItem'
    ($scope, CurrentUser, BoardItem)->
      init = () ->
        $scope.tasks = []
        getTasks()
      getTasks = () ->
        # TO DO: ONLY TASKS WHERE USER IS ASSIGNED
        BoardItem.query({due_soon: true}).then ((data) ->
          $scope.tasks = data
        )
      init()

  ])