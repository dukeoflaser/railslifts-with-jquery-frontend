class WorkoutTemplateSerializer < ActiveModel::Serializer
  attributes :id, :owner_id, :name, :description, :user_id
end
