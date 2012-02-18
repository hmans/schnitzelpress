$(document).ready(function() {

});

$(document).endlessScroll({
  fireOnce: true,
  fireDelay: false,
  //loader: "<div class=\"loading\">mooooooooo<div>",
  insertAfter: "article.post:last",
  callback: function(seq) {
    $.ajax({
      url: '/more_posts',
      data: { seq: seq },
      success: function(data) {
        $('article.post:last').after(data);
      }
    });
  }
});
