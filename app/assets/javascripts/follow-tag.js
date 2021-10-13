$(document).on('turbolinks:load', function() {
  // checkを外した時、絞り込みを行う
  $(document).on('change', '.follow-tag', function(){
    const url = location.href;
    const follow_tag_ids = [];

    $('.follow-tag div').each(function(i,elem){
      if($(elem).children('input').prop('checked') == true){
        follow_tag_ids.push($(elem).children('input').attr('id').substr(10));
      }
    });

    $.ajax({
      url: url,
      type: 'GET',
      data: { follow_tag_ids: follow_tag_ids },
      dataType: 'script'
    })
    .done(function(){
      $('textarea').each(function(){
        $(this).height(this.scrollHeight);
      });
    });
  });
});