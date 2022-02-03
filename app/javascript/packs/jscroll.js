$(document).on('turbolinks:load', function(){
  $(function(){
    const windowSize = $(window).width();
    if (windowSize < 576) {
      function jscrollOption(tabId){
        const Option = {
          loadingHtml: '<div class="d-flex justify-content-center"><div class="spinner-border text-secondary" role="status"><span class="sr-only">Loading...</span></div></div>',
          autoTrigger: true,
          padding: 100,
          nextSelector: 'a[rel=next]',
          contentSelector: `#${tabId}`,
          pagingSelector: '.pagination',
          callback: function(){
            $(this).children().addClass('show');
            $('.pagination').hide();
          }
        };
        $(`#${tabId}`).jscroll(Option);
      }

      // ユーザーページアクセス時にアクティブ状態のタブに jscroll を設定
        jscrollOption('list-posts');

      // タブ切り替え表示の際にアクティブ状態のタブに jscroll を設定
      $('a[data-toggle="list"]').on('shown.bs.tab', function (e) {
        const tabId = e.target.dataset.tab;
        jscrollOption(tabId);
      });
    }
  });
});