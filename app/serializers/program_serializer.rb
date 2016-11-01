class ProgramSerializer < ActiveModel::Serializer
  attributes :id, :owner_name, :name, :description, :user_id, :owner_id
  has_many :workout_templates
end
