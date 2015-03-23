angular.module('teamboard.services').factory 'File', ['railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/files"
    name: 'file'
]