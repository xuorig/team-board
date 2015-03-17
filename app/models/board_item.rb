class BoardItem < ActiveRecord::Base
  validates :board, presence: true
  validates :position, presence: true

  belongs_to :board
  acts_as_list :scope => [:board_id, :ui_column]
  has_many :comments, :dependent => :destroy

  has_many :assignments, :dependent => :destroy
  has_many :assignees, :source => :user, :through => :assignments

end
