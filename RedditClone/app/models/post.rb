# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  sub_id     :integer
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord
  validates :title, presence: true

  belongs_to :author,
    foreign_key: :author_id,
    class_name: :User

  # belongs_to :sub,
  #   foreign_key: :sub_id,
  #   class_name: :Sub

  has_many :post_subs,
    foreign_key: :post_id,
    class_name: :PostSub,
    dependent: :destroy,
    inverse_of: :post # Is this correct?

  has_many :subs,
    through: :post_subs,
    source: :sub
    # Automatically creates sub_ids array
    # Populates the join table
end
