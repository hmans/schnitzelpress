$(document).ready(function() {

});

$(document).endlessScroll({
  fireOnce: true,
  fireDelay: 1000,
  callback: function(seq) {
    console.log("Endless scrolling "+seq);
    $.ajax({
      url: '/more_posts',
      data: { seq: seq },
      beforeSend: function() {
        $('#loading_more').fadeIn(200);
      },
      success: function(data) {
        $('#loading_more').hide();
        $('article.post:last').after(data);
      }
    });
  }
});
