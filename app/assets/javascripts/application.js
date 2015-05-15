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

  $('#searchAPI').click(function(){
    // console.log('hey i work!');
    $val = $('#q').val();
    console.log($val);

    // run through val to make sure query will be one word
    beat = $val.split(' ');
    query = beat[0];

    if (beat.length>1){
      for (var i = 1; i < beat.length; i++){
        query += "+"+beat[i];
      }
    }

    //create url string
    var url = "https://api.nutritionix.com/v1_1/search/"+query+"?fields=item_name%2Cbrand_name%2Citem_id%2Cnf_calories%2Cnf_total_fat%2Cnf_protein%2Cnf_total_carbohydrate%2Cnf_serving_weight_grams&appId=58809d9f&appKey=f0ee2e843b2e4a910d564ccebfc2c1dd";

    $.getJSON(url, function(data) {
      var items = data.hits;
      var hash = {};

      for(var i = 0; i < items.length; i++){
        hash.nutrionix_id = items[i].fields.item_id;
        hash.item_name = items[i].fields.item_name;
        hash.brand_name = items[i].fields.brand_name;
        hash.calories = items[i].fields.nf_calories;
        hash.protein = items[i].fields.nf_protein;
        hash.fat = items[i].fields.nf_total_fat;
        hash.carbs = items[i].fields.nf_total_carbohydrate;

        if (hash.fat === null){
          hash.fat = 0;
        }
        if (hash.protein === null){
          hash.protein = 0;
        }
        if (hash.carbs === null){
          hash.carbs = 0;
        }

        var $el = '<form class="searchItem newItem" action="/"><input type="hidden" name="authenticity_token" value="b5TXpTNkBKlUUNiGYG6dgWiBPv9aGClzoFgAUPws/3/pJ7XFDtgLKE3b1Xu0IEjS+bLxfE4SVtm1lp+ntNaANA=="><input type="hidden" name="name" value="'+hash.item_name+'"><input type="hidden" name="nutritionix_id" value="'+hash.nutrionix_id+'"><input type="hidden" name="calories" value="'+hash.calories+'"><input type="hidden" name="serving_weight_grams" value="137"><input type="hidden" name="fat" value="'+hash.fat+'"><input type="hidden" name="protein" value="'+hash.protein+'"><input type="hidden" name="carbs" value="'+hash.carbs+'"><input type="checkbox" name="check" class="checker" value="true"><div class="searchName searchNameNew"><h3>'+hash.item_name+'<span class="plus"> + </span></h3>'+hash.brand_name+'</div><div class="searchResults showMe"><div><strong>Calories</strong><br>'+hash.calories+'</div><div><strong>Fat Calories</strong><br>'+hash.fat+'</div><div><strong>Protein Calories</strong><br>'+hash.protein+'</div><div><strong>Carbs Calories</strong><br>'+hash.carbs+'</div></div></form>';

        $('#searchFolder').append($el);

      }

      var search = $('.searchNameNew');

      search.click(function(){
        var plus = $(this).find('.plus');
        if (plus.html() == ' + ') {
          plus.html(' - ');
        } else {
          plus.html(' + ');
        }

        $(this).next().slideToggle('show');
        }); //end click
    });

   






  }); //end click

  //create string with info to send

  //search button
  //   var url = "http://www.omdbapi.com/?s=Wedding";

  // $.getJSON(url, function(data) {
  //     var list = "<ul>";
  //     // Iterate through the data object returned
  //     data.Search.forEach( function(item) {
  //         // Add the title of result to the list
  //         list += "<li>" + item.Title + "</li>";
  //     })
  //     // Close the unordered list
  //     list += "</ul>";

  //     // Now we just add the newly created list to the results div
  //     $("#search_results").html(list);
  // });







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




         






