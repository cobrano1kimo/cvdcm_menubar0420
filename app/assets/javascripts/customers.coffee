# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# $.ajaxSetup headers: 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')


$(document).on "turbolinks:load", ->

# 觸發 '查詢' 按鈕

$(document).on "click", "#query_cust", (event) ->
  event.preventDefault()
  cust_id = $("#inputquery").val()
  cust_url="/query/customers?cust_id="+cust_id+"&;locale=zh_TW"

  xhttp = new XMLHttpRequest
  xhttp.onreadystatechange = ->
   if @readyState == 4 and @status == 200
     $(".show").html(@responseText)
  xhttp.open "GET", cust_url, true
  # xhttp.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
  xhttp.send()
  return false



# 觸發 '新增' 或 '修改' 的確認按鈕
$(document).on "click", "#create_cust", (event) ->
  event.preventDefault()
  cust_new_url="/new/customers"
  xhttp = new XMLHttpRequest
  xhttp.onreadystatechange = ->
   if @readyState == 4 and @status == 200
     $(".show").html(@responseText)
  xhttp.open "GET", cust_new_url, true
  # xhttp.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
  xhttp.send()
  return false

$(document).on "click", "#cust_checkC", (event) ->
  event.preventDefault()
  cust_id=$(this).closest('tr').find('#input0').val()
  cust_name=$(this).closest('tr').find('#input1').val()
  cust_stat=$(this).closest('tr').find('#input2').val()
  won_staff=$(this).closest('tr').find('#input3').val()
  cust_note=$(this).closest('tr').find('#input4').val()
  #cust_payment=$(this).closest('tr').find('#payselect').val()

　　#畫面控制邊框
  #$(this).closest('tr').find('#input1').attr("onfocus","this.blur()").removeClass("border-4").addClass("border-0")
  #$(this).closest('tr').find("#input3").removeClass("border-4").addClass("border-0").attr("onfocus","this.blur()")
  #$(this).closest('tr').find("#input6").removeClass("border-4").addClass("border-0").attr("onfocus","this.blur()")
  #$(this).closest('tr').find("#input7").removeClass("border-4").addClass("border-0").attr("onfocus","this.blur()")
  #$(this).closest('tr').find("#input0").removeClass("border-4").addClass("border-0").attr("onfocus","this.blur()")
　　#按鈕控制 顥示
  #$('table td:nth-child(11)').show()
  #$('table td:nth-child(15)').show()
  #$('table td:nth-child(12)').show()
  #$td = $(this).parents("tr").children("td")
  #index=($td.eq(0).text())
  #$(this).closest('tr').find("#yesOrNoC").hide()
  #開啓REUQEST指向ACTION
  $(this).closest('a').removeAttr("href")
  cust_create_url="/create/customers?cust_id="+cust_id+"&;cust_name="+cust_name+"&;cust_stat="+cust_stat+"&;won_staff="+won_staff+"&;cust_note="+cust_note+"&;locale=zh_TW"

  xhttp = new XMLHttpRequest
  xhttp.onreadystatechange = ->
   if @readyState == 4 and @status == 200
     $(".show").html(@responseText)
  xhttp.open "GET", cust_create_url, true
  # xhttp.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
  xhttp.send()
  return false

# 觸發 '刪除' 按鈕
$(document).on "click", "#delete_cust", (event) ->
  event.preventDefault()
  if confirm('確定刪除該資料嗎')==true
    $(this).closest('tr').fadeOut()


                         # 觸發 a link 的 click (rails link_to)
  return false

$(document).on "keyup", "#payday_input", (event) ->
  event.preventDefault()
  payday_input = $('#payday_input').val()

  if !payday_input.match("^((0?[1-9])|((1|2)[0-9])|30|31)$")
    msg = '格式錯誤,請輸入數字'

    $('#payday_input').val('')
  else
  return　
# 觸發 '修改' 按鈕
$(document).on "click", "#edit_cust", (event) ->
  #event.stopPropagation()
  event.preventDefault()

  $(this).closest('tr').find('#input1').removeAttr("onfocus").removeClass("border-0").addClass("round1")
  $(this).closest('tr').find("#input4").removeAttr("onfocus").removeClass("border-0").addClass("round1​")
  $(this).closest('tr').find('#payday_input').removeAttr("onfocus").removeClass("border-0").addClass("round1")
  $('table td:nth-child(22)').hide()
  $('table td:nth-child(24)').hide()
  $(this).closest('tr').find("#yesOrNoE").show()
  $(this).closest('tr').find("#op1").show()
  $(this).closest('tr').find("#op2").show()
  $(this).closest('tr').find("#op3").show()
  $(this).closest('tr').find("#op0").hide()
  $(this).closest('tr').find("#ps1").show()
  $(this).closest('tr').find("#ps2").show()
  $(this).closest('tr').find("#ps3").show()
  $(this).closest('tr').find("#ps4").show()
  $(this).closest('tr').find("#ps5").show()
  $(this).closest('tr').find("#ps6").show()
  $(this).closest('tr').find("#ps7").show()
  $(this).closest('tr').find("#ps8").show()
  $(this).closest('tr').find("#ps0").hide()
  $(this).closest('tr').find("#ps0").hide()
  $(this).closest('tr').find("#pm1").removeAttr("disabled")
  $(this).closest('tr').find("#pm2").removeAttr("disabled")
  $(this).closest('tr').find("#pm3").removeAttr("disabled")
  $(this).closest('tr').find("#pm4").removeAttr("disabled")
  $(this).closest('tr').find("#pm5").removeAttr("disabled")
  $(this).closest('tr').find("#pm6").removeAttr("disabled")
  $(this).closest('tr').find("#pm7").removeAttr("disabled")
  $(this).closest('tr').find("#pm8").removeAttr("disabled")
  $(this).closest('tr').find("#pm9").removeAttr("disabled")
  $(this).closest('tr').find("#pm10").removeAttr("disabled")
  $(this).closest('tr').find("#pm11").removeAttr("disabled")
  $(this).closest('tr').find("#pm12").removeAttr("disabled")
  #select_chengeto_checkbox
  $(this).closest('tr').find("#payselect").change  ->
    switch $(this).closest('tr').find("#payselect").val()
    #月結
       when "1" then $(this).closest('tr').find('#pm1').prop("checked",true) and
                     $(this).closest('tr').find('#pm2').prop("checked",true) and
                     $(this).closest('tr').find('#pm3').prop("checked",true) and
                     $(this).closest('tr').find('#pm4').prop("checked",true) and
                     $(this).closest('tr').find('#pm5').prop("checked",true) and
                     $(this).closest('tr').find('#pm6').prop("checked",true) and
                     $(this).closest('tr').find('#pm7').prop("checked",true) and
                     $(this).closest('tr').find('#pm8').prop("checked",true) and
                     $(this).closest('tr').find('#pm9').prop("checked",true) and
                     $(this).closest('tr').find('#pm10').prop("checked",true) and
                     $(this).closest('tr').find('#pm11').prop("checked",true) and
                     $(this).closest('tr').find('#pm12').prop("checked",true)
    #半月結
       when "2" then $(this).closest('tr').find('#pm1').prop("checked",true) and
                     $(this).closest('tr').find('#pm2').prop("checked",true) and
                     $(this).closest('tr').find('#pm3').prop("checked",true) and
                     $(this).closest('tr').find('#pm4').prop("checked",true) and
                     $(this).closest('tr').find('#pm5').prop("checked",true) and
                     $(this).closest('tr').find('#pm6').prop("checked",true) and
                     $(this).closest('tr').find('#pm7').prop("checked",true) and
                     $(this).closest('tr').find('#pm8').prop("checked",true) and
                     $(this).closest('tr').find('#pm9').prop("checked",true) and
                     $(this).closest('tr').find('#pm10').prop("checked",true) and
                     $(this).closest('tr').find('#pm11').prop("checked",true) and
                     $(this).closest('tr').find('#pm12').prop("checked",true)
　　　#季結
       when "3" then $(this).closest('tr').find('#pm1').prop("checked",false) and
                     $(this).closest('tr').find('#pm2').prop("checked",false) and
                     $(this).closest('tr').find('#pm3').prop("checked",true) and
                     $(this).closest('tr').find('#pm4').prop("checked",false) and
                     $(this).closest('tr').find('#pm5').prop("checked",false) and
                     $(this).closest('tr').find('#pm6').prop("checked",true) and
                     $(this).closest('tr').find('#pm7').prop("checked",false) and
                     $(this).closest('tr').find('#pm8').prop("checked",false) and
                     $(this).closest('tr').find('#pm9').prop("checked",true) and
                     $(this).closest('tr').find('#pm10').prop("checked",false) and
                     $(this).closest('tr').find('#pm11').prop("checked",false) and
                     $(this).closest('tr').find('#pm12').prop("checked",true)
    #半年結
       when "4" then $(this).closest('tr').find('#pm1').prop("checked",false) and
                     $(this).closest('tr').find('#pm2').prop("checked",false) and
                     $(this).closest('tr').find('#pm3').prop("checked",false) and
                     $(this).closest('tr').find('#pm4').prop("checked",false) and
                     $(this).closest('tr').find('#pm5').prop("checked",false) and
                     $(this).closest('tr').find('#pm6').prop("checked",true) and
                     $(this).closest('tr').find('#pm7').prop("checked",false) and
                     $(this).closest('tr').find('#pm8').prop("checked",false) and
                     $(this).closest('tr').find('#pm9').prop("checked",false) and
                     $(this).closest('tr').find('#pm10').prop("checked",false) and
                     $(this).closest('tr').find('#pm11').prop("checked",false) and
                     $(this).closest('tr').find('#pm12').prop("checked",true)
    #年結
       when "5" then $(this).closest('tr').find('#pm1').prop("checked",false) and
                     $(this).closest('tr').find('#pm2').prop("checked",false) and
                     $(this).closest('tr').find('#pm3').prop("checked",false) and
                     $(this).closest('tr').find('#pm4').prop("checked",false) and
                     $(this).closest('tr').find('#pm5').prop("checked",false) and
                     $(this).closest('tr').find('#pm6').prop("checked",false) and
                     $(this).closest('tr').find('#pm7').prop("checked",false) and
                     $(this).closest('tr').find('#pm8').prop("checked",false) and
                     $(this).closest('tr').find('#pm9').prop("checked",false) and
                     $(this).closest('tr').find('#pm10').prop("checked",false) and
                     $(this).closest('tr').find('#pm11').prop("checked",false) and
                     $(this).closest('tr').find('#pm12').prop("checked",true)
　　　#結清
       when "6" then $(this).closest('tr').find('#pm1').prop("checked",false) and
                     $(this).closest('tr').find('#pm2').prop("checked",false) and
                     $(this).closest('tr').find('#pm3').prop("checked",false) and
                     $(this).closest('tr').find('#pm4').prop("checked",false) and
                     $(this).closest('tr').find('#pm5').prop("checked",false) and
                     $(this).closest('tr').find('#pm6').prop("checked",false) and
                     $(this).closest('tr').find('#pm7').prop("checked",false) and
                     $(this).closest('tr').find('#pm8').prop("checked",false) and
                     $(this).closest('tr').find('#pm9').prop("checked",false) and
                     $(this).closest('tr').find('#pm10').prop("checked",false) and
                     $(this).closest('tr').find('#pm11').prop("checked",false) and
                     $(this).closest('tr').find('#pm12').prop("checked",false)

       when "7" then $(this).closest('tr').find('#pm1').prop("checked",false) and
                     $(this).closest('tr').find('#pm2').prop("checked",false) and
                     $(this).closest('tr').find('#pm3').prop("checked",false) and
                     $(this).closest('tr').find('#pm4').prop("checked",false) and
                     $(this).closest('tr').find('#pm5').prop("checked",false) and
                     $(this).closest('tr').find('#pm6').prop("checked",false) and
                     $(this).closest('tr').find('#pm7').prop("checked",false) and
                     $(this).closest('tr').find('#pm8').prop("checked",false) and
                     $(this).closest('tr').find('#pm9').prop("checked",false) and
                     $(this).closest('tr').find('#pm10').prop("checked",false) and
                     $(this).closest('tr').find('#pm11').prop("checked",false) and
                     $(this).closest('tr').find('#pm12').prop("checked",false)
    　#４個月結
       when "8" then $(this).closest('tr').find('#pm1').prop("checked",false) and
                     $(this).closest('tr').find('#pm2').prop("checked",false) and
                     $(this).closest('tr').find('#pm3').prop("checked",false) and
                     $(this).closest('tr').find('#pm4').prop("checked",true) and
                     $(this).closest('tr').find('#pm5').prop("checked",false) and
                     $(this).closest('tr').find('#pm6').prop("checked",false) and
                     $(this).closest('tr').find('#pm7').prop("checked",false) and
                     $(this).closest('tr').find('#pm8').prop("checked",true) and
                     $(this).closest('tr').find('#pm9').prop("checked",false) and
                     $(this).closest('tr').find('#pm10').prop("checked",false) and
                     $(this).closest('tr').find('#pm11').prop("checked",false) and
                     $(this).closest('tr').find('#pm12').prop("checked",true)


# 觸發 '修改確定' 按鈕

$(document).on "click", "#cust_checkE", (event) ->
  event.preventDefault()
  if $(this).closest('tr').find('#pm1').prop("checked")
     paymonth01="1"
  else
    paymonth01="0"
  if $(this).closest('tr').find('#pm2').prop("checked")
    paymonth02="1"
  else
    paymonth02="0"
  if $(this).closest('tr').find('#pm3').prop("checked")
    paymonth03="1"
  else
    paymonth03="0"
  if $(this).closest('tr').find('#pm4').prop("checked")
    paymonth04="1"
  else
    paymonth04="0"
  if $(this).closest('tr').find('#pm5').prop("checked")
    paymonth05="1"
  else
    paymonth05="0"
  if $(this).closest('tr').find('#pm6').prop("checked")
    paymonth06="1"
  else
    paymonth06="0"
  if $(this).closest('tr').find('#pm7').prop("checked")
    paymonth07="1"
  else
    paymonth07="0"
  if $(this).closest('tr').find('#pm8').prop("checked")
    paymonth08="1"
  else
    paymonth08="0"
  if $(this).closest('tr').find('#pm9').prop("checked")
    paymonth09="1"
  else
    paymonth09="0"
  if $(this).closest('tr').find('#pm10').prop("checked")
    paymonth10="1"
  else
    paymonth10="0"
  if $(this).closest('tr').find('#pm11').prop("checked")
    paymonth11="1"
  else
    paymonth11="0"
  if $(this).closest('tr').find('#pm12').prop("checked")
    paymonth12="1"
  else
    paymonth12="0"

  cust_id=$(this).closest('tr').find('#input0').val()
  cust_name=$(this).closest('tr').find('#input1').val()
  cust_stat=$(this).closest('tr').find('#input2').val()
  won_staff=$(this).closest('tr').find('#input3').val()
  cust_note=$(this).closest('tr').find('#input4').val()
  cust_payment=$(this).closest('tr').find('#payselect').val()
  cust_payday=$(this).closest('tr').find('#payday_input').val()

  $(this).closest('tr').find('#input1').attr("onfocus","this.blur()").removeClass("round1​").addClass("border-0")
  $(this).closest('tr').find("#input4").removeClass("round1​").addClass("border-0").attr("onfocus","this.blur()")
  $(this).closest('tr').find("#payday_input").removeClass("round1​").addClass("border-0").attr("onfocus","this.blur()")
  $('table td:nth-child(22)').show()
  $('table td:nth-child(24)').show()
  $(this).closest('tr').find("#yesOrNoE").hide()
  $(this).closest('tr').find("#op1").hide()
  $(this).closest('tr').find("#op2").hide()
  $(this).closest('tr').find("#op3").hide()
  $(this).closest('tr').find("#op0").hide()
  $(this).closest('tr').find("#ps1").hide()
  $(this).closest('tr').find("#ps2").hide()
  $(this).closest('tr').find("#ps3").hide()
  $(this).closest('tr').find("#ps4").hide()
  $(this).closest('tr').find("#ps5").hide()
  $(this).closest('tr').find("#ps6").hide()
  $(this).closest('tr').find("#ps7").hide()
  $(this).closest('tr').find("#ps8").hide()
  $(this).closest('tr').find("#ps0").hide()
  $(this).closest('tr').find("#ps0").hide()
  $(this).closest('tr').find("#pm1").attr("disabled","disabled")
  $(this).closest('tr').find("#pm2").attr("disabled","disabled")
  $(this).closest('tr').find("#pm3").attr("disabled","disabled")
  $(this).closest('tr').find("#pm4").attr("disabled","disabled")
  $(this).closest('tr').find("#pm5").attr("disabled","disabled")
  $(this).closest('tr').find("#pm7").attr("disabled","disabled")
  $(this).closest('tr').find("#pm6").attr("disabled","disabled")
  $(this).closest('tr').find("#pm8").attr("disabled","disabled")
  $(this).closest('tr').find("#pm9").attr("disabled","disabled")
  $(this).closest('tr').find("#pm10").attr("disabled","disabled")
  $(this).closest('tr').find("#pm11").attr("disabled","disabled")
  $(this).closest('tr').find("#pm12").attr("disabled","disabled")
  $(this).closest('a').removeAttr("href")

  cust_url="/customers/customers?cust_id="+cust_id+"&;cust_name="+cust_name+"&;won_staff="+
           won_staff+"&;cust_note="+cust_note+"&;cust_payment="+cust_payment+"&;cust_stat="+
           cust_stat+"&;cust_payday="+cust_payday+
           "&;paymonth01="+paymonth01+"&;paymonth02="+paymonth02+"&;paymonth03="+paymonth03+
           "&;paymonth04="+paymonth04+"&;paymonth05="+paymonth05+"&;paymonth06="+paymonth06+
           "&;paymonth07="+paymonth07+"&;paymonth08="+paymonth08+"&;paymonth09="+paymonth09+
           "&;paymonth10="+paymonth10+"&;paymonth11="+paymonth11+"&;paymonth12="+paymonth12+
           "&;locale=zh_TW"

  xhttp = new XMLHttpRequest
  xhttp.onreadystatechange = ->
   if @readyState == 4 and @status == 200
     $(".show").html(@responseText)
  xhttp.open "GET", cust_url, true
  # xhttp.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
  xhttp.send()
  return false





  # 觸發 '修改取消' 按鈕
# $(document).on "click", "#check_resetE", (event) ->
#   event.preventDefault()
#   location.reload();
#   return false
$(document).on "click", "#check_resetC", (event) ->
  event.preventDefault()
  location.reload();
  return false
$(document).on "click", "#reset_button", (event) ->
  event.preventDefault()
  location.reload();
  return false

# 觸發 '列印條碼' 按鈕
# $(document).on "click", ".barcode_button", (event) ->
#   event.preventDefault()
#   if window.ActiveXObject
#     TestFun ->
#       TSCObj = undefined
#       TSCObj = new ActiveXObject('TSCActiveX.TSCLIB')
#       TSCObj.ActiveXopenport 'TSC TTP-246M Pro'
#       TSCObj.ActiveXsendcommand 'SIZE 60 mm, 27 mm'
#       TSCObj.ActiveXsendcommand 'SPEED 4'
#       TSCObj.ActiveXsendcommand 'DENSITY 12'
#       TSCObj.ActiveXsendcommand 'DIRECTION 1'
#       TSCObj.ActiveXsendcommand 'SET TEAR ON'
#       TSCObj.ActiveXclearbuffer()
#       TSCObj.ActiveXbarcode '134', '25', '128M', '100', '0', '0', '2', '4', 'CP508012'
#       TSCObj.ActiveXwindowsfont 56, 115, 120, 0, 2, 0, 'Arial Narrow', 'CP508012'
#       TSCObj.ActiveXprintlabel '1', '1'
#       TSCObj.ActiveXcloseport()
#       return false
