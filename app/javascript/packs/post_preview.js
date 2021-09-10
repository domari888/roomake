$(document).on('turbolinks:load', function () {
  $(function(){
    //DataTransferオブジェクトで、データを格納する箱を作る
    var dataBox = new DataTransfer();
    //querySelectorでfile_fieldを取得
    var file_field = document.querySelector('input[type=file]')
    //file_field の値が変更されたときに発火するイベント
    $('#post-preview-image').on("change", function(){

      // 選択をキャンセルした場合の処理
      if ($(this).val() === "") {
        $('#preview-box').children().remove();
        file_field.files = dataBox.files
        dataBox.clearData();
      }

      // 選択したfileのオブジェクトをpropで取得
      var files = $('input[type="file"]').prop('files')[0];
      $.each(this.files, function(i, file){
        var fileReader = new FileReader();
        
        // DataTransferオブジェクトに対して、fileを追加
        dataBox.items.add(file)
        // DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に代入
        file_field.files = dataBox.files
        
        fileReader.readAsDataURL(file);
        // 読み込んだ URL を src に格納して プレビューの HTML を作成
        fileReader.onloadend = function() {
          var html = `<div class="preview-item" data-image="${file.name}">
                        <img src="${fileReader.result}" class="preview-image">
                        <button type="button" class="btn btn-dark btn-sm delete-preview rounded-circle"><i class="fas fa-times"></i></button>
                      </div>`
          $('#preview-box').append($(html));
        };
      });

      // プレビューの削除ボタンをクリックしたとき、発火するイベント
      $(document).on("click", '.delete-preview', function(){
        let target_preview = $(this).parents('.preview-item')
        let target_image = $(target_preview).data('image')
        $.each(file_field.files, function(i, file){
          if( file.name === target_image ){
            dataBox.items.remove(i)
          }
        });
        target_preview.remove();
        file_field.files = dataBox.files
      })
    });
  });
});
