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

$ ->
  $('body').prepend('<div id="fb-root"></div>')

  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
    dataType: 'script'
    cache: true


window.fbAsyncInit = ->
  FB.init(appId: '427444494072446', cookie: true)

  $('#sign_in_facebook').click (e) ->
    e.preventDefault()
    FB.login (response) ->
      window.location = '/users/auth/facebook/callback' if response.authResponse

  $('#sign_out').click (e) ->
    FB.getLoginStatus (response) ->
      FB.logout() if response.authResponse
    true