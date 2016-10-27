function programsShow(){
  var tableTemplate = '' +
    '<tr>' +
      '<th>Exercise</th>' +
      '<th>Sets</th>' +
      '<th>Reps</th>' +
      '<th>Weight (lbs)</th>' +
      '<th>Rest (seconds)</th>' +
    '</tr>';

  function getId(){
    return $('[data-id]').attr('data-id');
  }

  function getProgramData(){
    var id = getId();

    $.get('/programs/' + id + '.json', function(data){
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
      return data;
    });
  }




  getProgramData();







}
