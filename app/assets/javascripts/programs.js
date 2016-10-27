function programsShow(){

  function getId(){
    return $('h1[data-id]').data('id');
  }

  function getProgramData(){
    var id = getId();

    $.get('/programs/' + id + '.json', function(data){
      console.log(data);
      return data;
    });
  }




  getProgramData();







}
