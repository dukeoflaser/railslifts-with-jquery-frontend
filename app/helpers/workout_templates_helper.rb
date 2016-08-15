module WorkoutTemplatesHelper

  def remove_exercise_button(f)
    if @workout_template.exercise_templates.any?
      if @templates.nil? || !@templates.empty?
        f.submit 'Remove Exercise', name: 'remove_exercise'
      end
    end
  end

end
