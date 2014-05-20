// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require_tree .

$( window ).load(function() {
    $("#feeds-menu").sortable({
      update: function (){ 
      $.ajax({
        type: "POST",
        url: "/feeds/update/sortable/",
        data: $("#feeds-menu").sortable('serialize')
          })
        }
      });

    $("#feeds-menu").disableSelection();

    $('#manage_feeds').on("click", function() {
        setTimeout(function(){
        $("#feeds-menu").addClass("show")
      }, 200)
    });



    $("#left-menu li a").on("click", function(){
        $("#left-menu .active").removeClass("active")
        $(this).addClass("active")
        $("#feeds-menu").removeClass("show")
        setTimeout(function() {
          $("#middle-menu li a").on("click", function(){
            $("#middle-menu .active").removeClass("active")
            $(this).addClass("active")
        });
        }  ,200)
    });

    

});



$(document).ready(function(){
            
  

   var update_articles = function () {
        var ajaxOptions = {
          url: "/feeds/update/articles",
          type: 'GET',
          success: function(data) {
            console.log(data);
          } ,
          error: function(data) {
            console.error("ajax error");
            console.log(data);
          }
        }

        $.ajax(ajaxOptions);
    };

}());

