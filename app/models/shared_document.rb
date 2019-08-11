class SharedDocument < ApplicationRecord
  has_paper_trail

  belongs_to :user
  belongs_to :appointment

  mount_uploader :file, DocumentUploader
end
