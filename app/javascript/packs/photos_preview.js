$(document).on('turbolinks:load', function () {
  $(function(){
    let editDataBox = new DataTransfer();
    let edit_file_field = document.querySelector('input[data-action=edit]');
    let newDataBox = new DataTransfer();
    let new_file_field = document.querySelector('input[data-action=new]');
    const maxFileSize = 1048576 * 5;
    const mimeType = ['image/jpeg', 'image/png'];
    function postsPreview(files, action, dataBox, fileField){
      $.each(files, function(i, file){
        if(maxFileSize < file.size){
          // 画像ファイルが 5MB より大きい場合の処理
          alert('画像ファイルは最大 5MB 以下にしてください');
          fileField.files = dataBox.files
        } else if (!mimeType.includes(file.type)){
          // 画像ファイルが .jpeg, .jpg, .png 以外の場合の処理
          alert('画像ファイルは .jpg, .jpeg, .png のみアップロードできます');
          fileField.files = dataBox.files
        } else {
          const fileReader = new FileReader();
          const lastFileId = dataBox.files.length === 0 ? 0 : $(dataBox.files).last()[0].id;
          file.id = lastFileId + 1;
          dataBox.items.add(file);
          fileField.files = dataBox.files
          fileReader.readAsDataURL(file);
          fileReader.onloadend = function() {
            const html = `<div class="preview-item" data-id="${file.id}">
                          <img src="${fileReader.result}" class="preview-image">
                          <button type="button" class="btn btn-dark-gray btn-sm rounded-circle delete-preview" data-action="${action}"><i class="fas fa-times"></i></button>
                        </div>`;
            $(`#${action}-drop`).before($(html));
            const previewItemLength = $(`#${action}-drop`).prevAll("[class$='preview-item']").length;
            if (previewItemLength > 0){
              $("[id$='post_form_images-error']").css('display', 'none');
              if ( previewItemLength >= 6 ){
                $(`#${action}-drop`).hide();
                if ( previewItemLength === 7 ){
                  $(`#${action}-button`).prop('disabled', true);
                  alert('画像は最大 6枚 にしてください');
                }
              }
            }
          };
        }
      });
    }
    // 画像選択時のプレビュー表示
    $('.post-file-field').on("change", function(){
      let dataBox, fileField
      const action = $(this).data('action');
      if (action === "edit") {
        dataBox = editDataBox
        fileField = edit_file_field
      } else {
        dataBox = newDataBox
        fileField = new_file_field
      }
      if ($(this).val()) {
        const files = $(this).prop('files');
        postsPreview(files, action, dataBox, fileField);
      } else {
        fileField.files = dataBox.files
      }
    });
    // 画像の削除
    $('.preview-box').on("click", '.delete-preview', function(){
      let dataBox, fileField;
      const action = $(this).data('action');
      if (action === "edit") {
        dataBox = editDataBox
        fileField = edit_file_field
      } else {
        dataBox = newDataBox
        fileField = new_file_field
      }
      const targetImage = $(this).parents("[class$='preview-item']");
      const targetId = $(targetImage).data('id');
      if($(targetImage).hasClass('preview-item')){
        $.each(fileField.files, function(i, file){
          if(file.id === targetId){
            dataBox.items.remove(i);
            fileField.files = dataBox.files;
            return false;
          }
        });
      }else{
        $('#edit-drop').before(`<input type="hidden" name="post_form[delete_ids][]" value="${targetId}">`);
      }
      targetImage.remove();
      const previewItemLength = $(`#${action}-drop`).prevAll("[class$='preview-item']").length;
      if ( previewItemLength <= 6 ){
        $(`#${action}-button`).prop('disabled', false);
        if ( previewItemLength <= 5 ){
          $(`#${action}-drop`).show();
          if ( previewItemLength === 0 ){
            $("[id$='post_form_images-error']").css('display', 'block');
          }
        }
      }
    });
    // 画像ドロップ時のプレビュー表示
    $('.modal').on('show.bs.modal', function (e) {
      let dropArea;
      const modalAction = this.id
      if (modalAction === "edit-modal") {
        dropArea = document.getElementById('edit-drop');
      } else {
        dropArea = document.getElementById('new-drop');
      }
      //ドロップエリアの上にある時に発火するイベント
      dropArea.addEventListener("dragover", function(e){
        e.preventDefault();
        $(this).css({'border': '2px solid $dark-gray', 'opacity': '0.5'});
      },false);
      //ドロップエリアから離れた時に発火するイベント
      dropArea.addEventListener("dragleave", function(e){
        e.preventDefault();
        $(this).css({'border': '2px dashed $dark-gray', 'opacity': '1.0'});
      },false);
      // ドロップしたときに発火するイベント
      dropArea.addEventListener("drop", function(e) {
        let dataBox, fileField;
        const action = $(this).children().data('action');
        if (action === "edit") {
          dataBox = editDataBox
          fileField = edit_file_field
        } else {
          dataBox = newDataBox
          fileField = new_file_field
        }  
        e.preventDefault();
        $(this).css({'border': '2px dashed $dark-gray', 'opacity': '1.0'});
        const files = e.dataTransfer.files;
        postsPreview(files, action, dataBox, fileField);
      });
    });
  });
});
