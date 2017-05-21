class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validates_presence_of :text
end
