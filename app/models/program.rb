class Program < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_many :users
  has_and_belongs_to_many :workout_templates
  has_many :exercise_templates, through: :workout_templates

  def owner_name
    @owner = User.find_by(id: self.owner_id)
    @owner.name
  end
end
