$(function() {


  // インクリメンタルサーチによる候補欄のhtml生成と追加を行う関数
  function AppendUsers(id,name) {
    var html = `
      <div class="chat-group-user user__id-${id}">
        <div class="chat-group-user__name">
          ${name}
        </div>
        <div class="chat-group-user__btn">
          <span class="chat-group-user__btn--add", data_userid= ${id}>
            追加
          </span>
        </div>
      </div>
    `;
    $('.chat-group-form__search').append(html);
  };

  // 追加ボタンの押されたユーザーをチャットメンバーの欄へ移動する関数
  function MoveSelectedUser(id) {
    $('.choiced ').append($(`.chat-group-form__search .user__id-${id}`));
    $(`.choiced .user__id-${id} .chat-group-user__btn`).html(`<span class="chat-group-user__btn--remove", data_userid= ${id}>削除</span>`);
    $(`.choiced .user__id-${id}`).append(`<input type="hidden" name="group[user_ids][]" value= ${id} >`);
    $(`.chat-group-form__search .user__id-${id}`).remove();
  };

  // 削除ボタンを押されたユーザーをチャットメンバー欄から削除する関数
  function RemoveSelectedUser(id) {
    $(`.choiced .user__id-${id}`).remove();
  };

  // 編集ページで、もともと属していたユーザーの削除ボタンが押された場合
  $('.choiced .chat-group-user__btn--remove').on('click', function() {
    RemoveSelectedUser( $(this).attr('data_userid') );
  });

  // ajaxを用いたインクリメンタルサーチによるユーザーの検索
  $('.chat-group-form__search .chat-group-form__input').on('keyup', function() {
    $.ajax({
      type: 'POST',
      url : '/groups/search' ,
      dataType: 'json',
      data: {
        input: $(this).val()
      }
    })
    .done(function(data) {
      $('.chat-group-form__search .chat-group-user').remove();
      if (data.user_info.length != 0){
        // data { user_info: [ [id1,name1],...,[ヒットしたユーザーのID,名前] ]}
        $.each(data.user_info,function(i,user){
          AppendUsers(user[0],user[1])
        });
        // 追加ボタンが押された場合
        $('.chat-group-form__search .chat-group-user__btn--add').on('click', function() {
          MoveSelectedUser( $(this).attr('data_userid') );
          //追加されたユーザーの削除ボタンが押された場合
          $('.choiced .chat-group-user__btn--remove').on('click', function(){
            RemoveSelectedUser( $(this).attr('data_userid') );
          });
        });
      }
    })
    .fail(function() {
      $('body').prepend('<p class="flashbox--color-red">検索に失敗しました</p>');
    });
  });


});
