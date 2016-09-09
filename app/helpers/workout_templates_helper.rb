module WorkoutTemplatesHelper

  def remove_exercise_button(f)
    if @workout_template.exercise_templates.any?
      if @templates.nil? || !@templates.empty?
        submit_tag 'Remove Exercise', name: 'remove_exercise', class: "btn btn-primary btn-sm"
      end
    end
  end

end
