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

  function renderError(){
    $('.errorMessage').text('Sadly, there was an error. The program is currently unavailable.');
    $('.errorHide').hide();
  }

  getProgramData();
}

function programsIndex(){

  $.get('/programs.json', function(data){
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
  });
}
