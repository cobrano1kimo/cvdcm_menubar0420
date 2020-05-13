# 觸發 '確定' 的確認按鈕
$(document).on "turbolinks:load", ->
  $(document).on "click", "#submit_button", (event) ->
    event.preventDefault()

    $('#toolbar').show()
    $('#yesOrNo').hide()

    if window.buttontype == 'new_button'
         alert $("#wh1sform").attr('action')
         alert $("input[name='_method']").attr('value')

         $("#wh1sform").submit()
    if window.buttontype == 'edit_button'
         $(".simple_form").submit()
       #alert $("#edit_wh1_A").attr("method")
    if window.buttontype == 'delete_button'
         location.reload()
         WH100 = $("#input"+0).val()

         xhttp = new XMLHttpRequest
         xhttp.onreadystatechange = ->
              if @readyState == 4 and @status == 200
                  $(".myform").html(@responseText)

        xhttp.open "get", "wh1s/"+WH100+"/delete", true

        xhttp.send()

    return false
