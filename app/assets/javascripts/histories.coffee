# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "click", "#query_history", (event) ->
  event.preventDefault()
  cust_id = $("#hiscustID").val()
  acc_date= $("#date_yy").val()+$("#date_mm").val()
  mark = $("#input1").val()
  user_id= $("#input2").val()
  star_date = $("#hisdateS").val()
  end_date = $("#hisdateE").val()


  his_url="/query/histories?cust_id="+cust_id+"&;acc_date="+acc_date+
  "&;user_id="+user_id+"&;mark="+mark+"&;star_date="+star_date+"&;end_date="+end_date+"&;locale=zh_TW"

  xhttp = new XMLHttpRequest
  xhttp.onreadystatechange = ->
   if @readyState == 4 and @status == 200
     $(".show").html(@responseText)
  xhttp.open "GET", his_url, true
  # xhttp.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
  xhttp.send()
  return false
$(document).on "keyup", "#hiscustID", (event) ->
  event.preventDefault()
  hiscustID = $('#hiscustID').val()
  if !hiscustID.match("^[A-Za-z0-9]+$")
    msg = '格式錯誤,請輸入英數字'
    $('#input0tips').html msg
    $('#hiscustID').val('')
  else
    $('#input0tips').html ''
  if hiscustID==""
    msg = ''
    $('#input0tips').html ''
  return
$(document).on "keyup", "#hisdateS", (event) ->
  event.preventDefault()
  hisdateS = $('#hisdateS').val()
  if !hisdateS.match("^[0-9]*$")
    msg = '格式錯誤,請輸入英數字'
    $('#input0tips').html msg
    $('#hisdateS').val('')
  else
    $('#input0tips').html ''
  if input0==""
    msg = ''
    $('#input0tips').html ''
  return
$(document).on "keyup", "#hisdateE", (event) ->
  event.preventDefault()
  hisdateE = $('#hisdateE').val()
  if !hisdateE.match("^[0-9]*$")
    msg = '格式錯誤,請輸入英數字'
    $('#input0tips').html msg
    $('#hisdateE').val('')
  else
    $('#input0tips').html ''
  if input0==""
    msg = ''
    $('#input0tips').html ''
  return
