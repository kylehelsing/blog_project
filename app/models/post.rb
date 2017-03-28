class Post < ActiveRecord::Base
  after_commit :process_tags, on: :create
  after_commit :update_tags, on: :update
  belongs_to :user
  has_many :comments
  has_many :post_tags
  has_many :tags, through: :post_tags
  attr_accessor :tag

  def process_tags
    tags = []
    tagsplit = tag.downcase.split(/\s*,\s*/)
    tagsplit.each do |i|
      if Tag.where(name: i).empty?
        tags << Tag.create!(name: i)
      else
        tags << Tag.find_by_name(i)
      end
    end
    tags.each do |t|
      PostTag.create!(tag: t, post: self)
    end
  end

  def update_tags
    tags = []
    tagsplit = tag.downcase.split(/\s*,\s*/)
    tagsplit.each do |i|
      if Tag.where(name: i).empty?
        Tag.create!(name: i)
        PostTag.create!(tag: t, post: self)
      end
    #all_post_tags = tags.pluck(:name)

    end
  end

end
