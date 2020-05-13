
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


# 觸發 '新增' 按鈕
$(document).on "click", ".new_button", (event) ->
  event.preventDefault()
  $('a.new-button')[0].click()
  return false


# 觸發 '新增' 或 '修改' 的確認按鈕
$(document).on "click", ".submit_button", (event) ->
  event.preventDefault()
  $(".submit-button").click()
  return false


# 觸發 '刪除' 按鈕
$(document).on "click", ".delete_button", (event) ->
  event.preventDefault()
  menu_id = $('#menubar_menu_id').val()
  $('#gridview-'+menu_id).find('td').eq(4).find('a')[0].click()                       # 觸發 a link 的 click (rails link_to)
  return false


# 觸發 '修改' 按鈕
$(document).on "click", ".edit_button", (event) ->
  event.preventDefault()
  menu_id = $('#menubar_menu_id').val()
  $('#gridview-'+menu_id).find('td').eq(3).find('a')[0].click()                       # 觸發 a link 的 click (rails link_to)
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
