$(document).on('turbolinks:load', function () {
  $(function(){
    //DataTransferオブジェクトで、データを格納する箱を作る
    let dataBox = new DataTransfer();
    //querySelectorでfile_fieldを取得
    let file_field = document.querySelector('input[type=file]')
    //file_field の値が変更されたときに発火するイベント
    $('#post-preview-image').on("change", function(){
      
      // 選択をキャンセルした場合の処理
      if ($(this).val() === "") {
        $('.preview-item').remove();
        file_field.files = dataBox.files
        dataBox.clearData();
      }
      
      // 選択したfileのオブジェクトをpropで取得
      let files = $('input[type="file"]').prop('files')[0];
      $.each(this.files, function(i, file){
        let fileReader = new FileReader();
        // 選択したfileのオブジェクトにidを付与
        let lastFileId = dataBox.files.length === 0 ? 0 : $(dataBox.files).last()[0].id;
        file.id = lastFileId + 1;
        // DataTransferオブジェクトに対して、fileを追加
        dataBox.items.add(file)
        // DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に代入
        file_field.files = dataBox.files

        fileReader.readAsDataURL(file);

        // 画像が6枚以上になった場合、input を非表示
        let previewItemLength = $('.preview-item').length + i +1;
        if ( previewItemLength >= 6 ){
          $('#drop-container').hide();
          if ( previewItemLength == 7 ){
            $('#new-button').prop('disabled', true);
            alert('画像は最大 6枚 にしてください');
          }
        }

        // 読み込んだ URL を src に格納して プレビューの HTML を作成
        fileReader.onloadend = function() {
          let html = `<div class="preview-item" data-id="${file.id}">
                        <img src="${fileReader.result}" class="preview-image">
                        <button type="button" class="btn btn-dark btn-sm rounded-circle delete-preview"><i class="fas fa-times"></i></button>
                      </div>`;
          $('#drop-container').before($(html));
        };
      });
    });

    // プレビューの削除ボタンをクリックしたとき、発火するイベント
    $(document).on("click", '.delete-preview', function(){
      let targetImage = $(this).parents('.preview-item');
      let targetId = $(targetImage).data('id');
      $.each(file_field.files, function(i, file){
        if( file.id === targetId ){
          dataBox.items.remove(i);
          return false;
        }
      })
      file_field.files = dataBox.files;
      targetImage.remove();
      // 削除後の画像の枚数によって form の表示を変更
      if ( file_field.files.length <= 6 ){
        $('#new-button').prop('disabled', false);
        if ( file_field.files.length <= 5 ){
          $('#drop-container').show();
        }
      }
    });

    let dropArea = document.getElementById('drop-container');
    //ドロップエリアの上にある時に発火するイベント
    dropArea.addEventListener("dragover", function(e){
      e.preventDefault();
      $(this).css({'border': '2px solid #9e9e9e', 'opacity': '0.5'});
    },false);
    //ドロップエリアから離れた時に発火するイベント
    dropArea.addEventListener("dragleave", function(e){
      e.preventDefault();
      $(this).css({'border': '2px dashed #9c9c9c', 'background': '#f7f7f7'});
    },false);
    // ドロップしたときに発火するイベント
    dropArea.addEventListener("drop", function(e) {
      e.preventDefault();
      $(this).css({'border': '2px dashed #9c9c9c', 'background': '#f7f7f7'});
      var files = e.dataTransfer.files;
      $.each(files, function(i, file){
        let fileReader = new FileReader();
        let lastFileId = dataBox.files.length === 0 ? 0 : $(dataBox.files).last()[0].id;
        file.id = lastFileId + 1;
        dataBox.items.add(file)
        file_field.files = dataBox.files
        fileReader.readAsDataURL(file);
        // 画像が6枚以上になった場合、input を非表示
        let previewItemLength = $('.preview-item').length + i +1;
        if ( previewItemLength >= 6 ){
          $('#drop-container').hide();
          if ( previewItemLength == 7 ){
            $('#new-button').prop('disabled', true);
            alert('画像は最大 6枚 にしてください');
          }
        }
        // 読み込んだ URL を src に格納して プレビューの HTML を作成
        fileReader.onloadend = function() {
          let html = `<div class="preview-item" data-id="${file.id}">
                        <img src="${fileReader.result}" class="preview-image">
                        <button type="button" class="btn btn-dark btn-sm rounded-circle delete-preview"><i class="fas fa-times"></i></button>
                      </div>`;
          $('#drop-container').before($(html));
        };
      });
    });
  });
});
