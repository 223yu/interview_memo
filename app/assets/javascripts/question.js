$(document).on('turbolinks:load', function() {
  // saveアイコンをクリックした時、answers#createに送る
  $(document).on('click', '.question__td--btn', function(e){
    // 本来のaタグの効果を無効化
    e.preventDefault();

    const tr = $(this).parent();
    const answer_body = tr.find('input[type="text"]').val();
    const question_id = tr.attr('class').substr(13);
    const token = document.getElementsByName('csrf-token')[0].content;

    $.ajaxSetup({
      headers: {
        "X-CSRF-Token": token
      }
    });

    $.ajax({
      url: '/answers',
      type: 'POST',
      data: { question_id: question_id, answer_body: answer_body},
      dataType: 'script'
    });
  });
});