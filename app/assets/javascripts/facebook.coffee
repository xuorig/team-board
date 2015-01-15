jQuery ->
  $('body').prepend('<div id="fb-root"></div>')

  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
    dataType: 'script'
    cache: true


window.fbAsyncInit = ->
  FB.init(appId: '427444494072446', cookie: true)

  $('#signIn').click (e) ->
    e.preventDefault()
    FB.login (response) ->
      window.location = '/auth/facebook/callback' if response.authResponse

  $('#signOut').click (e) ->
    FB.getLoginStatus (response) ->
      FB.logout() if response.authResponse
    true