ready = ->
  start_time = new Date().getTime()
  $('form').on 'submit', ->
    end_time = new Date().getTime()
    quality_timer = $('#quality_timer').val(end_time - start_time)
    $(this).append($(quality_timer))


$(document).ready(ready)
$(document).on('page:load', ready)


