# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "click", "#uggroup", (event) ->
  event.preventDefault()
  user_group_loging =$(this).closest('tr').find('#uglogin').val()
  if $(this).closest('tr').find('.form-check-input').prop("checked")
       user_group_group="4"
       $(this).prop("checked",true)
  else
      user_group_group="1"
      $(this).prop("checked",false)

  usergroup_url="/query/user_groups?login="+user_group_loging+"&amp;group="+user_group_group+"&;locale=zh_TW"
  xhttp = new XMLHttpRequest
  xhttp.onreadystatechange = ->
  xhttp.open "GET", usergroup_url, true
  # xhttp.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
  xhttp.send()


  location.reload();
  return false
