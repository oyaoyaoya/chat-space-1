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


  describe 'POST #create' do
    context "ユーザーがログインしている場合" do
      before do
        login_user user
      end
      context "正常に保存できる時" do
        subject {
          Proc.new { post :create, params: {group_id: group, message: attributes_for(:message)} }
        }
        it "パラメーターで送られててきたデータが保存できること" do
          expect{
            subject.call
          }.to change(Message, :count).by(1)
        end

        it "投稿ページにリダイレクトされること" do
          subject.call
          expect(response).to redirect_to group_messages_path(group)
        end

      end
      context "正常に保存できない時" do
        subject {
          Proc.new { post :create, params: {group_id: group, message: attributes_for(:message).merge(text: "")} }
        }
        it "パラメーターで送られてきたデータが保存されないこと" do
          expect{
            subject.call
          }.to change(Message, :count).by(0)
        end

        it "投稿ページにリダイレクトされること" do
          subject.call
          expect(response).to redirect_to group_messages_path(group)
        end

        it "リダイレクトされた時にフラッシュメッセージを表示すること" do
          subject.call
          expect(flash[:alert]).to eq("テキストを入力してください")
        end
      end
    end
    context "ユーザーがログインしていない場合" do
      it "ログインページにリダイレクトされること" do
         post :create, params: {group_id: group, message: attributes_for(:message)}
         expect(response).to redirect_to new_user_session_path
      end
    end
  end


end
