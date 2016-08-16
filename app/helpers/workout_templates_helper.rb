module WorkoutTemplatesHelper

  def remove_exercise_button(f)
    if @workout_template.exercise_templates.any?
      if @templates.nil? || !@templates.empty?
        f.submit 'Remove Exercise', name: 'remove_exercise'
      end
    end
  end

  def id_to_attributes(v)
    attributes = {}
    template = ExerciseTemplate.find(v[:id])
    attributes[:name] = template.name
    attributes[:reps] = template.reps
    attributes[:starting_weight] = template.starting_weight
    attributes[:rest] = template.rest
    attributes
  end

end
