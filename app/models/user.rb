class User < ActiveRecord::Base
  attr_accessor :current_program
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :programs
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


end
