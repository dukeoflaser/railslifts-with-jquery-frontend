class ExerciseTemplateSerializer < ActiveModel::Serializer
  attributes :id, :name, :reps, :weight, :rest, :owner_id, :default
end
