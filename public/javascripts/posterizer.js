// Posterizer-specific javascript to mimic some of Posterous's behavior
$(document).ready( function(){
  $("#comment_link").click(function(e) {
    $("#post_commentarea").slideDown();
    e.preventDefault();
  });

  $(".comment_hide_button a").click(function(e) {
    $("#post_commentarea").slideUp();
    e.preventDefault();
  });

});
