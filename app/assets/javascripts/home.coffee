$ ->
  $("#toggle-user-menu").on "click", ->
    console.log("YO");
    submenu = $("#user-menu .sidebar-submenu")
    if submenu.hasClass("active")
      submenu.removeClass("active")
    else
      submenu.addClass("active")