# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "keyup", "#close_day_input", (event) ->
  event.preventDefault()
  close_day_input = $('#close_day_input').val()
  if !close_day_input.match("^((0?[1-9])|((1|2)[0-8]|19))$")
    $('#close_day_input').val('')
  else
    $('#close_day_inputtips').html ''
  if close_day_input==""
    $('#close_day_inputtips').html ''
  return　

$(document).on "click", "#closement_yes", (event) ->
  event.preventDefault()
  close_day_input =$(this).closest('tr').find('#close_day_input').val()
  old_close_day =$('#old_close_day').val()
  x="0"
  if !close_day_input
    alert "不得為空值"
    x = "1"
    $(this).closest('tr').find('#close_day_input').val(old_close_day)
  if x!="1"
    alert("更新成功")
  closement_url="/query/closements?close_day="+close_day_input+"&;locale=zh_TW"
  xhttp = new XMLHttpRequest
  xhttp.onreadystatechange = ->
  xhttp.open "GET", closement_url, true
  # xhttp.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
  xhttp.send()
  # location.reload();
  return false
