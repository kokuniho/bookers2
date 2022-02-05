class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_one_attached :profile_image
  
   validates :name, length: {minimum: 2, maximum: 20}, presence: true, uniqueness: { case_sensitive: false }
   validates :introduction, length: {maximum: 50}


  def get_image
    if profile_image.attached?
       profile_image
    else
      'no_image.jpg'
    end
  end
  
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email:'guest@example.com')do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name ="guestuser"
    end
  end
end
