class ExerciseTemplate < ActiveRecord::Base
  has_and_belongs_to_many :workout_templates

  include ExerciseValidator

  validates :name, presence: true
  validates :reps, presence: true
  validate :reps_format
  validates :weight, presence: true
  validates :rest, presence: true


  

  def self.create_default(name)
    default_template = ExerciseTemplate.create({
      name: name,
      reps: "5 5 5",
      weight: 0,
      rest: 90,
      default: true
    })

    default_template
  end

  def self.default_exercise_templates
    ExerciseTemplate.where({'default' => true})
  end

  def sets
    self.reps.split(' ').length
  end
end
