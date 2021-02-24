$(document).on "turbolinks:load", ->
 $(document).off "click","#open_acc"
 $(document).on "click","#open_acc" ,(event) ->
  event.preventDefault()
  if confirm "請確定是否要解開帳"
   $(this).closest('tr').find('#edit_acc').show()
   $(this).closest('tr').find("#delete_acc").show()
   $(this).closest('tr').find("#close_acc").show()
   $(this).closest('tr').find("#close_lable").hide()
   #為了畫面效果塞關帳日期
   $(this).closest('tr').find("#clo_date").val("")
   acc_id=$(this).closest('tr').find('#input').val()
   acc_close_url="/open/accounts?id="+acc_id+"&;locale=zh_TW"
   xhttp = new XMLHttpRequest
   xhttp.onreadystatechange = ->
    if @readyState == 4 and @status == 200
      $(".show").html(@responseText)
   xhttp.open "GET", acc_close_url, true
   # xhttp.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
   xhttp.send()
   event.stopPropagation()
