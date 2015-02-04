angular.module('teamboard.services').factory 'Membership', ['railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/memberships"
    name: 'membership'
]