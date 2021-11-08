$(document).on('turbolinks:load', function(){
  $(function(){
    const windowSize = $(window).width();
    if (windowSize < 576) {
      const jscrollOption = {
        loadingHtml: '<div class="d-flex justify-content-center"><div class="spinner-border text-secondary" role="status"><span class="sr-only">Loading...</span></div></div>',
        autoTrigger: true,
        padding: 100,
        nextSelector: 'a[rel=next]',
        contentSelector: '.jscroll',
        pagingSelector: '.pagination',
        callback: function(){
          $('.pagination').hide();
        }
      };
      $('.jscroll').jscroll(jscrollOption);
    }
  });
});