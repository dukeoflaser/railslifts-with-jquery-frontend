class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name
  has_many :workout_templates
  has_many :programs
  has_many :workouts
  has_one :current_program
end
