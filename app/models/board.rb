class Board < ActiveRecord::Base
  validates :owner, presence: true
  validates :project, presence: true

  belongs_to :project
  belongs_to :owner, :class_name => "User"
  has_many :items, :class_name => "BoardItem" 
end
