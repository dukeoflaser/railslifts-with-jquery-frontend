module ProgramsHelper

  def workout_template_selection(f, v = {:id => 1})
    f.fields_for :workout_templates do |ff|
      ff.collection_select(:id, WorkoutTemplate.where('standin IS NULL'), :id, :name, {:selected => v[:id]})
    end
  end

  def remove_workout_button(f)
    if @program.workout_templates.any?
      if @templates.nil? || !@templates.empty?
        submit_tag 'Remove Workout', name: 'remove_workout', class: "btn btn-primary btn-sm"
      end
    end
  end

end
