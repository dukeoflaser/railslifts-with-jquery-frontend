user = User.new
user.name = 'Nathaniel Miller'
user.email = 'nathaniel@example.com'
user.password = 'valid_password'
user.password_confirmation = 'valid_password'
user.save!

user2 = User.new
user2.name = 'Tim Chamberlaine'
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

user5 = User.new
user5.name = 'Ben Benson'
user5.email = 'bendson@example.com'
user5.password = 'valid_password'
user5.password_confirmation = 'valid_password'
user5.save!

Program.create(owner_id: 1, name: "Buns of Steel", description: "Where Baking and Welding Meet")

WorkoutTemplate.create(owner_id: 1, name: "Workout A", description: "1st Workout for Buns of Steel")
WorkoutTemplate.create(owner_id: 1, name: "Workout B", description: "2nd Workout for Buns of Steel")

ExerciseTemplate.create_default("Squats")
ExerciseTemplate.create_default("Deadlifts")
ExerciseTemplate.create_default("Bench Press")
ExerciseTemplate.create_default("Overhead Press")
ExerciseTemplate.create_default("Bent Over Rows")
ExerciseTemplate.create_default("Chin Ups")

WorkoutTemplate.find(1).exercise_templates << ExerciseTemplate.find(1)
WorkoutTemplate.find(1).exercise_templates << ExerciseTemplate.find(2)
WorkoutTemplate.find(1).exercise_templates << ExerciseTemplate.find(3)

WorkoutTemplate.find(2).exercise_templates << ExerciseTemplate.find(4)
WorkoutTemplate.find(2).exercise_templates << ExerciseTemplate.find(5)
WorkoutTemplate.find(2).exercise_templates << ExerciseTemplate.find(6)

Program.find(1).workout_templates << WorkoutTemplate.find(1)
Program.find(1).workout_templates << WorkoutTemplate.find(2)
