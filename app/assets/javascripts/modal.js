$(document).on('turbolinks:load', function() {
  // 閉じるイベントのみ記述（開くイベントはコントローラを通す
  const target = ['.modal__close-btn', '.modal__background'];
  target.forEach(function(target){
    $(document).on('click', target, function(){
      $('.modal__area').fadeOut();
      $('.modal__close-btn').fadeOut();
      $('.modal__open-btn').fadeIn();
      return false;
    });
  });
});