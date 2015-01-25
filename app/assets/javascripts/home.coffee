$ ->
  $("#toggle-user-menu").on "click", ->
    submenu = $("#user-menu .sidebar-submenu")
    if submenu.hasClass("active")
      submenu.removeClass("active")
    else
      submenu.addClass("active")


  $("#toggle-ham-menu").on "click", ->
    body = $("body")
    if body.hasClass("ham-menu-active")
      body.removeClass("ham-menu-active")
    else
      body.addClass("ham-menu-active")

  $(".sidebar a").on "click", ->
    $("body").removeClass("ham-menu-active")