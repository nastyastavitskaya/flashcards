$(document).ready(function(){
  var form = $("#review-form");
  timer.start();


  $(form).submit(function(event){
    // var msg = request.getResponseHeader('X-Message');
    // var type = request.getResponseHeader('X-Message-Type');
    timer.stop();
    $("#quality_timer").val(timer.resultTime());

    // var msg = request.getResponseHeader('X-Message');
    // var type = request.getResponseHeader('X-Message-Type');
    // show_ajax_message(msg, type);

    event.preventDefault();
    makeReview();
  });


  function makeReview(){
    var $request = $.ajax({
      type: "POST",
      url: "/reviews",
      dataType: "html",
      data: form.serialize(),
    });

    $request.done(function(result) {
      // var type = Object.keys(result.msg);
      // var msg = result.msg('X-Message-Type');
      // show_ajax_message(msg, type);
      getNextcard();
      timer.start();
    });
  };

  function getNextcard(){
    var $request = $.ajax({
      type: "GET",
      url: "/reviews",
      dataType: "json"
    });

    $request.done(function(result) {
      $(".card_id").val(result.card_id);
      $(".user_translation").val('');
      var $image = $('<img>', { src: result.image });
      $(".image").fadeOut(500, function(){
        $(this).html($image);
        $(this).fadeIn(500);
      });

      $(".original_text").fadeOut(500, function(){
        $(this).text(result.original_text);
        $(this).fadeIn(500);
      });
    });
  }

  // var fade_flash = function() {
  //   $(".flash_notice").delay(5000).fadeOut("slow");
  //   $(".flash_alert").delay(5000).fadeOut("slow");
  //   $(".flash_error").delay(5000).fadeOut("slow");
  // };
  // var show_ajax_message = function(msg, type) {
  //   $(".flash_message").html('<div class="flash_'+type+'">'+msg+'</div>');
  //   fade_flash();
  // };

  // $("#flash-message").ajaxComplete(function(event, request) {
  //   var msg = request.getResponseHeader('X-Message');
  //   var type = request.getResponseHeader('X-Message-Type');
  //   show_ajax_message(msg, type); //use whatever popup, notification or whatever plugin you want
  // });
});
