$(document).on('turbolinks:load', function(){
  $(function(){
    $('#reset-button').on('click', function(){
      $('input[type="search"]').val('');
      $('input[name="q[tags_id_in][]"]').prop('checked', false);
      $('input[name="q[categories_id_in][]"]').prop('checked', false);
    });
  });
});