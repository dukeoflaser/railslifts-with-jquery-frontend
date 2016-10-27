class ExerciseTemplateSerializer < ActiveModel::Serializer
  attributes :id, :name, :sets, :reps, :weight, :rest, :owner_id, :default
  # has_many :workout_templates
end
