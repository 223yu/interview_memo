$(document).on('turbolinks:load', function() {
  // checkを変更したときにcontrollerにアクションを送る
  $(document).on('change', '.tag__check-box', function() {
    const checked = $(this).prop('checked');
    const tag_id = $(this).attr('id').substr(10)
    const token = document.getElementsByName('csrf-token')[0].content;
    $.ajaxSetup({
      headers: {
        "X-CSRF-Token": token
      }
    });
    // checkを入れた時
    if(checked == true){
      $.ajax({
        url: '/tags/' + tag_id,
        type: 'PATCH',
        dataType: 'script'
      });
    // checkを外した時
    }else if(checked == false){
      $.ajax({
        url: '/tags/' + tag_id,
        type: 'DELETE',
        dataType: 'script'
      });
    }
  });
});