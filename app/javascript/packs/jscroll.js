$(document).on('turbolinks:load', function(){
  $(function(){
    const windowSize = $(window).width();
    if (windowSize < 576) {
      function jscrollOption(jscrollId){
        const Option = {
          loadingHtml: '<div class="d-flex justify-content-center"><div class="spinner-border text-secondary" role="status"><span class="sr-only">Loading...</span></div></div>',
          autoTrigger: true,
          padding: 100,
          nextSelector: 'a[rel=next]',
          contentSelector: `#${jscrollId}`,
          pagingSelector: '.pagination',
          callback: function(){
            if (jscrollId !== 'item-list') $(this).children().addClass('show');
            $('.pagination').hide();
          }
        };
        $(`#${jscrollId}`).jscroll(Option);
      }

      // タイムラインの表示に jscroll を使用
      jscrollOption('jscroll-timeline');
      // マイアイテムの表示に jscroll を使用
      jscrollOption('item-list');
      // ユーザーページアクセス時にアクティブ状態のタブに jscroll を設定
      jscrollOption('list-posts');

      // タブ切り替え表示の際にアクティブ状態のタブに jscroll を設定
      $('a[data-toggle="list"]').on('shown.bs.tab', function (e) {
        const jscrollId = e.target.dataset.tab;
        jscrollOption(jscrollId);
      });
    }
  });
});