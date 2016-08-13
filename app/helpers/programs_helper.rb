module ProgramsHelper

  def workout_template_selection(f, v = {'id' => 1})
    f.fields_for :workout_templates do |ff|
      ff.collection_select(:id, WorkoutTemplate.all, :id, :name, {:selected => v['id']})
    end
  end

  def remove_workout_button(f)
    if @program.workout_templates.any?
      if @templates.nil? || !@templates.empty?
        f.submit 'Remove Workout', name: 'remove_workout'
      end
    end
  end

end
