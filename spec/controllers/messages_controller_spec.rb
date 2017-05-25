require 'rails_helper'
describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:group) {user.groups.first}


  describe 'GET #index' do
    context "ユーザーがログインしている場合" do
      before do
        login_user user
        get :index, params: { group_id: group }
      end

      it "@groupsにユーザーが属しているグプープを割り当てること" do
        groups = user.groups
        expect(assigns(:groups)).to match(groups)
      end

      it "@groupに表示したいグループを割り当てること" do
        expect(assigns(:group)).to eq group
      end

      it "@messageに新規メッセージが割り当てられていること" do
        message = Message.new
        expect(assigns(:message)).to be_a_new(Message)
      end

      it "@messagesにグループ内でのメッセージを割り当てること" do
        messages = group.messages
        expect(assigns(:messages)).to match(messages.sort{ |a, b| a.created_at <=> b.created_at })
      end

      it "indexテンプレートを表示すること" do
        expect(response).to render_template :index
      end

    end
    context "ユーザーがログインしていない場合" do
      it "ログインページにリダイレクトされること" do
        get :index, params: {group_id: group}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end


end
