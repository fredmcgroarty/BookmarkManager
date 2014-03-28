$( document ).ready(function() {
   $( ".sign-out" ).click(function() {
  $.ajax({
    url: '/sessions',
    type: 'DELETE',
    success: function(result) {
        window.location.href = "/";
    }
});

});
});