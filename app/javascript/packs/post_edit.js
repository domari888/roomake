$(document).on('turbolinks:load', function() {
  $(function() {
    $('#edit-modal').on('show.bs.modal', function (event) {
      let content = gon.edit_content
      let photos = gon.edit_photos
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
    });
  });
});