$(document).on "turbolinks:load", ->
 $(document).off "click","#colse_acc"
 $(document).on "click","#colse_acc" ,(event) ->
  event.preventDefault()
  if confirm "請確定是否要關帳"
   $(this).closest('tr').find('#edit_acc').hide()
   $(this).closest('tr').find("#delete_acc").hide()
   $(this).closest('tr').find("#colse_acc").hide()
   $(this).closest('tr').find("#colse_lable").show()
   #為了畫面效果塞關帳日期
   today = new Date
   dd =today.getDate()
   mm = today.getMonth() + 1
   yyyy = today.getFullYear()
   today = yyyy+'-'+mm+'-'+dd
   $(this).closest('tr').find("#clo_date").val(today)
   acc_id=$(this).closest('tr').find('#input').val()
   acc_close_url="/colse/accounts?id="+acc_id+"&;locale=zh_TW"
   xhttp = new XMLHttpRequest
   xhttp.onreadystatechange = ->
    if @readyState == 4 and @status == 200
      $(".show").html(@responseText)
   xhttp.open "GET", acc_close_url, true
   # xhttp.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
   xhttp.send()
   event.stopPropagation()
