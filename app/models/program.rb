class Program < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_many :users
  has_many :current_users, foreign_key: :current_program_id, class_name: 'User'
  has_and_belongs_to_many :workout_templates
  has_many :exercise_templates, through: :workout_templates

  accepts_nested_attributes_for :workout_templates

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  def owner_name
    @owner = User.find_by(id: self.owner_id)
    @owner.name
  end
end
