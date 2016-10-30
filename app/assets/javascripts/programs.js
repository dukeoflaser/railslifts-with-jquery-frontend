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
      renderProgramsData(data);
    }).fail(function(){
      renderError();
    });
  }

  function renderProgramsData(data){
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




// below are the functions concerned with rendering the dynamic forms.

  function programsNew(){
    $('.newProgram').click(function(event){
      event.preventDefault();

      renderForm();
    });
  }

  function renderForm(){
    var form = new RenderedElements();
    var renderedForm = '' +
    '<form class="new_program" id="new_program">' +
       form.nameField +
       form.descriptionField +
      '<div class="dynamicZone">' +
        form.addWorkout +
      '</div>' +
    '</form>'

    $('#newProgram').html(renderedForm);
    addWorkout();
  }

  function getWorkoutTemplatesData(){
    $.get('/workout_templates.json', function(data){
        wts = [];

        data.workout_templates.forEach(function(wt, i){
          var x = new WorkoutTemplate(
            wt.description,
            wt.exercise_templates,
            wt.id,
            wt.name,
            wt.owner_id
          );

          wts.push(x);
        });

        renderDynamicFields(wts);
    });
  }

  function addWorkout(){
    $('.addWorkout').click(function(event){
        event.preventDefault();
        addThisWorkout();
        removeWorkout();
        getWorkoutTemplatesData();
    });
  }

  function addThisWorkout(){
    $(document).on('click', '.addThisWorkout', function(event){
      event.preventDefault();
      $('.addWorkout').show();
      $('.removeWorkout').hide();
      $('.addThisWorkout').hide();
    });
  }

  function removeWorkout(){

  }

  function renderDynamicFields(wts){
    var form = new RenderedElements();
    $('.dynamicZone').append(form.selectWorkout);
    $('.dynamicZone').append(form.addThisWorkout);
    $('.dynamicZone').append(form.removeWorkout);
    $('.addWorkout').hide();

    wts.forEach(function(wt, i){
      $('.selectWorkout').append(wt.asOption());
    });
  }



  function workoutTemplatesNew(){
    $('.newWorkoutTemplate').click(function(event){
      $('#newWorkoutTemplate').html('<p>New Workout Template Goes Here.</p>');
      event.preventDefault();
    });
  }

  programsNew();
}











function WorkoutTemplate(desc, et, id, name, owner_id){
  this.desc = desc;
  this.et = et;
  this.id = id;
  this.name = name;
  this.owner_id = owner_id;
  this.asOption = function(val, selected){
    if(selected){
      return `<option selected="selected" value="${val}">${this.name}</option>`;
    } else {
      return `<option value="${val}">${this.name}</option>`;
    }
  }
}



function RenderedElements(){
    this.addWorkout = ''+
      '<div class="form-group">' +
        '<a href="#" class="addWorkout btn btn-primary btn-sm">Add A Workout</a>' +
      '</div>';

    this.addThisWorkout = '' +
      '<div class="form-group">' +
        '<a href="#" class="addThisWorkout btn btn-primary btn-sm">Add This Workout</a>' +
      '</div>';

    this.removeWorkout = '' +
      '<div class="form-group">' +
        '<a href="#" class="removeWorkout btn btn-primary btn-sm">Remove Workout</a>' +
      '</div>';

    this.nameField = '' +
      '<div class="form-group">' +
        '<label for="program_name">Name</label><br>' +
        '<input type="text" name="program_name" id="program_name"><br>' +
      '</div>';

    this.descriptionField = '' +
      '<div class="form-group">' +
        '<label for="program_description">Description</label><br>' +
        '<textarea cols="23" rows="5" name="program_description" id="program_description"></textarea>' +
      '</div>';

    this.selectWorkout = '' +
      '<div class="form-group">' +
        '<select name="program_workout_templates" id="program_workout_templates" class="selectWorkout">' +
        '</select>' +
      '</div>';

}

function renderOptions(data) {
  console.log('From renderOptions...');
  console.log(data);
  if(data){
    data.forEach(function(wt, i){
      if(i = 0){
        wt.asOption((i + 1), true);
      } else {
        wt.asOption((i + 1), false);
      }
    });
  }
}


function renderError(){
  $('.errorMessage').text('Sadly, there was an error. The information you are looking for is currently unavailable.');
  $('.errorHide').hide();
}
