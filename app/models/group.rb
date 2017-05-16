class Group < ApplicationRecord
  has_many :members
  has_many :users, through: :members, dependent: :destroy

  validates_presence_of :name
end
