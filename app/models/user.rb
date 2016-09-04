class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :programs
  belongs_to :current_program, class_name: 'Program'
  has_many :workout_templates
  has_many :exercise_templates, through: :workout_templates
  has_many :workouts
  has_many :exercises, through: :workouts

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:facebook]


   def self.from_omniauth(auth)
     find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
       user.email = auth.info.email
       user.password = Devise.friendly_token[0,20]
       user.name = auth.info.name
     end
   end

   def next_workout
     workout_templates = current_program.try(:workout_templates)
     workout_templates[self.workout_cycle_index]
   end

   def update_workout_cycle_index
     unless current_program.workout_templates[self.workout_cycle_index + 1].nil?
       self.workout_cycle_index += 1
     else
       self.workout_cycle_index = 0
     end

    self.save
   end

   def self.leaderboard
     most_to_least_workouts = all.sort_by do |user|
       user.workouts.count
     end

     most_to_least_workouts.reverse
   end



end
