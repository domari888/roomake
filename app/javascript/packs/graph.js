$(document).on('turbolinks:load', function(){
  $(function(){
    function iconUpdate(collapseButton){
      if ($(collapseButton).hasClass('btn-outline-secondary')) {
        $(collapseButton).addClass('btn-secondary');
        $(collapseButton).removeClass('btn-outline-secondary');
        const icon = $(collapseButton).children();
        $(icon).removeClass('fa-plus');
        $(icon).addClass('fa-minus');
      } else {
        $(collapseButton).addClass('btn-outline-secondary');
        $(collapseButton).removeClass('btn-secondary');
        const icon = $(collapseButton).children();
        $(icon).removeClass('fa-minus');
        $(icon).addClass('fa-plus');
      }
    }
    const windowSize = $(window).width();
    // 画面サイズが lg 以上の場合
    if (windowSize >= 992 ) {
      $('.ranking-collapse').addClass('show');
      $('.collapse-btn').each(function(index, value){
        iconUpdate(value);
      });
    }
    // コラプスを開いた際の処理
    $('.ranking-collapse').on('show.bs.collapse', function(){
      const id = this.id;
      const collapseButton = $(`#collapse-${id}`);
      iconUpdate(collapseButton);
    })
    // コラプスを閉じた際の処理
    $('.ranking-collapse').on('hide.bs.collapse', function(){
      const id = this.id;
      const collapseButton = $(`#collapse-${id}`);
      iconUpdate(collapseButton);
    })
  })
});