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


# 觸發 '修改' 按鈕
$(document).on "click", "#edit_cust", (event) ->
  event.preventDefault()

  $(this).closest('tr').find('#input1').removeAttr("onfocus").removeClass("border-0").addClass("round1")
  $(this).closest('tr').find("#input4").removeAttr("onfocus").removeClass("border-0").addClass("round1​")
  $('table td:nth-child(8)').hide()
  $('table td:nth-child(10)').hide()
  $(this).closest('tr').find("#yesOrNoE").show()
  $(this).closest('tr').find("#op1").show()
  $(this).closest('tr').find("#op2").show()
  $(this).closest('tr').find("#op3").show()
  $(this).closest('tr').find("#op0").hide()

  return false

# 觸發 '修改確定' 按鈕

$(document).on "click", "#cust_checkE", (event) ->
  event.preventDefault()

  cust_id=$(this).closest('tr').find('#input0').val()
  cust_name=$(this).closest('tr').find('#input1').val()
  cust_stat=$(this).closest('tr').find('#input2').val()
  won_staff=$(this).closest('tr').find('#input3').val()
  cust_note=$(this).closest('tr').find('#input4').val()

  $(this).closest('tr').find('#input1').attr("onfocus","this.blur()").removeClass("round1​").addClass("border-0")

  $(this).closest('tr').find("#input4").removeClass("round1​").addClass("border-0").attr("onfocus","this.blur()")
  $('table td:nth-child(8)').show()
  $('table td:nth-child(10)').show()
  $(this).closest('tr').find("#yesOrNoE").hide()
  $(this).closest('tr').find("#op1").hide()
  $(this).closest('tr').find("#op2").hide()
  $(this).closest('tr').find("#op3").hide()
  $(this).closest('tr').find("#op0").show()
  $(this).closest('a').removeAttr("href")
  cust_url="/customers/customers?cust_id="+cust_id+"&amp;cust_name="+cust_name+"&amp;won_staff="+won_staff+"&amp;cust_note="+cust_note+"&amp;cust_stat="+cust_stat+"&amp;locale=zh_TW"

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
