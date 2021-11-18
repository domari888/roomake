$(document).on('turbolinks:load', function () {
  $(function(){
    let editDataBox = new DataTransfer();
    let edit_file_field = document.querySelector('input[data-action=edit]');
    let newDataBox = new DataTransfer();
    let new_file_field = document.querySelector('input[data-action=new]');
    $('#new-button').prop('disabled', true);
    // 画像選択時にプレビューを表示
    $('.post-preview-image').on("change", function(){
      let dataBox, fileField
      const action = $(this).data('action');
      if (action === "edit") {
        dataBox = editDataBox
        fileField = edit_file_field
      } else {
        dataBox = newDataBox
        fileField = new_file_field
      }
        // 選択をキャンセルした場合の処理
      if ($(this).val() === "") {
        $('.preview-item').remove();
        fileField.files = dataBox.files
        dataBox.clearData();
      }
      const files = $('input[type="file"]').prop('files')[0];
      $.each(this.files, function(i, file){
        const fileReader = new FileReader();
        const lastFileId = dataBox.files.length === 0 ? 0 : $(dataBox.files).last()[0].id;
        file.id = lastFileId + 1;
        dataBox.items.add(file);
        fileField.files = dataBox.files
        fileReader.readAsDataURL(file);
        fileReader.onloadend = function() {
          const html = `<div class="preview-item" data-id="${file.id}">
                        <img src="${fileReader.result}" class="preview-image">
                        <button type="button" class="btn btn-dark btn-sm rounded-circle delete-preview" data-action="${action}"><i class="fas fa-times"></i></button>
                      </div>`;
          $(`#${action}-drop`).before($(html));
          const previewItemLength = $(`#${action}-drop`).prevAll('.preview-item').length;
          if ( previewItemLength >= 1 && previewItemLength <= 6 ) $(`#${action}-button`).prop('disabled', false);
          if ( previewItemLength >= 6 ){
            $(`#${action}-drop`).hide();
            if ( previewItemLength === 7 ){
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
      const action = $(this).data('action');
      if (action === "edit") {
        dataBox = editDataBox
        fileField = edit_file_field
      } else {
        dataBox = newDataBox
        fileField = new_file_field
      }
      const targetImage = $(this).parents('.preview-item');
      const targetId = $(targetImage).data('id');
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
      const previewItemLength = $(`#${action}-drop`).prevAll('.preview-item').length;
      if ( previewItemLength <= 6 ){
        $(`#${action}-button`).prop('disabled', false);
        if ( previewItemLength <= 5 ){
          $(`#${action}-drop`).show();
          if ( previewItemLength === 0 ){
            $(`#${action}-button`).prop('disabled', true);
          }
        }
      }
    });

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
        $(this).css({'border': '2px solid #9e9e9e', 'opacity': '0.5'});
      },false);
      //ドロップエリアから離れた時に発火するイベント
      dropArea.addEventListener("dragleave", function(e){
        e.preventDefault();
        $(this).css({'border': '2px dashed #9c9c9c', 'background': '#f7f7f7', 'opacity': '1.0'});
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
        $(this).css({'border': '2px dashed #9c9c9c', 'background': '#f7f7f7', 'opacity': '1.0'});
        const files = e.dataTransfer.files;
        $.each(files, function(i, file){
          const fileReader = new FileReader();
          const lastFileId = dataBox.files.length === 0 ? 0 : $(dataBox.files).last()[0].id;
          file.id = lastFileId + 1;
          dataBox.items.add(file)
          fileField.files = dataBox.files
          fileReader.readAsDataURL(file);
          fileReader.onloadend = function() {
            const html = `<div class="preview-item" data-id="${file.id}">
                        <img src="${fileReader.result}" class="preview-image">
                        <button type="button" class="btn btn-dark btn-sm rounded-circle delete-preview" data-action="${action}"><i class="fas fa-times"></i></button>
                      </div>`;
            $(`#${action}-drop`).before($(html));
            const previewItemLength = $(`#${action}-drop`).prevAll('.preview-item').length;
            if ( previewItemLength >= 1 && previewItemLength <= 6){
              $(`#${action}-button`).prop('disabled', false);
                if ( previewItemLength >= 6 ){
                $(`#${action}-drop`).hide();
                if ( previewItemLength === 7 ){
                  $(`#${action}-button`).prop('disabled', true);
                  alert('画像は最大 6枚 にしてください');
                }
              }
            }
          };
        });
      });
    });
  });
});
