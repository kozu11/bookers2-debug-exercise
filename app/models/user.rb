class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorited_books, through: :favorites, source: :book
  
  has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  
  attachment :profile_image, destroy: false

  validates :name, presence: true, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}



  def is_followed_by(user)
    reverse_of_relationships.where(follower_id: user.id).exists?
  end
  
  def User.search(search, model, method)
    if method == "partical"
      User.where('name LIKE ?', "%#{search}%")
    elsif method == "backward"
      User.where('name LIKE ?', "%#{search}")
    elsif method == "forward"
      User.where('name LIKE ?', "#{search}%")
    elsif method == "perfect"
      User.where(name: search)
    end
  end
end
