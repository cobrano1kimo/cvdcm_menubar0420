# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# $.ajaxSetup headers: 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')

# 觸發 點擊 GridView Row 記錄，並且顯示資料於 Form 中
$(document).on "turbolinks:load", ->
$(document).on "click", ".table tr", (event) ->
  event.preventDefault()
  $('table td:nth-child(1)').removeClass 'fa fa-play'
  $(this).find('td:nth-child(1)').addClass 'fa fa-play'
  menu_id = $(@).find("td:nth-child(2)").text()
  xhttp = new XMLHttpRequest
  xhttp.onreadystatechange = ->
   if @readyState == 4 and @status == 200
     $(".myform").html(@responseText)
  xhttp.open "GET", "menubars/"+menu_id+"/form", true
  # xhttp.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
  xhttp.send()
  return false


# 觸發 '查詢' 按鈕
$(document).on "click", "#query_button", (event) ->
  event.preventDefault()
  cust_id = $("#input0").val()
  acc_date= $("#date_yy").val()+$("#date_mm").val()
  acc_url="/query/accounts?cust_id="+cust_id+"&;acc_date="+acc_date+"&;locale=zh_TW"
  xhttp = new XMLHttpRequest
  xhttp.onreadystatechange = ->
   if @readyState == 4 and @status == 200
     $(".show").html(@responseText)
  xhttp.open "GET", acc_url, true
  # xhttp.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
  xhttp.send()
  return false



# 觸發 '新增' 或 '修改' 的確認按鈕
$(document).on "click", "#create_acc", (event) ->
  event.preventDefault()
  $(this).closest('tr').find('#input0').val("")
  $(this).closest('tr').find('#input1').val("")
  $(this).closest('tr').find('#input3').val("")
  $(this).closest('tr').find('#input5').val("")
  $(this).closest('tr').find('#input6').val("")
  $(this).closest('tr').find('#input7').val("")
  $(this).closest('tr').find('#input0').removeAttr("onfocus").removeClass("border-0").addClass("border-4")
  $(this).closest('tr').find('#input1').removeAttr("onfocus").removeClass("border-0").addClass("border-4")
  $(this).closest('tr').find("#input3").removeAttr("onfocus").removeClass("border-0").addClass("border-4")
  $(this).closest('tr').find("#input6").removeAttr("onfocus").removeClass("border-0").addClass("border-4")
  $(this).closest('tr').find("#input7").removeAttr("onfocus").removeClass("border-0").addClass("border-4")
  $('table td:nth-child(11)').hide()
  $('table td:nth-child(12)').hide()
  $('table td:nth-child(15)').hide()
  $(this).closest('tr').find("#yesOrNoC").show()
  $td = $(this).parents("tr").children("td")
  index=($td.eq(0).text())
  #$td.eq(0).hide()


  switch index
      when "1"
          $("#2").fadeOut()
          $("#3").fadeOut()
          $("#4").fadeOut()
          $("#5").fadeOut()
          $("#6").fadeOut()
          $("#7").fadeOut()
          $("#8").fadeOut()
          $("#9").fadeOut()
          $("#10").fadeOut()
      when "2"
          $("#1").fadeOut()
          $("#3").fadeOut()
          $("#4").fadeOut()
          $("#5").fadeOut()
          $("#6").fadeOut()
          $("#7").fadeOut()
          $("#8").fadeOut()
          $("#9").fadeOut()
          $("#10").fadeOut()
      when "3"
          $("#1").fadeOut()
          $("#2").fadeOut()
          $("#4").fadeOut()
          $("#5").fadeOut()
          $("#6").fadeOut()
          $("#7").fadeOut()
          $("#8").fadeOut()
          $("#9").fadeOut()
          $("#10").fadeOut()
      when "4"
          $("#1").fadeOut()
          $("#2").fadeOut()
          $("#3").fadeOut()
          $("#5").fadeOut()
          $("#6").fadeOut()
          $("#7").fadeOut()
          $("#8").fadeOut()
          $("#9").fadeOut()
          $("#10").fadeOut()
      when "5"
          $("#1").fadeOut()
          $("#2").fadeOut()
          $("#3").fadeOut()
          $("#4").fadeOut()
          $("#6").fadeOut()
          $("#7").fadeOut()
          $("#8").fadeOut()
          $("#9").fadeOut()
          $("#10").fadeOut()
      when "6"
          $("#1").fadeOut()
          $("#2").fadeOut()
          $("#3").fadeOut()
          $("#4").fadeOut()
          $("#5").fadeOut()
          $("#7").fadeOut()
          $("#8").fadeOut()
          $("#9").fadeOut()
          $("#10").fadeOut()
      when "7"
          $("#1").fadeOut()
          $("#2").fadeOut()
          $("#3").fadeOut()
          $("#4").fadeOut()
          $("#5").fadeOut()
          $("#6").fadeOut()
          $("#9").fadeOut()
          $("#8").fadeOut()
          $("#10").fadeOut()
      when "8"
          $("#2").fadeOut()
          $("#3").fadeOut()
          $("#4").fadeOut()
          $("#5").fadeOut()
          $("#6").fadeOut()
          $("#7").fadeOut()
          $("#1").fadeOut()
          $("#9").fadeOut()
          $("#10").fadeOut()
      when "9"
          $("#2").fadeOut()
          $("#3").fadeOut()
          $("#4").fadeOut()
          $("#5").fadeOut()
          $("#6").fadeOut()
          $("#7").fadeOut()
          $("#8").fadeOut()
          $("#1").fadeOut()
          $("#10").fadeOut()
      when "10"
          $("#2").fadeOut()
          $("#3").fadeOut()
          $("#4").fadeOut()
          $("#5").fadeOut()
          $("#6").fadeOut()
          $("#7").fadeOut()
          $("#8").fadeOut()
          $("#9").fadeOut()
          $("#1").fadeOut()
  return false


# 觸發 '刪除' 按鈕
$(document).on "click", "#delete_acc", (event) ->
  event.preventDefault()
  if confirm '確定刪除該資料嗎'
    $(this).closest('tr').fadeOut()
                         # 觸發 a link 的 click (rails link_to)
  return false


# 觸發 '修改' 按鈕
$(document).on "click", "#edit_acc", (event) ->
  event.preventDefault()

  $(this).closest('tr').find('#input1').removeAttr("onfocus").removeClass("border-0").addClass("border-4")
  $(this).closest('tr').find("#input3").removeAttr("onfocus").removeClass("border-0").addClass("border-4")
  $(this).closest('tr').find("#input6").removeAttr("onfocus").removeClass("border-0").addClass("border-4")
  $(this).closest('tr').find("#input7").removeAttr("onfocus").removeClass("border-0").addClass("border-4")
  $('table td:nth-child(11)').hide()
  $('table td:nth-child(12)').hide()
  $('table td:nth-child(15)').hide()
  $(this).closest('tr').find("#yesOrNoE").show()

  return false

# 觸發 '修改確定' 按鈕

$(document).on "click", "#acc_checkE", (event) ->
  event.preventDefault()
  id=$(this).closest('tr').find('#input').val()
  acc_no=$(this).closest('tr').find('#input3').val()
  cust_type=$(this).closest('tr').find('#input1').val()
  acc_cost=$(this).closest('tr').find('#input6').val()
  acc_note=$(this).closest('tr').find('#input7').val()

  $(this).closest('tr').find('#input1').attr("onfocus","this.blur()").removeClass("border-4").addClass("border-0")
  $(this).closest('tr').find("#input3").removeClass("border-4").addClass("border-0").attr("onfocus","this.blur()")
  $(this).closest('tr').find("#input6").removeClass("border-4").addClass("border-0").attr("onfocus","this.blur()")
  $(this).closest('tr').find("#input7").removeClass("border-4").addClass("border-0").attr("onfocus","this.blur()")
  $('table td:nth-child(11)').show()
  $('table td:nth-child(15)').show()
  $('table td:nth-child(12)').show()
  $(this).closest('tr').find("#yesOrNoE").hide()
  $(this).closest('a').removeAttr("href")
  acc_url="/accounts/accounts?acc_cost="+acc_cost+"&amp;acc_no="+acc_no+"&amp;acc_note="+acc_note+"&amp;cust_type="+cust_type+"&amp;id="+id+"&amp;locale=zh_TW"
  xhttp = new XMLHttpRequest
  xhttp.onreadystatechange = ->
   if @readyState == 4 and @status == 200
     $(".show").html(@responseText)
  xhttp.open "GET", acc_url, true
  # xhttp.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
  xhttp.send()
  return false

$(document).on "click", "#acc_checkC", (event) ->
  event.preventDefault()
  id=$(this).closest('tr').find('#input').val()#多抓的
  cust_id=$(this).closest('tr').find('#input0').val()
  acc_no=$(this).closest('tr').find('#input3').val()
  cust_type=$(this).closest('tr').find('#input1').val()
  acc_cost=$(this).closest('tr').find('#input6').val()
  acc_note=$(this).closest('tr').find('#input7').val()
  acc_kind=$(this).closest('tr').find('#input2').val()
  acc_year=$(this).closest('tr').find('#input4').val().substr 3,2 #acc_date 之年
  acc_month=$(this).closest('tr').find('#input4').val().substr 0,2#acc_date 之月
  acc_date="20"+acc_year+acc_month　#轉換成資料庫格式YYYYMM

　　#畫面控制邊框
  $(this).closest('tr').find('#input1').attr("onfocus","this.blur()").removeClass("border-4").addClass("border-0")
  $(this).closest('tr').find("#input3").removeClass("border-4").addClass("border-0").attr("onfocus","this.blur()")
  $(this).closest('tr').find("#input6").removeClass("border-4").addClass("border-0").attr("onfocus","this.blur()")
  $(this).closest('tr').find("#input7").removeClass("border-4").addClass("border-0").attr("onfocus","this.blur()")
  $(this).closest('tr').find("#input0").removeClass("border-4").addClass("border-0").attr("onfocus","this.blur()")
　　#按鈕控制 顥示
  $('table td:nth-child(11)').show()
  $('table td:nth-child(15)').show()
  $('table td:nth-child(12)').show()
  $td = $(this).parents("tr").children("td")
  index=($td.eq(0).text())
  $(this).closest('tr').find("#yesOrNoC").hide()
  #開啓REUQEST指向ACTION
  $(this).closest('a').removeAttr("href")
  acc_url="/new/accounts?id="+id+"&;acc_cost="+acc_cost+"&;acc_no="+acc_no+"&;acc_note="+acc_note+"&;cust_type="+cust_type+"&;acc_kind="+acc_kind+"&;acc_date="+acc_date+"&;cust_id="+cust_id+"&;locale=zh_TW"
  switch index
      when "1"
          $("#2").fadeIn()
          $("#3").fadeIn()
          $("#4").fadeIn()
          $("#5").fadeIn()
          $("#6").fadeIn()
          $("#7").fadeIn()
          $("#8").fadeIn()
          $("#9").fadeIn()
          $("#10").fadeIn()
      when "2"
          $("#1").fadeIn()
          $("#3").fadeIn()
          $("#4").fadeIn()
          $("#5").fadeIn()
          $("#6").fadeIn()
          $("#7").fadeIn()
          $("#8").fadeIn()
          $("#9").fadeIn()
          $("#10").fadeIn()
      when "3"
          $("#1").fadeIn()
          $("#2").fadeIn()
          $("#4").fadeIn()
          $("#5").fadeIn()
          $("#6").fadeIn()
          $("#7").fadeIn()
          $("#8").fadeIn()
          $("#9").fadeIn()
          $("#10").fadeIn()
      when "4"
          $("#1").fadeIn()
          $("#2").fadeIn()
          $("#3").fadeIn()
          $("#5").fadeIn()
          $("#6").fadeIn()
          $("#7").fadeIn()
          $("#8").fadeIn()
          $("#9").fadeIn()
          $("#10").fadeIn()
      when "5"
          $("#1").fadeIn()
          $("#2").fadeIn()
          $("#3").fadeIn()
          $("#4").fadeIn()
          $("#6").fadeIn()
          $("#7").fadeIn()
          $("#8").fadeIn()
          $("#9").fadeIn()
          $("#10").fadeIn()
      when "6"
          $("#1").fadeIn()
          $("#2").fadeIn()
          $("#3").fadeIn()
          $("#4").fadeIn()
          $("#5").fadeIn()
          $("#7").fadeIn()
          $("#8").fadeIn()
          $("#9").fadeIn()
          $("#10").fadeIn()
      when "7"
          $("#1").fadeIn()
          $("#2").fadeIn()
          $("#3").fadeIn()
          $("#4").fadeIn()
          $("#5").fadeIn()
          $("#6").fadeIn()
          $("#9").fadeIn()
          $("#8").fadeIn()
          $("#10").fadeIn()
      when "8"
          $("#2").fadeIn()
          $("#3").fadeIn()
          $("#4").fadeIn()
          $("#5").fadeIn()
          $("#6").fadeIn()
          $("#7").fadeIn()
          $("#1").fadeIn()
          $("#9").fadeIn()
          $("#10").fadeIn()
      when "9"
          $("#2").fadeIn()
          $("#3").fadeIn()
          $("#4").fadeIn()
          $("#5").fadeIn()
          $("#6").fadeIn()
          $("#7").fadeIn()
          $("#8").fadeIn()
          $("#1").fadeIn()
          $("#10").fadeIn()
      when "10"
          $("#2").fadeIn()
          $("#3").fadeIn()
          $("#4").fadeIn()
          $("#5").fadeIn()
          $("#6").fadeIn()
          $("#7").fadeIn()
          $("#8").fadeIn()
          $("#9").fadeIn()
          $("#1").fadeIn()

  xhttp = new XMLHttpRequest
  xhttp.onreadystatechange = ->
   if @readyState == 4 and @status == 200
     $(".show").html(@responseText)
  xhttp.open "GET", acc_url, true
  # xhttp.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
  xhttp.send()
  return false


  # 觸發 '修改取消' 按鈕
$(document).on "click", "#check_resetE", (event) ->
  event.preventDefault()
  location.reload();
  return false
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
