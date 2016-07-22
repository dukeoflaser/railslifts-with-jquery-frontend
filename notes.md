#FLOW

#HOME
  => Sign Up
  => Log In

# After Log In
  - User 'Profile'

    =>Link To Program Index (/programs)
      -Displays All Programs
      =>Link To Show Program (/program/:id)
        -Displays Single Program (if user created, have edit/delete link)

    =>Link To User Programs (/user/:id/programs)
      -Display All User Created And Added Programs
      =>Link To Show Program (/program/:id)
        -Displays Single Program (if user created, have edit/delete link)
      =>Create Program
        #Form with Name, Purpose, 1 Workout Select Menu
        #Add Workout Button, Submit Button. Delete Checkboxes.
        #https://rbudiharso.wordpress.com/2010/07/07/dynamically-add-and-remove-input-field-in-rails-without-javascript/

      =>Link To Add Or Create Workout(Template)
        #Form with Name, Description, 1 Exercise Dropdown Menu
        #Associated Sets/Reps/Weight/Rest
        #Create New Exercise Button to Add Exercise Form.

      =>Link To Add Or Create Exercise


      =>Add PreMade Program From Drop Down

    =>Link To Next WorkOut
      #Display

    #BOTTOM NAV
    =>Link To LogOut
    =>Link TO Delete Account
    =>Link To Edit Account


    #DATABASE
    #users
      #Name, Email, Age, Weight, Height, Password
    #programs
      #Name, Purpose, Workouts (Array of Workout Templates ids)
    #workout_templates

    #workouts
      #user_id, workdone ( :exercise => {:movement => <BenchPress>, :sets => [5, 5, 5], :weight => 170, :rest 180})
    #movements
      #Name, Description, YouTube Link (Validate YouTube Link)
