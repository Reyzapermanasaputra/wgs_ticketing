class Document < ApplicationRecord
	mount_uploader :attachment, AttachmentUploader
	validates :title, :body, :attachment, presence: true
end
