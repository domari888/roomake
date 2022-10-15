$(document).on('turbolinks:load', function() {
  $(function() {
    $('#edit-modal').on('show.bs.modal', function () {
      const content = gon.edit_content
      const photos = gon.edit_photos
      const tags = gon.edit_tags
      const categories = gon.edit_categories
      // 投稿内容を表示
      $('#edit_post_form_content').val(content)
      // 投稿画像を表示
      $('#edit-drop').prevAll().remove();
      photos.forEach(function(photo){
      const html = `<div class="edit-preview-item" data-id="${photo.id}">
                      <img src="${photo.image.url}" class="preview-image">
                      <button type="button" class="btn btn-dark-gray btn-sm rounded-circle delete-preview" data-action="edit"><i class="fas fa-times"></i></button>
                    </div>`;
        $('#edit-drop').before($(html));
        const previewItemLength = $('#edit-drop').prevAll('.edit-preview-item').length;
        if ( previewItemLength >= 1 && previewItemLength <= 6 ) {
          $('#edit-button').prop('disabled', false);
          if ( previewItemLength === 6 ) {
            $('#edit-drop').hide();
          }
        }
      });

      $('.checkbox-visibility').prop('checked', false);
      // 投稿タグの表示
      tags.forEach(function(tag){
        const targetTag = $(`#edit_post_form_tag_ids_${tag.id}`);
        $(targetTag).prop('checked', true);
      });
      // 投稿カテゴリーの表示
      categories.forEach(function(category){
        const targetCategory = $(`#edit_post_form_category_ids_${category.id}`);
        $(targetCategory).prop('checked', true);
      });
    });
  });
});