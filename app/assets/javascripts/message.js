$(function() {

  // viewに差し込むhtmlを作成する関数
  function buildChatbox(data) {
    var html =   `
      <div class="chatbox", data_messageid= ${data.id}>
        <div class="chatbox__data">
          <span class="chatbox__data__name">
            ${data.name}
          </span>
          <span class="chatbox__data__date">
            ${data.created_at}
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
  $('.chatArea').append(html);
  };

  // 非同期通信でメッセージを投稿する関数
  function postMessage(text) {
    $.ajax({
      type: 'POST',
       url:  $('#new_message').attr('action'),
  dataType: 'json',
      data: {
      message: {
         text: text,
        }
      }
    })
      .done(function(data) {
        buildChatbox(data);
        $('.inputbox__message').val('');
      })
      .fail(function(){
        $('body').prepend('<p class="flashbox--color-red">テキストを入力してください</p>');
      });
  }

  // 非同期通信でメッセージを更新する関数
  function renewMessage() {
    $.ajax({
      type: 'GET',
       url:  $('#new_message').attr('action')
     })
      .done(function(data) {
        if (data.messages.length) {
          // まだ表示されていないメッセージのみを取得する処理
          newMessage = data.messages.filter(function(message) {
            if ( message.id > $('.chatbox:last').attr('data_messageid') ) {
              return true;
            } else if ($('.chatbox:last').length == 0) {
              return true;
            } else {
              return false;
            }
          });
          $.each(newMessage,function(i,message) {
              buildChatbox(message);
          });
        }
    })
      .fail(function(){
        $('body').prepend('<p class="flashbox--color-red">更新に失敗しました</p>');
      });
  }


  // Sendで発火し、入力したメッセージを取得後postMessageを実行
  $('#new_message').on('submit', function(e) {
    e.preventDefault();
    var inputChat = $('.inputbox__message').val();
    postMessage(inputChat);
  });

  // チャットページが表示されている際、5秒ごとにrenewMessageを実行
  if ( $('.inputArea').length ) {
    setInterval(renewMessage(),5000);
  }

});

