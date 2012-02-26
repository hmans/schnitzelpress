function loginViaEmail() {
  navigator.id.getVerifiedEmail(function(assertion) {
    if (assertion) {
      $('input[name=assertion]').val(assertion);
      $('form').submit();
    } else {
      window.location = "/auth/failure";
    }
  });
}

$(document).ready(function() {
  $('form').submit(function(evt) {
    $('html').addClass('loading');
  });

  $('a#browser_id').click(function(evt) {
    evt.preventDefault();
    loginViaEmail();
  });
});
