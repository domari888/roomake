document.addEventListener('turbolinks:load', () => {
  let textarea = document.getElementById('comment-area');
  textarea.addEventListener('input', ()=>{
      textarea.style.height = 'auto';
      textarea.style.height = textarea.scrollHeight + 'px';
  });
})