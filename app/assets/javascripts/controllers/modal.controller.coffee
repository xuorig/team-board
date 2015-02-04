# Please note that $modalInstance represents a modal window (instance) dependency.
# It is not the same as the $modal service used above.
angular.module('teamboard').controller 'ModalInstanceCtrl', ($scope, $modalInstance, items) ->
  $scope.items = items
  $scope.selected = item: $scope.items[0]

  $scope.ok = ->
    $modalInstance.close $scope.selected.item
    return

  $scope.cancel = ->
    $modalInstance.dismiss 'cancel'
    return

  return