angular
  .module('teamboard.directives')
  .directive('ngRightClick', ['$parse','$document'
    ($parse, $document)->
      (scope, element, attrs)->
          fn = $parse(attrs.ngRightClick);
          element.bind 'contextmenu', (event)->
            scope.$apply(
              ()->
                event.preventDefault();
                fn(scope, {$event:event});
            )
          $document.bind 'click', (event) ->
            $(".context-menu").removeClass("open")

  ]);