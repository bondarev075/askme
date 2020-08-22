class Question < ApplicationRecord
  belongs_to :user

  validates :text, presence: true
  validates :text, length: { maximum: 255 }

  scope :sorted_desc, -> { order(created_at: :desc) }
  scope :with_answers, -> { where.not(answer: nil) }

  def author
    User.find(author_id)
  end
end
