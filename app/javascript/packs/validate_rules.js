$(document).on('turbolinks:load', function(){
  $(function(){
    $('.modal').on('hidden.bs.modal', function(){
      $('label.error').remove();
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
            required: '* 投稿内容を入力してください',
            maxlength: '* 2000文字以内で入力してください'
          },
          "post_form[tag_ids][]": {
            required: '* タグを選択してください',
            maxlength: '* 2つ以下で選択してください'
          },
          "post_form[category_ids][]": {
            required: '* カテゴリーを選択してください',
            maxlength: '* 2つ以下で選択してください'
          }
        },
        errorElement: 'div',
        errorPlacement: function(error, element){
          if(element.attr('name') === 'post_form[tag_ids][]'){
            error.insertAfter(element.parents('.tag-group'));
          } else if(element.attr('name') === 'post_form[category_ids][]'){
            error.insertAfter(element.parents('.category-group'));
          } else {
            error.insertAfter(element);
          }
        }
      });
    });
  });
});