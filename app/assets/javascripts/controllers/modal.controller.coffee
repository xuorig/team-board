angular
  .module('teamboard.controllers')
  .controller("ModalInstanceCtrl", ['$scope', '$modalInstance', 'name'
    ($scope, $modalInstance, name) ->
      $scope.name = name
      $scope.ok = ->
        $modalInstance.dismiss 'cancel'
        return

      $scope.cancel = ->
        $modalInstance.dismiss 'cancel'
        return
  ])