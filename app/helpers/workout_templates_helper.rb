module WorkoutTemplatesHelper

  def exercise_template_creation(f, v)
    f.fields_for :exercise_templates do |ff|
      ff.text_field :name
      ff.text_field :reps, :placeholder => "Ex. 5 5 5"
      ff.number_field :starting_weight
      ff.number_field :rest
    end
  end

end
