class Post < ActiveRecord::Base
  after_commit :process_tags, on: [:create, :update]
  belongs_to :user
  has_many :comments
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  attr_accessor :tag_string

  def process_tags
    tags_on_form = []
    tagsplit = tag_string.downcase.split(/\s*,\s*/)
    tagsplit.each do |i|
      t = Tag.new(name: i)
      if t.save
        tags_on_form << t
      else
        t = Tag.find_by_name(i)
        tags_on_form << t
      end
      PostTag.new(tag: t, post: self).save
    end
    if created_at+2.seconds < Time.now
      all_post_tags = tags.pluck(:name)
      tag_names_to_remove = all_post_tags - tags_on_form.map{|x| x.name}
      t = tags.where(name: tag_names_to_remove).pluck(:id)
      to_remove = post_tags.where(tag_id: t)
      to_remove.destroy_all
    end
  end

end
