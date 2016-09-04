class Exercise < ActiveRecord::Base
  belongs_to :workout

  include ExerciseValidator
  validates :name, presence: true
  validates :reps, presence: true
  validate :reps_format
  validates :weight, presence: true
  validates :rest, presence: true

  def sets
    self.reps.split(' ').length
  end

end
