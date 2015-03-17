angular
  .module('teamboard.controllers')
  .controller("CalendarController", [ '$scope', 'CurrentUser', 'BoardItem'
    ($scope, CurrentUser, BoardItem)->
      init = () ->
        $scope.uiConfig = calendar:
          height: 450
          editable: true
          header:
            left: 'month basicWeek basicDay agendaWeek agendaDay'
            center: 'title'
            right: 'today prev,next'
          dayClick: $scope.alertEventOnClick
          eventDrop: $scope.alertOnDrop
          eventResize: $scope.alertOnResize

        CurrentUser.getUser().then (currUser) ->
          $scope.currentUser = currUser
          getEventSources()

        $scope.eventSources = []
        console.log $scope.events

      getEventSources = () ->
        BoardItem.query({has_due_date: true}).then ((items) ->
          $scope.eventSources.push ({title: item.title, start: item.dueDate, className: item.color} for item in items)
          console.log $scope.eventSources
        )


      init()
  ])