class Tag < ApplicationRecord
  TAG_REGEX = /#[\wа-яё]+/.freeze

  has_many :tag_questions
  has_many :questions, through: :tag_questions

  before_validation { name&.downcase! }

  validates :name, presence: true

  scope :with_questions, -> { joins(:questions).distinct.order(:name) }
end
