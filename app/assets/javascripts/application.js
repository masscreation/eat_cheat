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
  
  

  $('#checkoutButton').click(function(){
    var hash = {};
    var $check = $('form > .checker');
    console.log($check.length);
    console.log("HI HI HI HI HI");

    // run through the checkbox of each searchItem
    $check.each(function(index){
      var string = "";
      var col = [];
      var osc = [];
      var del = {};
      
      if ($(this).is(':checked')){
        //console logs out that checkbox's parent's form
        var $form = $(this).closest('form');
        console.log($form);

        string = $form.serialize();
        col = string.split('&');
        

        for(var i = 0; i < col.length; i++){
          osc = col[i].split("=");
          console.log(osc[1]);
          del[osc[0]] = osc[1];
        }

        hash.item = del;


        $.ajax({
          type: "POST",
          url: "/items",
          data: hash
        }).success(function(item){
          console.log('item created in database!');
          
          //create a meal 
            // find datetime object
            var $form = $('#checkoutDatetime').closest('form');
            console.log($form);

            var string = $form.serialize();
            console.log(string);

            var col = string.split('&');
            var osc = [];
            var del = {};

            for(var i = 0; i < col.length; i++){
              osc = col[i].split("=");
              console.log(osc[1]);
              del[osc[0]] = osc[1];
            }

            var hash = {};
            hash.meal = del;

            console.log("THIS IS THE HASH");
            console.log(hash);

            $.ajax({
              type: "POST",
              url: "/meals",
              data: hash
            }).success(function(meal){
              console.log('meal created in database!');
            }).fail(function(){
              console.log('cannot make a meal');
            });

            // go through the same thing again
            // then create ajax request to meal create 
          //on back end: meal will only have a time. then find last item. associate items.meal << meal 
          

        }).fail(function(){
          alert('fail!');
        });
      }

    }); //end each


    


  }); //end click



  

    

}); //end ready




         






