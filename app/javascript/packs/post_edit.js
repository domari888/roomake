$(document).on('turbolinks:load', function() {
  let content = gon.edit_content
  $(function() {
    // 投稿内容を表示
    $('#edit-modal').on('show.bs.modal', function () {
      $('#edit-form').val(content)
    });
  });
});