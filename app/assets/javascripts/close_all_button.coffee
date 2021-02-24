$(document).on "turbolinks:load", ->
 $(document).off "click","#close_all"
 $(document).on "click","#close_all" ,(event) ->
  event.preventDefault()
  if confirm "請確定是否要一鍵關帳"
     acc_date= $("#date_yy").val()+$("#date_mm").val()
     paymonth= "paymonth"+$("#date_mm").val()
     clo_wonstaff= $("#close_wonstaff").val()
     #為了畫面效果塞關帳日期
     today = new Date
     dd =today.getDate()
     mm = today.getMonth() + 1
     yyyy = today.getFullYear()
     today = yyyy+'-'+mm+'-'+dd
     arr = id:[]
   if $('#bodyrow tr:eq(0) td:eq(17) button').attr("style")!="display:none;"
     $('#bodyrow tr:eq(0) td:eq(11) button').attr("style","display:none;")
     $('#bodyrow tr:eq(0) td:eq(16)').hide()
     $('#bodyrow tr:eq(0) td:eq(17)').hide()
     $('#bodyrow tr:eq(0) td:eq(12)').show()
     $('#bodyrow tr:eq(0) td:eq(10) input').val(today)
     arr.id.push($('#bodyrow tr:eq(0) td:eq(1) input').val())
   if $('#bodyrow tr:eq(1) td:eq(17) button').attr("style")!="display:none;"
     $('#bodyrow tr:eq(1) td:eq(17)').hide()
     $('#bodyrow tr:eq(1) td:eq(16)').hide()
     $('#bodyrow tr:eq(1) td:eq(11) button').attr("style","display:none;")
     $('#bodyrow tr:eq(1) td:eq(12)').show()
     $('#bodyrow tr:eq(1) td:eq(10) input').val(today)
     arr.id.push($('#bodyrow tr:eq(1) td:eq(1) input').val())
   if $('#bodyrow tr:eq(2) td:eq(17) button').attr("style")!="display:none;"
     $('#bodyrow tr:eq(2) td:eq(17)').hide()
     $('#bodyrow tr:eq(2) td:eq(16)').hide()
     $('#bodyrow tr:eq(2) td:eq(11) button').attr("style","display:none;")
     $('#bodyrow tr:eq(2) td:eq(12)').show()
     $('#bodyrow tr:eq(2) td:eq(10) input').val(today)
     arr.id.push($('#bodyrow tr:eq(2) td:eq(1) input').val())
   if $('#bodyrow tr:eq(3) td:eq(17) button').attr("style")!="display:none;"
     $('#bodyrow tr:eq(3) td:eq(17)').hide()
     $('#bodyrow tr:eq(3) td:eq(16)').hide()
     $('#bodyrow tr:eq(3) td:eq(11) button').attr("style","display:none;")
     $('#bodyrow tr:eq(3) td:eq(12)').show()
     $('#bodyrow tr:eq(3) td:eq(10) input').val(today)
     arr.id.push($('#bodyrow tr:eq(3) td:eq(1) input').val())
   if $('#bodyrow tr:eq(4) td:eq(17) button').attr("style")!="display:none;"
     $('#bodyrow tr:eq(4) td:eq(17)').hide()
     $('#bodyrow tr:eq(4) td:eq(16)').hide()
     $('#bodyrow tr:eq(4) td:eq(11) button').attr("style","display:none;")
     $('#bodyrow tr:eq(4) td:eq(12)').show()
     $('#bodyrow tr:eq(4) td:eq(10) input').val(today)
     arr.id.push($('#bodyrow tr:eq(4) td:eq(1) input').val())
   if $('#bodyrow tr:eq(5) td:eq(17) button').attr("style")!="display:none;"
     $('#bodyrow tr:eq(5) td:eq(17)').hide()
     $('#bodyrow tr:eq(5) td:eq(16)').hide()
     $('#bodyrow tr:eq(5) td:eq(11) button').attr("style","display:none;")
     $('#bodyrow tr:eq(5) td:eq(12)').show()
     $('#bodyrow tr:eq(5) td:eq(10) input').val(today)
     arr.id.push($('#bodyrow tr:eq(5) td:eq(1) input').val())
   if $('#bodyrow tr:eq(6) td:eq(17) button').attr("style")!="display:none;"
     $('#bodyrow tr:eq(6) td:eq(17)').hide()
     $('#bodyrow tr:eq(6) td:eq(16)').hide()
     $('#bodyrow tr:eq(6) td:eq(11) button').attr("style","display:none;")
     $('#bodyrow tr:eq(6) td:eq(12)').show()
     $('#bodyrow tr:eq(6) td:eq(10) input').val(today)
     arr.id.push($('#bodyrow tr:eq(6) td:eq(1) input').val())
   if $('#bodyrow tr:eq(7) td:eq(17) button').attr("style")!="display:none;"
     $('#bodyrow tr:eq(7) td:eq(17)').hide()
     $('#bodyrow tr:eq(7) td:eq(16)').hide()
     $('#bodyrow tr:eq(7) td:eq(11) button').attr("style","display:none;")
     $('#bodyrow tr:eq(7) td:eq(12)').show()
     $('#bodyrow tr:eq(7) td:eq(10) input').val(today)
     arr.id.push($('#bodyrow tr:eq(7) td:eq(1) input').val())
   if $('#bodyrow tr:eq(8) td:eq(17) button').attr("style")!="display:none;"
     $('#bodyrow tr:eq(8) td:eq(17)').hide()
     $('#bodyrow tr:eq(8) td:eq(16)').hide()
     $('#bodyrow tr:eq(8) td:eq(11) button').attr("style","display:none;")
     $('#bodyrow tr:eq(8) td:eq(12)').show()
     $('#bodyrow tr:eq(8) td:eq(10) input').val(today)
     arr.id.push($('#bodyrow tr:eq(8) td:eq(1) input').val())
   if $('#bodyrow tr:eq(9) td:eq(17) button').attr("style")!="display:none;"
     $('#bodyrow tr:eq(9) td:eq(17)').hide()
     $('#bodyrow tr:eq(9) td:eq(16)').hide()
     $('#bodyrow tr:eq(9) td:eq(11) button').attr("style","display:none;")
     $('#bodyrow tr:eq(9) td:eq(12)').show()
     $('#bodyrow tr:eq(9) td:eq(10) input').val(today)
     arr.id.push($('#bodyrow tr:eq(9) td:eq(1) input').val())
   acc_close_all_url="/closeall/accounts?id[]="+arr.id+"&;acc_date="+acc_date+"&;clo_wonstaff="+clo_wonstaff+"&;paymonth="+paymonth+"&;locale=zh_TW"
   xhttp = new XMLHttpRequest
   xhttp.onreadystatechange = ->
    if @readyState == 4 and @status == 200
      $(".show").html(@responseText)
   xhttp.open "GET", acc_close_all_url, true
   # xhttp.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
   xhttp.send()
   event.stopPropagation()
