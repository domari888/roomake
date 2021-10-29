$(document).on('turbolinks:load', function () {
  $(function(){
    let editDataBox = new DataTransfer();
    let edit_file_field = document.querySelector('input[data-action=edit]');
    let newDataBox = new DataTransfer();
    let new_file_field = document.querySelector('input[data-action=new]');
    // 画像選択時にプレビューを表示
    $('.post-preview-image').on("change", function(){
      let dataBox, fileField
      let action = $(this).data('action');
      if (action === "edit") {
        dataBox = editDataBox
        fileField = edit_file_field
      } else {
        dataBox = newDataBox
        fileField = new_file_field
      }
      let files = $('input[type="file"]').prop('files')[0];
      $.each(this.files, function(i, file){
        let fileReader = new FileReader();
        let lastFileId = dataBox.files.length === 0 ? 0 : $(dataBox.files).last()[0].id;
        file.id = lastFileId + 1;
        dataBox.items.add(file);
        fileField.files = dataBox.files
        fileReader.readAsDataURL(file);
        fileReader.onloadend = function() {
          let html = `<div class="preview-item" data-id="${file.id}">
                        <img src="${fileReader.result}" class="preview-image">
                        <button type="button" class="btn btn-dark btn-sm rounded-circle delete-preview" data-action="${action}"><i class="fas fa-times"></i></button>
                      </div>`;
          $(`#${action}-drop`).before($(html));
          let previewItemLength = $(`#${action}-drop`).prevAll('.preview-item').length;
          if ( previewItemLength >= 6 ){
            $(`#${action}-drop`).hide();
            if ( previewItemLength == 7 ){
              $(`#${action}-button`).prop('disabled', true);
              alert('画像は最大 6枚 にしてください');
            }
          }
        };
      });
    });
    // 画像の削除
    $('.preview-box').on("click", '.delete-preview', function(){
      let dataBox, fileField;
      let action = $(this).data('action');
      if (action === "edit") {
        dataBox = editDataBox
        fileField = edit_file_field
      } else {
        dataBox = newDataBox
        fileField = new_file_field
      }
      let targetImage = $(this).parents('.preview-item');
      let targetId = $(targetImage).data('id');
      $.each(fileField.files, function(i, file){
        if(file.id === targetId){
          dataBox.items.remove(i);
          fileField.files = dataBox.files;
          return false;
        }
      });
      if(typeof(targetId) === 'string'){
        const photoId = targetId.replace('photos-', '');
        const deleteId = parseInt(photoId);
        $('#edit-drop').before(`<input type="hidden" name="post_form[delete_ids][]" value="${deleteId}">`);
      }
      targetImage.remove();
      let previewItemLength = $(`#${action}-drop`).prevAll('.preview-item').length;
      if ( previewItemLength <= 6 ){
        $(`#${action}-button`).prop('disabled', false);
        if ( previewItemLength <= 5 ){
          $(`#${action}-drop`).show();
        }
      }
    });
  });
});
