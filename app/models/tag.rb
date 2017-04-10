class Tag < ActiveRecord::Base
  has_many :post_tags, dependent: :destroy
  validates :name, uniqueness: true
  has_many :posts, through: :post_tags

end
