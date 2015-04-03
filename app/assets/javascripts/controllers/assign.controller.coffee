angular
  .module('teamboard.controllers')
  .controller("AssignMembersController", ['$scope', '$modalInstance', 'Assignment', 'info'
    ($scope, $modalInstance, Assignment, info) ->
      $scope.users = info.teamUsers

      # selected members
      $scope.selection = []

      # toggle selection for a given member
      $scope.toggleSelection = (userId) ->
        idx = $scope.selection.indexOf(userId)
        # is currently selected
        if idx > -1
          $scope.selection.splice idx, 1
        else
          $scope.selection.push userId
        return

      $scope.assign = ->
        new Assignment({
          board_item_id: info.itemId,
          user_ids: $scope.selection
        })
        .create()
        .then ((result) ->
          $modalInstance.dismiss 'cancel'
          return
        ), (error) ->
          console.log(error)
          return
  ])