$(document).on('turbolinks:load', function() {
  $(function() {
    $('#edit-modal').on('show.bs.modal', function () {
      const content = gon.edit_content
      const photos = gon.edit_photos
      const tags = gon.edit_tags
      const categories = gon.edit_categories
      // 投稿内容を表示
      $('#content-form').val(content)
      // 投稿画像を表示
      const previewData = $('#edit-drop').prevAll('.preview-item');
      const targetIds = $.map(previewData, function(preview) {
        return $(preview).data('id');
      });
      const photoIds = $.map(photos, function(photo) {
        return photo.id;
      });
      if (targetIds.toString() !== photoIds.toString()) {
        $('#edit-drop').prevAll().remove();
        photos.forEach(function(photo){
        const html = `<div class="preview-item" data-id="photos-${photo.id}">
                        <img src="${photo.image.url}" class="preview-image">
                        <button type="button" class="btn btn-dark btn-sm rounded-circle delete-preview" id="photo-delete" data-action="edit"><i class="fas fa-times"></i></button>
                      </div>`;
          $('#edit-drop').before($(html));
          const previewItemLength = $('#edit-drop').prevAll('.preview-item').length;
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

      // 投稿カテゴリーの表示
      const checkedCategory = $('.categories-check-box:checked');
      const checkedCategoryIds = $.map(checkedCategory, function(category){
        const previewCategory = $(category).val();
        return parseInt(previewCategory);
      });
      const categoryIds = $.map(categories, function(category){
        return category.id;
      });
      if(checkedCategoryIds.toString() !== categoryIds.toString()){
        $('.categories-check-box').prop('checked', false);
        categories.forEach(function(category){
          const categoriesIndex = category.id - 1
          const targetCategory = $('.categories-check-box')[categoriesIndex];
          $(targetCategory).prop('checked', true);
        });
      }
    });
  });
});