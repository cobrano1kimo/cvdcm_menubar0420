
# 觸發 '下載PDF' 的確認按鈕
$(document).on "click", "#download_pdf_acc", (event) ->
  event.preventDefault()
  token = $("meta[name='csrf-token']").attr("content")
  acc_download_pdf_url="/download/accounts"
  xhr = new XMLHttpRequest
  xhr.responseType = "blob"
  xhr.overrideMimeType("application/pdf; charset=utf-8")
  xhr.onload = ->
   if @readyState == 4 and @status == 200
       blob = xhr.response
       a = document.createElement('a')
       a.style = 'display: none'
       document.body.appendChild a
       url = window.URL.createObjectURL(blob)
       a.href = url
       contentDispo = decodeURIComponent(escape(@getResponseHeader('Content-Disposition')))
       fileName = (contentDispo.match(/filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/)[1]).replace(/"/g,'')
       a.download = fileName
       a.click()
       window.URL.revokeObjectURL url

  xhr.open "POST", acc_download_pdf_url, true
  xhr.responseText = 'application/pdf'
  xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest")
  xhr.setRequestHeader("X-CSRF-Token", token)
  xhr.setRequestHeader("Content-Type", "application/pdf; charset=utf-8;")
  xhr.setRequestHeader("Content-Disposition", "attachment")
  xhr.send()
  return false
