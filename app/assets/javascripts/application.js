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

  $('.searchItem').draggable({
      helper : "clone",
      cursor: "move",
      revert: "invalid",
      stop: function( event, ui ) {
          original = false;
      },
      start: function( event, ui ) {
          original = true;
      }
    });


  $('#checkoutPlate').droppable({
    drop: function( event, ui ) {
        droppable = true;
        if(original){
             var newDiv = $(ui.draggable).clone();
             
             newDiv.draggable({
                stop: function( event, ui ) {
                    if(!droppable)
                        ui.helper.remove();
                },
                start: function( event, ui ) {
                    droppable = false;
                }
            });
            $(this).append(newDiv);
       }
        else{
           ui.helper.css('top','');
           ui.helper.css('left','');
           $(this).append(ui.helper);
           
        }
      }
    });

  // grab the 'recipes-con'
  var $recipesCon = $("#recipes-con"); 

     console.log($recipesCon.html()); 

    $.get("/users/<%= current_user.id %>/recipes")
      .done(function (recipes) {
        console.log("All Recipes:", recipes);

        // append each recipe
        recipes.forEach(function (recipe) {
          $recipesCon.append("<div>" + recipe.name + "</div>"); 
        });

      });
      // grab the form
     var $recipeForm = $("#new_recipe"); 

     $recipeForm.on("submit", function (event) {
      event.preventDefault(); 
      console.log("Form submitted", $(this).serialize());

      var content = $("#recipe_content").val(); 
      $.post("/users/:id/recipes", {
        recipe: {
          content: content 
        }
      }).done(function (createdRecipe) {
        $recipesCon.append("<div class=\"recipe\" data-id=" + createdRecipe.id + ">" + createdRecipe.content + 
          "<input type=\"checkbox\" class=\"completed\">" + 
          "<button class=\"delete\">Delete</button></div>");
      }); 
     }); 
  //  setup a click handler that only
    //  handle clicks from an element
    //  with the `.delete` className
    //  that is inside the $recipesCon
     $recipesCon.on("click", ".delete", function (event) {
      alert("I wask clicked!"); 
      
      // grab the entire recipe
      var $recipe = $(this).closest(".recipe"); 

      //send our delete request
      $.ajax({
        url: "/users/:id/recipes/" + $recipe.data("id") + ".json",
        type: "DELETE"
      }).done(function(){
        //once we completed the delete
        $recipe.remove(); 
      })
     }); 

     $recipesCon.on("click", ".completed", function () {
      var $recipe = $(this).closest(".recipe"); 

      $.ajax({
        url: "/users/:id/recipes" + $recipe.data("id") + ".json", 
        type: "PATCH",
        data: {
          recipe: {
            completed: this.checked
          }
        } 
      }).done(function (data) {
        // update the styling of our recipe
        $recipe.toggleClass("recipe-completed")
      }) 
     }); 

    
}); //end ready




         






