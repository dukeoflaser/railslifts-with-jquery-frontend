user = User.new
user.name = 'Nathaniel Paul Miller'
user.email = 'nathaniel@example.com'
user.password = 'valid_password'
user.password_confirmation = 'valid_password'
user.save!

user2 = User.new
user2.name = 'Tim Miller'
user2.email = 'tim@example.com'
user2.password = 'valid_password'
user2.password_confirmation = 'valid_password'
user2.save!

user3 = User.new
user3.name = 'Jason Lee'
user3.email = 'jason@example.com'
user3.password = 'valid_password'
user3.password_confirmation = 'valid_password'
user3.save!

user4 = User.new
user4.name = 'Thomas Jefferson'
user4.email = 'jefferson@example.com'
user4.password = 'valid_password'
user4.password_confirmation = 'valid_password'
user4.save!

Program.create(owner_id: 1, name: "StrongLifts 5x5", description: "Strength Training")
Program.create(owner_id: 1, name: "Starting Strength", description: "Strength Training")
Program.create(owner_id: 2, name: "Buns of Steel", description: "Where Baking and Welding Meet")

WorkoutTemplate.create(owner_id: 1, name: "Workout A", description: "1st Workout for Stronglifts")
WorkoutTemplate.create(owner_id: 1, name: "Workout B", description: "2nd Workout for Stronglifts")

ExerciseTemplate.create(name: "Squats", reps: "5 5 5", starting_weight: 45, rest: 180)
ExerciseTemplate.create(name: "Deadlifts", reps: "5 5 5", starting_weight: 95, rest: 180)

Workout.create(user_id: 1, name: "Workout A")
Workout.create(user_id: 1, name: "Workout B")

Exercise.create(name: "Squats", reps: "5 5 5", starting_weight: 45, rest: 180)
Exercise.create(name: "Deadlifts", reps: "5 5 5", starting_weight: 95, rest: 180)
