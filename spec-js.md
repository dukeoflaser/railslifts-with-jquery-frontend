# Specifications for the Rails with jQuery Assessment

Specs:
- [x] Use jQuery for implementing new requirements
- [x] Include a show resource rendered using jQuery and an Active Model Serialization JSON backend. ***/programs/:id***
- [x] Include an index resource rendered using jQuery and an Active Model Serialization JSON backend. ***/programs***
- [x] Include at least one has_many relationship in information rendered via JSON and appended to the DOM.
    ***program has_many workout_templates. workout_templates has_many exercise_templates***
- [x] Include at least one link that loads or updates a resource without reloading the page.
    ***Programs are created and loaded onto the 'programs' page without browser refresh***
- [x] Translate JSON responses into js model objects.
- [x] At least one of the js model objects must have at least one method added by your code to the prototype.
    ***get request to workout_templates is turned into a model. A method to format the workout into <option> tags is added***

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
