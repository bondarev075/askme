class Question < ApplicationRecord
  has_many :tag_questions, dependent: :destroy
  has_many :tags, through: :tag_questions

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  after_commit :update_tags, on: [:create, :update]

  validates :text, presence: true
  validates :text, length: { maximum: 255 }

  scope :sorted_desc, -> { order(created_at: :desc) }
  scope :with_answers, -> { where.not(answer: nil) }

  def update_tags
    tag_questions.clear
    "#{text} #{answer}".downcase.scan(Tag::TAG_REGEX).uniq.each do |tag|
      tags << Tag.find_or_create_by(name: tag)
    end
  end
end
