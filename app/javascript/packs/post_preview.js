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
        $('#preview-box').children().remove();
        file_field.files = dataBox.files
        dataBox.clearData();
      }

      // 選択したfileのオブジェクトをpropで取得
      let files = $('input[type="file"]').prop('files')[0];
      $.each(this.files, function(i, file){
        let fileReader = new FileReader();
        
        // DataTransferオブジェクトに対して、fileを追加
        dataBox.items.add(file)
        // DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に代入
        file_field.files = dataBox.files

        fileReader.readAsDataURL(file);

        // 画像が6枚以上になった場合、input を非表示
        let preview_item_length = $('.preview-item').length + i +1;
        if ( preview_item_length >= 6 ){
          $('#post-preview-image').hide();
          if ( preview_item_length == 7 ){
            $('#new-button').prop('disabled', true);
            alert('画像は最大 6枚 にしてください');
          } 
        }

        // 読み込んだ URL を src に格納して プレビューの HTML を作成
        fileReader.onloadend = function() {
          let html = `<div class="preview-item" data-image="${file.name}">
                        <img src="${fileReader.result}" class="preview-image">
                      </div>`
          $('#preview-box').append($(html));
        };
      });
    });
  });
});
