angular.module('teamboard.services').factory 'CurrentUser', ['$q','User', ($q, User) ->
  # A place to hold the user so we only need fetch it once.
  user = undefined

  getUser = ->
    # If we've already cached it, return that one.
    # But return a promise version so it's consistent across invocations
    if angular.isDefined(user)
      return $q.when(user)
    # Otherwise, let's get it the first time and save it for later.
    User.get('me').then (data) ->
      user = data
      user

  # The public API
  { getUser: getUser }
]
