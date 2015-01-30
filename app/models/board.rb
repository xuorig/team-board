class Board < ActiveRecord::Base
	belongs_to :project
	belongs_to :owner
end
