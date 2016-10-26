class ProgramSerializer < ActiveModel::Serializer
  attributes :id, :owner_id, :name, :description, :user_id
  has_many :workout_templates
  # has_many :exercise_templates, through: :workout_templates
end
