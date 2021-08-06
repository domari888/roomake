document.addEventListener('turbolinks:load', () => {
    const previewImage = document.querySelector('.previewImage');
    previewImage.addEventListener('change', (e) => {
        const fileReader = new FileReader();
        fileReader.onload = (function() {
        document.getElementById('preview').src = fileReader.result;
    });
    fileReader.readAsDataURL(e.target.files[0]);
    });
})