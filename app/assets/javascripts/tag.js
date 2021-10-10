$(document).on('turbolinks:load', function() {
  // checkを変更したときにcontrollerにアクションを送る
  $(document).on('change', '.tag__check-box', function() {
    // checkを入れた時
    if($(this).prop('checked') == true){
      const tag_id = $(this).attr('id').substr(10)
      const token = document.getElementsByName('csrf-token')[0].content;
      $.ajaxSetup({
        headers: {
          "X-CSRF-Token": token
        }
      });
      $.ajax({
        url: '/tags/' + tag_id,
        type: 'PATCH',
        dataType: 'script'
      });
    }
  });
});