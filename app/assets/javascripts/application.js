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
    $(this).next().slideToggle('show');
  }); //end click

  // $('.searchItem').draggable({
  //     helper : "clone",
  //     cursor: "move",
  //     revert: "invalid",
  //     stop: function( event, ui ) {
  //         original = false;
  //     },
  //     start: function( event, ui ) {
  //         original = true;
  //     }
  //   });


  // $('#checkoutPlate').droppable({
  //   drop: function( event, ui ) {
  //       droppable = true;
  //       if(original){
  //            var newDiv = $(ui.draggable).clone();
             
  //            newDiv.draggable({
  //               stop: function( event, ui ) {
  //                   if(!droppable)
  //                       ui.helper.remove();
  //               },
  //               start: function( event, ui ) {
  //                   droppable = false;
  //               }
  //           });
  //           $(this).append(newDiv);
  //      }
  //       else{
  //          ui.helper.css('top','');
  //          ui.helper.css('left','');
  //          $(this).append(ui.helper);
           
  //       }
  //     }
  // });

  //create string with info to send
  
  

  $('#checkoutButton').click(function(){
    var hash = {};
    var $check = $('form > .checker');
    console.log($check.length);

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


        console.log(string);
        console.log(col);
        console.log(hash);
      }
    }); //end each

    $.ajax({
      type: "POST",
      url: "/items",
      data: hash}).success(function(item){
        alert('yes');
      }).fail(function(){
        alert('fail!');
      });
    


  }); //end click

}); //end ready




         






