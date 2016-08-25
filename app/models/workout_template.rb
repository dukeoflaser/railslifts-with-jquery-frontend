class WorkoutTemplate < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_and_belongs_to_many :programs
  has_and_belongs_to_many :exercise_templates

  accepts_nested_attributes_for :exercise_templates

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  def exercise_templates_attributes=(attributes)
    attributes.each do |k, v|
      # if ExerciseTemplate.new(v).valid?
        unless ExerciseTemplate.exists?(name: v[:name])
          ExerciseTemplate.create_default(v[:name])
        end

        self.exercise_templates << ExerciseTemplate.create(v)
      # end

    end
  end

end
