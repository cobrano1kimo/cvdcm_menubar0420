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
  cust_id = $("#account_cust_id").val()
  if cust_id=="nil"
    id= [$("#actyy").val()+$("#actmm").val()]
  else
    id= [$("#account_cust_id").val()+$("#actyy").val()+$("#actmm").val()]
  alert(cust_id + id)
  xhttp = new XMLHttpRequest
  xhttp.onreadystatechange = ->
   if @readyState == 4 and @status == 200
     $(".myform").html(@responseText)
  xhttp.open "GET", "accounts/"+id, true
  # xhttp.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
  xhttp.send()
  return false



# 觸發 '新增' 或 '修改' 的確認按鈕
$(document).on "click", ".submit_button", (event) ->
  event.preventDefault()
  $(".submit-button").click()
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
  $('table td:nth-child(13)').hide()
  $('table td:nth-child(11)').hide()
  $(this).closest('tr').find("#edit_td").hide()
  $(this).closest('tr').find("#yesOrNo").show()

  return false

# 觸發 '修改確定' 按鈕

$(document).on "click", "#acc_check", (event) ->
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
  $('table td:nth-child(13)').show()
  $('table td:nth-child(11)').show()
  $(this).closest('tr').find("#edit_td").show()
  $(this).closest('tr').find("#yesOrNo").hide()
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



  return false
  # 觸發 '修改取消' 按鈕
$(document).on "click", "#check_reset", (event) ->
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
