# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "click", "#query_history", (event) ->
  event.preventDefault()
  cust_id = $("#input0").val()
  acc_date= $("#date_yy").val()+$("#date_mm").val()
  mark = $("#input1").val()
  user_id= $("#input2").val()
  star_date = $("#input3").val()
  end_date = $("#input4").val()
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
