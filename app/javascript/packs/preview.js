$(document).on('turbolinks:load', function(){
    $(function(){
        const dataBox = new DataTransfer();
        const fileField = document.querySelector('input[id=user_avatar]');
        // 【プロフィール画像プレビュー】
        $('.avatar-image-field').on('change', function(){
            if ($(this).val() !== "") {
                const avatar = $(this).prop('files')[0];
                const fileReader = new FileReader();
                if ($('.avatar-preview').length ) {
                    dataBox.clearData();
                    $('.avatar-preview, .delete-preview').remove();
                }
                dataBox.items.add(avatar)
                fileField.files = dataBox.files
                fileReader.onloadend = function(){
                    const avatarPreview = `<img src="${fileReader.result}" class="rounded-circle avatar-preview bg-light">`;
                    const deleteButton = '<button type="button" class="btn btn-dark btn-sm rounded-circle delete-preview"><i class="fas fa-times"></i></button>';
                    $('.avatar-label').prepend(avatarPreview).after(deleteButton);
                };
                fileReader.readAsDataURL(avatar);
            } else {
                fileField.files = dataBox.files
            }
        });
        // 【プロフィール画像削除】
        $('.avatar-container').on('click', '.delete-preview', function(){
            if($('.avatar-image-field').val()){
                dataBox.clearData();
                fileField.files = dataBox.files
            } else {
                $('.avatar-label').prepend('<input type="hidden" name="user[avatar]" value="">');
            }
            $('.avatar-preview, .delete-preview').remove();
        });
    });
});
