$(function() {

  // インクリメンタルサーチによる候補欄のhtml生成と追加を行う関数
  function AppendUsers(name,id) {
    var html = `
      <div class="chat-group-user user__id-${id}">
        <div class="chat-group-user__name">
          ${name}
        </div>
        <div class="chat-group-user__btn">
          <span class="chat-group-user__btn--add", data-userid= ${id}>
            追加
          </span>
        </div>
      </div>
    `;
    $('.chat-group-form__search').append(html);
  };

  // 追加ボタンの押されたユーザーをチャットメンバーの欄へ移動する関数
  function MoveSelectedUser(tmp) {
    $('.choiced ').append($(`.chat-group-form__search .user__id-${tmp}`));
    $(`.choiced .user__id-${tmp} .chat-group-user__btn`).html(`<span class="chat-group-user__btn--remove", data-userid= ${tmp}>削除</span>`);
    $(`.choiced .user__id-${tmp}`).append(`<input type="hidden" name="group[user_ids][]" value= ${tmp} >`);
    $(`.chat-group-form__search .user__id-${tmp}`).remove();
  };

  // 削除ボタンを押されたユーザーをチャットメンバー欄から削除する関数
  function RemoveSelectedUser(tmp2) {
    $(`.user__id-${tmp2}`).remove();
  };

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
      if (data.length != 0){
        // 検索にヒットしたユーザーの情報が配列で返ってくるので取り出す
        $.each(data.user_info,function(i,user){
          AppendUsers(user[1],user[0])
        });
        // 追加ボタンが押された場合
        $('.chat-group-user__btn--add').on('click', function() {
          MoveSelectedUser( $(this).attr('data-userid') );
          // 削除ボタンが押された場合
            $('.chat-group-user__btn--remove').on('click', function() {
            RemoveSelectedUser( $(this).attr('data-userid') );
            });
        });
      }
    })
    .fail(function() {
      $('body').prepend('<p class="flashbox--color-red">検索に失敗しました</p>');
    });

  });
});
