$(function(){
  
  
  $('#add_link').click(function(){
    $.get('/projects/new', function(data){
      
      $('.form').html(data)
      
    })
    return false;
  })
})
