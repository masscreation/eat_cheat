// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .


$(document).ready(function(){
  var search = $('.searchName');

  search.click(function(){
    var plus = $(this).find('.plus');
    if (plus.html() == ' + ') {
      plus.html(' - ');
    } else {
      plus.html(' + ');
    }

    $(this).next().slideToggle('show');
    }); //end click


  $('#calcButton').click(function(){
    $('#calcPie').html("");
    $('#checkout').slideDown('show');
    $('#createItem').slideDown('show');

    var prot = 0,
        carbs = 0,
        fat = 0;

    var $check = $('form > .checker');


   

    $check.each(function(index){
      var osc = [];
      var del = {};
      if ($(this).is(':checked')){
        var $form = $(this).closest('form');

        string = $form.serialize();
        col = string.split('&');


        

        for(var i = 0; i < col.length; i++){
          osc = col[i].split("=");
          del[osc[0]] = osc[1];
        }

        
       prot += parseInt(del.protein);
       carbs += parseInt(del.carbs);
       fat += parseInt(del.fat);

      }

      
    }); //end each
    console.log(prot);
    console.log(carbs);
    console.log(fat);
    pieChart('#calcPie', prot, carbs, fat);
  });//end click
  
  

  

    

}); //end ready




         






