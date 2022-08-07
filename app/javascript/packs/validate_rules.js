$(document).on('turbolinks:load', function(){
  $(function(){
    $('.modal').on('hidden.bs.modal', function(){
      $('div.error').remove();
    });
    $(".post-form").each(function(){
      $(this).validate({
        rules: {
          "post_form[content]": {
            required: true,
            maxlength: 2000
          },
          "post_form[tag_ids][]": {
            required: true,
            maxlength: 2
          },
          "post_form[category_ids][]": {
            required: true,
            maxlength: 2
          }
        },
        messages: {
          "post_form[content]": {
            required: '※ キャプションを入力してください',
            maxlength: '※ 2000文字以内で入力してください'
          },
          "post_form[tag_ids][]": {
            required: '※ タグを選択してください',
            maxlength: '※ タグは2つまで選択できます'
          },
          "post_form[category_ids][]": {
            required: '※ カテゴリーを選択してください',
            maxlength: '※ カテゴリは2つまで選択できます'
          }
        },
        errorElement: 'div',
        errorPlacement: function(error, element){
          error.insertAfter(element.closest('.form-group'));
        }
      });
    });
  });
});