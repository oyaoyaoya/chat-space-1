require 'rails_helper'

describe Message do
  describe '#create' do

    it "is invalid without text" do
      message = build(:message, text: "")
      message.valid?
      expect(message.errors[:text]).to include("を入力してください")
    end

    it "is valid with text" do
      message = build(:message)
      expect(message).to be_valid
    end

    it "should have 5 messages in ASC order" do
      user     = create(:user)
      group    = create(:group)
      messages = create_list(:message, 5)
      expect(Message.all).to match(messages.sort{|a, b| a.created_at <=> b.created_at })
    end

  end
end
