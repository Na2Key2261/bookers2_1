class User < ApplicationRecord
  # デフォルトの Devise モジュールを含む。他にも以下が利用可能:
  # :confirmable, :lockable, :timeoutable, :trackable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books    # ユーザーは複数の本を持つ可能性があるため、has_many を使用
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true

  def get_profile_image
    profile_image.attached? ? profile_image : 'no_image.jpg'
  end
end