$(document).ready(function(){
  var form = $("#review-form");
  timer.start();

  $(form).submit(function(event){
    timer.stop();
    $("#quality_timer").val(timer.resultTime());

    event.preventDefault();

    makeReview();
  });


  function makeReview(){
    var $request = $.ajax({
      type: "POST",
      url: "/reviews",
      dataType: "json",
      data: form.serialize(),
    });

    $request.done(function(result) {
      alert(result.message);
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

    $request.done(function(result){
      if (result.card_id) {
        $(".card_id").val(result.card_id);
        $(".user_translation").val('');
        $(".original_text").fadeOut(500, function(){
          $(this).text(result.original_text);
          $(this).fadeIn(500);
        });
        if (result.image) {
          var $image = $("<img>", { src: result.image });
          $(".image").fadeOut(500, function(){
            $(this).html($image);
            $(this).fadeIn(500);
          });
        } else {
          $(".image").empty();
        }
      } else {
        $(".image").remove();
        $(".original_text").remove();
        $(form).remove();
        $(".container").append(result.message)
      }
    });
  }
});
