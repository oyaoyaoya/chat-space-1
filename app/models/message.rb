class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user
  default_scope -> {order('created_at ASC')}
  validates_presence_of :text
end
