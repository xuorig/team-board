class BoardItem < ActiveRecord::Base
	belongs_to :board
	acts_as_list :scope => [:board_id, :ui_column]
	belongs_to :owner, :class_name => "User"
	has_many :comments, :dependent => :destroy
end
