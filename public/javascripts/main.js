function tweetPuller(){
  this.list = []
  
  this.queryString = function(){
    var str = ''
    $.each(this.list, function(item, index){
      str += item
      str += '+OR+'
    })
    return str
  }
  
  this.watch = function(name){
    this.list.push(name)
  }
  
  this.pullTweets = function(){
    $.getJSON('http://search.twitter.com/search.json?q='+this.queryString, function(json){
      if(json){
        console.log(json)
      }
    })
  }
}

function watchAddLink(){
  $('#add_link').click(function(){
    $('.form').toggle()
    return false;
  })
}

function watchNewProjectForm(){
  $('#js-new_project_form button').live('click', function(){
    pName = $('#new_project_name').val()
    if(pName != ''){
      $.ajax({
        type: 'post',
        url: '/create',
        dataType: 'json',
        data: {name: pName},
        success: function(data){
          if(data['status'] == 'success'){
            $('ul.projects').append('<li>'+data['name']+'</li>')
          } else {
            alert('could not add project, perhaps we\'re already watching it?')
          }
        }
      })
    }
    return false
  })
}


$(function(){
  watchAddLink()
  watchNewProjectForm()
  
  var tp = new tweetPuller;
  $.each($('ul.projects li'), function(index, li){
    li = $(li)
    var w = li.text()  
    tp.watch(w)
  })
  console.log(tp.list)
})
