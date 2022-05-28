class Post < ApplicationRecord
  # basic validations
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction) }  #also ['Fiction', 'Non-Fiction']

  # custom validation
  validate :is_title_clickbaity

  CLICKBAIT_PATTERNS = [  #regex, looking for these specific patterns in input data
    /Won't Believe/i,
    /Secret/i,
    /Top \d/i,
    /Guess/i
  ]

  def is_title_clickbaity
    if CLICKBAIT_PATTERNS.none? { |pat| pat.match title }  #validator; Returns true if no element meets a specified criterion; false otherwise. => error handling.
      errors.add(:title, "must be clickbait") #add method; attribute + message
    end
  end
end
