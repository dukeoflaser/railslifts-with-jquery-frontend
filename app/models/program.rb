class Program < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_many :users
  has_and_belongs_to_many :workout_templates
end
