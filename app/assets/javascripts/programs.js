function programsShow(){
  getProgramData();
}

function getProgramData(id){
  if(id === undefined) var id = getId();

  $.get('/programs/' + id + '.json', function(data){

    var p = data['program'];
    var program = new Program(
      p['id'],
      p['name'],
      p['description'],
      p['owner_name'],
      p['workout_templates']
    );
    renderProgramData(program);
  })
  .fail(function(){
    renderError();
  });
}

function getId(){
  return $('[data-id]').attr('data-id');
}

function renderProgramData(program){
  renderProgramInfo(program);
  renderWorkoutTemplates(program);
}

function renderProgramInfo(program){
  $('.programName').text(program.name);
  $('.programOwner').text('By ' + program.ownerName);
  $('.programDescription').text(program.description);
}

function renderWorkoutTemplates(program){
  var tT = tableTemplate();
  program.workoutTemplates.forEach(function(wt, i){
    $('.workoutTemplates').append(
      '<h3 class="wt' + i + '"></h3>' +
      '<p class="wt' + i + '"></p><br>' +
      '<table class="table wt' + i + '"></table>'
    );
      $('h3.wt' + i).text(wt['name']);
      $('p.wt' + i).text(wt['description']);
      $('table.wt' + i).html(tT);

      wt['exercise_templates'].forEach(function(et, ii){
        $('table.wt' + i).append('<tr class="et' + ii + '"></tr>');
        $('table.wt' + i + ' tr.et' + ii).append('<td>' + et['name'] + '</td>');
        $('table.wt' + i + ' tr.et' + ii).append('<td>' + et['sets'] + '</td>');
        $('table.wt' + i + ' tr.et' + ii).append('<td>' + et['reps'] + '</td>');
        $('table.wt' + i + ' tr.et' + ii).append('<td>' + et['weight'] + '</td>');
        $('table.wt' + i + ' tr.et' + ii).append('<td>' + et['rest'] + '</td>');
      });
  });

  $('td.workoutTemplates').fadeIn(200);
}

function tableTemplate(){
  var tableTemplate = '' +
    '<tr>' +
      '<th>Exercise</th>' +
      '<th>Sets</th>' +
      '<th>Reps</th>' +
      '<th>Weight (lbs)</th>' +
      '<th>Rest (seconds)</th>' +
    '</tr>';

  return tableTemplate;
}












































function programsIndex(){
  newProgram();
  resetProgramPage();
}


//why does this get fired twice when switch between programs and my programs?
//answer: Turbolinks. How to work with Turbolinks is the real question.

function getProgramsData(){

    $.get('/programs.json', function(data){

      if(window.location.pathname == '/my_programs'){
        $.get('/user-data.json', function(res){
          var my_programs = [];

          data['programs'].forEach(function(p, i){
            if(p.owner_id == res.user.id ){
              my_programs.push(p);
            }
          });

          var programs = new ProgramList(my_programs);

          renderProgramsData(programs);
        }).fail(function(){
          renderError();
        });
      } else {
        var programs = new ProgramList(data['programs']);

        renderProgramsData(programs);
      }


    }).fail(function(){
      renderError();
    });
}

function renderProgramsData(programs){
  $('.programList').hide();
  $('.programList').html('');

  if(programs.list.length > 0){
    programs.list.forEach(function(program, i){
      $('.programList').append('<tr class="program' + i + '"></tr>');
      $('tr.program' + i).append('<td><a href="/programs/' + program['id'] + '">' + program['name'] + '</a></td>');
      $('tr.program' + i).append(
        '<td><a href="#" class="displayWorkouts btn btn-sm btn-info" data-id="' +
        program['id'] +
        '">' +
        'View (' + program["workout_templates"].length + ')' +
        '</a></td>'
      );
    });
  } else {
    $('.programList').append('<tr><td>There are no programs to display.</td></tr>');
  }

  $('.programList').fadeIn(200);
  showWorkoutTemplates();
}

function showWorkoutTemplates(){
  $(document).on('click', '.displayWorkouts', function(event){
    event.preventDefault();
    if(event.handled !== true){

      $('td.workoutTemplates').remove();

      var row_class = $(this).parent().parent().attr('class');

      $('tr.' + row_class).after($('<tr><td colspan="2" class="workoutTemplates errorMessage"></td></tr>'));
      $('td.workoutTemplates').hide();

      getProgramData($(this).data('id'));


      event.handled = true;
    }

    return false;



  });
}







// below are the functions concerned with rendering the dynamic forms.
var workout_templates = [];

function newProgram(){
  $('.newProgram').click(function(event){
    event.preventDefault();

    addFormArea();
  });
}

function addFormArea(){
  $('div#newWorkoutTemplate').before('<div id="newProgram"></div>');

  var formArea = '' +
  '<form class="new_program" id="new_program">' +
    '<div class="fieldZone"></div>' +
    '<div class="selectZone"></div>' +
    '<div class="buttonZone"></div>' +
    '</div>' +
  '</form>'

  $('#newProgram').html(formArea).hide().fadeIn(500);

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

function addWorkout(){
  $('.addWorkout').click(function(event){
      event.preventDefault();

      if(workout_templates.length == 0){
        getWorkoutTemplates();
      } else {
        renderWTSelectMenu(workout_templates);
      }

      $('.addWorkout').text('Add Another Workout');

      if( $('.selectZone div').length > 1 ){
        $('.removeWorkout').show();
        removeWorkout();
      }

      checkSaveProgram();
  });
}

function renderSaveButton(){
  var elements = new Elements;
  $('div.buttonZone').append(elements.saveProgramButton);
}

function removeSaveButton(){
  $('a.saveProgram').remove();
}

function checkSaveProgram(){
  var hasSaveButton = $('.saveProgram').length > 0;
  var hasNoSaveButton = $('.saveProgram').length === 0;
  var hasNameInput = $.trim($('#program_name').val());
  var hasDescInput = $.trim($('#program_description').val());
  var hasWT = $('.selectWorkout').length > 0;

  if(hasNoSaveButton && hasNameInput && hasDescInput && hasWT){
    renderSaveButton();
  } else if(hasSaveButton && (!hasNameInput || !hasDescInput || !hasWT)){
    removeSaveButton();
  }

  saveProgram();
}

function saveProgram(){

  $(document).on('click', '.saveProgram', function(event){
    event.preventDefault();
    if (event.handled !== true){

      var name = $('#program_name').val();
      var description = $('#program_description').val();
      var workout_templates_attributes = {};

      $('.selectWorkout').each(function(index){
        workout_templates_attributes[index.toString()] = {"id": $(this).val()};
      });

      $.ajax({
        url: '/programs',
        method: 'POST',
        data: {
          program: {
            'name': name,
            'description': description,
            'workout_templates_attributes': workout_templates_attributes
          }
        }
      })
      .success(function(res){
        console.log('Done!');
        console.log(res);
        resetProgramPage();
      });

      event.handled = true;
    }

      return false;
  });

}

function resetProgramPage(){
  $('#newProgram').hide(200, function(){
    $( this ).remove();
  });
  getProgramsData();
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
  $('.selectZone').append(form.selectWorkout);
  wts.forEach(function(wt, i){
    $('.selectWorkout:last').append(wt.asOption(wt.id));
  });

  $('.selectZone div:last').hide().show(200);
  checkSaveProgram();
}

// end program form logic






























function ProgramList(programs){
  this.list = programs;
}

function Program(id, name, desc, owner, wts){
  this.id = id;
  this.name = name;
  this.description = desc;
  this.ownerName = owner;
  this.workoutTemplates = wts;
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
        '<input type="text" name="program_name" id="program_name" onkeyup="checkSaveProgram()"><br>' +
      '</div>';

    this.descriptionField = '' +
      '<div class="form-group">' +
        '<label for="program_description">Description</label><br>' +
        '<textarea cols="23" rows="5" name="program_description" id="program_description" onkeyup="checkSaveProgram()"></textarea>' +
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
