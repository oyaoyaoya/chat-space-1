$(function() {
  // viewに差し込むhtmlを作成する関数
  function buildChatbox(data) {
    var html =   `
      <div class="chatbox">
        <div class="chatbox__data">
          <span class="chatbox__data__name">
            ${data.name}
          </span>
          <span class="chatbox__data__date">
            ${data.day}
          </span>
        <div class="chatbox__gap">
        </div>
        <div class="chatbox__chat">
          <span class="chatbox__message">
            ${data.text}
          </span>
        </div>
      </div>
    `;
  return html;
  };
  // Sendで発火し、入力したメッセージを取得して非同期通信を行う
  $('#new_message').on('submit', function(e) {
    e.preventDefault();
    var inputChat = $('.inputbox__message').val();

    $.ajax({
      type: 'POST',
       url:  $('#new_message').attr('action'),
  dataType: 'json',
      data: {
      message: {
         text: inputChat,
        }
    }})
      // チャットメッセージを差し込む
      .done(function(data) {
        $('.chatArea').append(buildChatbox(data));
        $('.inputbox__message').val('');
      })
      // エラーメッセージの表示
      .fail(function(){
        $('body').prepend('<p class="flashbox--color-red">テキストを入力してください</p>');
      });
    });

});

