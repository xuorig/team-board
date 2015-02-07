class BoardItem < ActiveRecord::Base
	belongs_to :board
	belongs_to :owner, :class_name => "User"
	has_many :comments
end

class FileItem < BoardItem
	def content
end

class NoteItem < BoardItem
end
