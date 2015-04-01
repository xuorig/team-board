angular
  .module('teamboard.controllers')
  .controller("FilesController", [ '$scope','$resource','File',
    ($scope, $resource, File)->
      File.query().then ((results) ->
        $scope.files = results
        console.log results
        return
      ), (error) ->
        # do something about the error
        return
  ])