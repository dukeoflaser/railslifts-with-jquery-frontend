function programsShow(){

  function getId(){
    return $('[data-id]').attr('data-id');
  }

  function getProgramData(){
    var id = getId();

    $.get('/programs/' + id + '.json', function(data){
      renderData(data);
    }).fail(function(){
      renderError();
    });
  }

  function renderData(data){
    var tableTemplate = '' +
      '<tr>' +
        '<th>Exercise</th>' +
        '<th>Sets</th>' +
        '<th>Reps</th>' +
        '<th>Weight (lbs)</th>' +
        '<th>Rest (seconds)</th>' +
      '</tr>';

    $('.programName').text(data['program']['name']);
    $('.programOwner').text('By ' + data['program']['owner_name']);
    $('.programDescription').text(data['program']['description']);

    data['program']['workout_templates'].forEach(function(wt, i){
      $('.workoutTemplates').append(
        '<h3 class="wt' + i + '"></h3>' +
        '<p class="wt' + i + '"></p><br>' +
        '<table class="table wt' + i + '"></table>'
      );
        $('h3.wt' + i).text(wt['name']);
        $('p.wt' + i).text(wt['description']);
        $('table.wt' + i).html(tableTemplate);

        wt['exercise_templates'].forEach(function(et, ii){
          $('table.wt' + i).append('<tr class="et' + ii + '"></tr>');
          $('table.wt' + i + ' tr.et' + ii).append('<td>' + et['name'] + '</td>');
          $('table.wt' + i + ' tr.et' + ii).append('<td>' + et['sets'] + '</td>');
          $('table.wt' + i + ' tr.et' + ii).append('<td>' + et['reps'] + '</td>');
          $('table.wt' + i + ' tr.et' + ii).append('<td>' + et['weight'] + '</td>');
          $('table.wt' + i + ' tr.et' + ii).append('<td>' + et['rest'] + '</td>');
        });
    });
  }

  getProgramData();
}









function programsIndex(){

  function getProgramsData(){
    $.get('/programs.json', function(data){
      renderData(data);
    }).fail(function(){
      renderError();
    });
  }




  function renderData(data){
    $('.programList').html('');

    if(data['programs'].length > 0){
      data['programs'].forEach(function(program, i){
        $('.programList').append('<tr class="program' + i + '"></tr>');
        $('tr.program' + i).append('<td><a href="/programs/' + program['id'] + '">' + program['name'] + '</a></td>');
        $('tr.program' + i).append('<td>' + program['workout_templates'].length + '</td>');
      });
    } else {
      $('.programList').append('<tr><td>There are no programs to display.</td></tr>');
    }
  }

  getProgramsData();
}

function renderError(){
  $('.errorMessage').text('Sadly, there was an error. The information you are looking for is currently unavailable.');
  $('.errorHide').hide();
}




function programsNew(){
  $('.newProgram').click(function(event){
    event.preventDefault();

    renderForm();
    dynamicFields();
  });

  function renderForm(){
    var form = new renderedElements();
    var renderedForm = '' +
    '<form class="new_program" id="new_program">' +
       form.elements.nameField +
       form.elements.descriptionField +
      '<div class="dynamicZone">' +
        form.elements.addWorkout +
      '</div>' +
    '</form>'

    $('#newProgram').html(renderedForm);
  }

  function dynamicFields(){

    $('.addWorkout').click(function(event){
      event.preventDefault();

      var form = new renderedElements();

      $('.dynamicZone').append(form.elements.selectWorkout);
      $('.dynamicZone').append(form.elements.addThisWorkout);
      $('.dynamicZone').append(form.elements.removeWorkout);
      $('.addWorkout').hide();
    });
  }
}

function workoutTemplatesNew(){
  $('.newWorkoutTemplate').click(function(event){
    $('#newWorkoutTemplate').html('<p>New Workout Template Goes Here.</p>');
    event.preventDefault();
  });
}

function renderedElements(){


  this.elements = {
    addWorkout: ''+
      '<div class="form-group">' +
        '<input type="submit" name="select_workout" value="Add A Workout" class="addWorkout btn btn-primary btn-sm">' +
      '</div>',

    addThisWorkout: '' +
      '<div class="form-group">' +
        '<input type="submit" name="add_workout" value="Add This Workout" class="btn btn-primary btn-sm">' +
      '</div>',

    removeWorkout: '' +
      '<div class="form-group">' +
        '<input type="submit" name="remove_workout" value="Remove Workout" class="btn btn-primary btn-sm">' +
      '</div>',

    nameField: '' +
    '<div class="form-group">' +
      '<label for="program_name">Name</label><br>' +
      '<input type="text" name="program_name" id="program_name"><br>' +
    '</div>',

    descriptionField: '' +
    '<div class="form-group">' +
      '<label for="program_description">Description</label><br>' +
      '<textarea cols="23" rows="5" name="program_description" id="program_description"></textarea>' +
    '</div>',

    selectWorkout: '' +
      '<div class="form-group">' +
        '<select name="program[workout_templates_attributes][1][id]" id="program_workout_templates_attributes_1_id">' +
        '<option selected="selected" value="1">Workout A</option>' +
        '<option value="2">Workout B</option>' +
        '</select>' +
      '</div>'
  }



}
