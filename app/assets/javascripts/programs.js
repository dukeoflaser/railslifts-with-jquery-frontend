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
  var workout_templates = [];

  function newProgram(){
    $('.newProgram').click(function(event){
      event.preventDefault();

      addFormArea();
    });
  }

  function addFormArea(){

    var formArea = '' +
    '<form class="new_program" id="new_program">' +
      '<div class="fieldZone"></div>' +
      '<div class="selectZone"></div>' +
      '<div class="buttonZone"></div>' +
      '</div>' +
    '</form>'

    $('#newProgram').html(formArea);

    populateForm();
  }


  function populateForm(){
    var elements = new Elements;
    $('div.fieldZone').append(elements.nameField);
    $('div.fieldZone').append(elements.descriptionField);
    $('div.buttonZone').append(elements.addWorkoutButton);
    $('div.buttonZone').append(elements.removeWorkoutButton);
    $('.removeWorkout').hide();

    addWorkout();
  }

  function showHideRemoveButton(){
    if($('.selectWorkout').length > 1){
      $('.removeWorkout').show();
      removeWorkout();
    } else {
      $('.removeWorkout').hide();
    }
  }

  function addWorkout(){
    $('.addWorkout').click(function(event){
        event.preventDefault();

        if(workout_templates.length == 0){
          getWorkoutTemplates();
        } else {
          renderWTSelectMenu(workout_templates);
        }

        $('.addWorkout').text('Add Another Workout');

        // showHideRemoveButton();
        $('.removeWorkout').show();
        removeWorkout();

        if($('.saveProgram').length == 0){
          var elements = new Elements;
          $('div.buttonZone').append(elements.saveProgramButton)
        }
    });
  }

  function removeWorkout(){
    $(document).on('click', '.removeWorkout', function(event){
      event.preventDefault();

      if( $('.selectZone div').length > 1 ){
        $('.selectZone div:last').hide(200, function(){
          $(this).remove();
        });
      }
      
    });
  }

  function getWorkoutTemplates(){
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
          workout_templates.push(x); // use this array to reuse workout_templates list.
        });

        renderWTSelectMenu(wts);
    });
  }

  function renderWTSelectMenu(wts){
    var form = new Elements();
    $('div.selectZone').append(form.selectWorkout);
    wts.forEach(function(wt, i){
      $('.selectWorkout').append(wt.asOption());
    });
  }

  // function renderDynamicFields(wts){
  //   var form = new Elements();
  //   // $('.dynamicZone').append(form.selectWorkout);
  //   $('.dynamicZone').append(form.addThisWorkout);
  //   $('.dynamicZone').append(form.removeWorkout);
  //   $('.addWorkout').hide();

    // wts.forEach(function(wt, i){
    //   $('.selectWorkout').append(wt.asOption());
    // });
  // }



  // function workoutTemplatesNew(){
  //   $('.newWorkoutTemplate').click(function(event){
  //     $('#newWorkoutTemplate').html('<p>New Workout Template Goes Here.</p>');
  //     event.preventDefault();
  //   });
  // }

  newProgram();
}

// end program form logic


































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

function Elements(){
    this.addWorkoutButton = ''+
      '<div class="form-group">' +
        '<a href="#" class="addWorkout btn btn-primary btn-sm">Add A Workout</a>' +
      '</div>';

    this.removeWorkoutButton = '' +
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
        '<select class="selectWorkout">' +
        '</select>' +
      '</div>';
    this.saveProgramButton = '' +
      '<div class="form-group">' +
        '<a href="#" class="saveProgram btn btn-primary btn-sm">Save Program</a>' +
      '</div>';

}

function renderError(){
  $('.errorMessage').text('Sadly, there was an error. The information you are looking for is currently unavailable.');
  $('.errorHide').hide();
}
