angular
  .module('teamboard.controllers')
  .controller("TeamController", [ '$scope','$location','$resource','$routeParams', 'Team', 'Membership', 'SweetAlert',
    ($scope, $location, $resource, $routeParams, Team, Membership, SweetAlert)->
      Team.get($routeParams.team_id).then ((results) ->
        $scope.team = results
        return
      ), (error) ->
        return
      $scope.onDelete = () ->
        SweetAlert.swal {
          title: 'Watch out!'
          text: 'Deleting this team will also delete all projects attached to it. Are you sure ?'
          type: 'warning'
          showCancelButton: true
          confirmButtonColor: '#DD6B55'
          confirmButtonText: 'Yes, delete it!'
        }, ->
          Team.get($routeParams.team_id).then ((team) ->
            console.log(team)
            team.delete()
            $location.path('/teams');
            return
          ), (error) ->
            console.log(error)
            return
          return

      $scope.addUserToTeam = (email) ->
        new Membership({
          team_id: $routeParams.team_id,
          email: email
        })
        .create()
        .then ((result) ->
          console.log(result)
          # fetch and render
          return
        ), (error) ->
          console.log(error)
          return

      $scope.open = (size) ->
        modalInstance = $modal.open(
          templateUrl: 'myModalContent.html'
          controller: 'ModalInstanceCtrl'
          size: size
          resolve: items: ->
            $scope.items
        )
        modalInstance.result.then ((selectedItem) ->
          $scope.selected = selectedItem
          return
        ), ->
          $log.info 'Modal dismissed at: ' + new Date
          return
        return
  ])