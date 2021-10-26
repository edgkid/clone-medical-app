class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  has_one_attached :image

  validates :content, presence: true, if: -> { image.blank? }
  validates :image, presence: true, if: -> { content.blank? }

  def image_url
    # if image.service.send(:service_name) != 'Disk'
    #   file.service_url
    # else
    #   ActiveStorage::Blob.service.send(:path_for, image.key)
    # end
    Rails.application.routes.url_helpers.rails_blob_url image, only_path: true if image.present?
  end
end