$(document).on('turbolinks:load', function(){
  $(function(){
    const windowHeight = $(window).height();
    $(".card-container").css("min-height", (windowHeight - 112) + "px");
  });
});