class Post < ActiveRecord::Base
  after_commit :process_tags, on: :create
  belongs_to :user
  has_many :comments
  has_many :post_tags
  attr_accessor :tag

  def process_tags
    tagsplit = tag.downcase.split(/\s*,\s*/)
    tagsplit.each do |word|
      if word
    end
    #create any tags that dont exist
    #create links
  end
end
