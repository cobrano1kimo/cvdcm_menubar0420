$(document).on "click", "#changfontsize", (event) ->
      #$('#bodyrow #input0.form-control').css('font-size',$('#changfontsize').val())
      $('.form-control').css('font-size',$('#changfontsize').val())
return false
