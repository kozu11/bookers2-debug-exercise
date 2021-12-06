class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy
	has_many :favorited_users, through: :favorites, source: :user
	has_many :view_counts, dependent: :destroy
	
	is_impressionable counter_cache: true
	
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
	
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
	
	def Book.search(search, model, method)
		if method == "partical"
			Book.where('title LIKE(?)', "%#{search}%")
		elsif method == "backward"
			Book.where('title LIKE(?)', "%#{search}")
		elsif method == "forward"
			Book.where('title LIKE(?)', "#{search}%")
		elsif method == "perfect"
			Book.where(title: search)
		end
	end
end
