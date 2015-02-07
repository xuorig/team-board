angular
  .module('teamboard')
  .directive 'uniqueUser', () ->
    {
      restrict: 'A'
      require: 'ngModel'
      link: (scope, element, attrs, ngModel) ->

        validate = (value) ->
          if scope.usernames and scope.usernames.indexOf(ngModel.$viewValue) == -1
            ngModel.$setValidity 'unique', true
          else
            ngModel.$setValidity 'unique', false
          return

        $http.get('usernames.json').success (usernames) ->
          scope.usernames = usernames
          validate ngModel.$viewValue
          return
        scope.$watch (->
          ngModel.$viewValue
        ), validate
        return

    }