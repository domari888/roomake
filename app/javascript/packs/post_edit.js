$(document).on('turbolinks:load', function() {
  $(function() {
    $('#edit-modal').on('show.bs.modal', function (event) {
      let content = gon.edit_content
      let photos = gon.edit_photos
      let tags = gon.edit_tags
      // 投稿内容を表示
      $('#content-form').val(content)
      // 投稿画像を表示
      let previewData = $('#edit-drop').prevAll('.preview-item');
      let targetIds = $.map(previewData, function(preview) {
        return $(preview).data('id');
      });
      let photoIds = $.map(photos, function(photo) {
        return photo.id;
      });
      if (targetIds.toString() !== photoIds.toString()) {
        $('#edit-drop').prevAll().remove();
        photos.forEach(function(photo){
        let html = `<div class="preview-item" data-id="photos-${photo.id}">
                        <img src="${photo.image.url}" class="preview-image">
                        <button type="button" class="btn btn-dark btn-sm rounded-circle delete-preview" id="photo-delete" data-action="edit"><i class="fas fa-times"></i></button>
                      </div>`;
          $('#edit-drop').before($(html));
          let previewItemLength = $('#edit-drop').prevAll('.preview-item').length;
          if ( previewItemLength >= 6 ){
            $('#edit-drop').hide();
          }
        });
      }

      // 投稿タグの表示
      const checkedTag = $('.tags-check-box:checked');
      const checkedTagIds = $.map(checkedTag, function(tag){
        const previewTag = $(tag).val();
        return parseInt(previewTag);
      });
      const tagIds = $.map(tags, function(tag){
        return tag.id;
      });
      if(checkedTagIds.toString() !== tagIds.toString()){
        $('.tags-check-box').prop('checked', false);
        tags.forEach(function(tag){
          const tagsIndex = tag.id - 1;
          const targetTag = $('.tags-check-box')[tagsIndex];
          $(targetTag).prop('checked', true);
        });
      }      
    });
  });
});