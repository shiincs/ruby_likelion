class Movie < ApplicationRecord
    # :어떤칼럼, #어떤업로더(업로더이름+Uploader)
    mount_uploader :image_path, ImageUploader
    # belongs_to :user
    has_many :likes
    has_many :users, through: :likes
    has_many :comments
end
