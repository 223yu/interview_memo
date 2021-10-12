$(document).on('turbolinks:load', function() {
  // 新規登録アイコンをクリックした時、answers#createに送る
  $(document).on('click', '.question__td--create', function(e){
    const answer_body = initial_setting_and_return_answer_body(e, $(this));
    const question_id = $(this).parent().attr('class').substr(13);

    $.ajax({
      url: '/answers',
      type: 'POST',
      data: { question_id: question_id, answer_body: answer_body},
      dataType: 'script'
    });
  });

  // 更新アイコンをクリックした時、answers#updateに送る
  $(document).on('click', '.question__td--update', function(e){
    const answer_body = initial_setting_and_return_answer_body(e, $(this));
    const answer_id = $(this).parent().attr('class').substr(13);

    $.ajax({
      url: '/answers/' + answer_id,
      type: 'PATCH',
      data: { body: answer_body },
      dataType: 'script'
    });
  });

  // 削除アイコンをクリックした時、answers#destroyに送る
  $(document).on('click', '.question__td--destroy', function(e){
    initial_setting_and_return_answer_body(e, $(this));
    const answer_id = $(this).parent().attr('class').substr(13);
    // 確認ダイアログ表示後、削除を実行する
    if(confirm('本当に削除してよろしいですか？')){
      $.ajax({
        url: '/answers/' + answer_id,
        type: 'DELETE',
        dataType: 'script'
      });
    }else{
      return false;
    }
  });

  // 共通setupを行う
  function initial_setting_and_return_answer_body(e, selector){
    // 本来のaタグの効果を無効化
    e.preventDefault();
    const tr = selector.parent();
    const answer_body = tr.find('input[type="text"]').val();
    const token = document.getElementsByName('csrf-token')[0].content;

    $.ajaxSetup({
      headers: {
        "X-CSRF-Token": token
      }
    });
    return answer_body;
  }

  // 「ランダムに出題」ボタンをクリックした時、answers#randomに送る
  const target = ['.question__random-btn', '.question__random-btn--next'];
  target.forEach(function(target){
    $(document).on('click', target,function(e){
      // 本来のaタグの効果を無効化
      e.preventDefault();

      const answer_ids = [];
      $('.question__tbody').children(('tr')).each(function(){
        answer_ids.push(Number($(this).attr('class').substr(13)))
      });
      $.ajax({
        url: '/answers/random',
        type: 'GET',
        data: { answer_ids: answer_ids},
        dataType: 'script'
      });
    });
  });

  // 「ランダムに出題」画面にて、回答を表示ボタンをクリックした時
  $(document).on('click', '.question__random-btn--left', function(e){
    // 本来のaタグの効果を無効化
    e.preventDefault();

    $('.question__random-answer-field').css('display', 'block');
  });
});