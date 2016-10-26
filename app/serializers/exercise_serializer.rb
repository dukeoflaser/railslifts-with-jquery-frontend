class ExerciseSerializer < ActiveModel::Serializer
  attributes :id, :name, :reps, :weight, :rest, :workout_id
end
