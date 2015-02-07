# Please note that $modalInstance represents a modal window (instance) dependency.
# It is not the same as the $modal service used above.
angular.module('teamboard').controller 'ModalInstanceCtrl', ($scope, $modalInstance, members) ->
  $scope.members = members
  $scope.selected = item: $scope.members[0]

  $scope.ok = ->
    $modalInstance.close $scope.selected.member
    return

  $scope.cancel = ->
    $modalInstance.dismiss 'cancel'
    return

  return