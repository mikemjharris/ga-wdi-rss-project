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
//= require underscore
//= require_tree .

$( window ).load(function() {
    $("#feeds-menu").sortable({
      update: function (){ 
      $.ajax({
        type: "POST",
        url: "/feeds/update/sortable/",
        beforeSend: function(jqXHR, settings) {
        jqXHR.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
          },
        data: $("#feeds-menu").sortable('serialize'),
        success: updatepage
          })
        }
      });

    var updatepage = function() {
      $.ajax({
        type: "get",
        url: "/categories/" + $('#middle-menu').data('partial')
        })
    }

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

    $("#following-list-search").hide();
    $(".follower-search-button").click(function(){
        $("#following-list-search").slideToggle();
        // $("#following-list-search, #following li").toggle();
    });

    var $following = $('#following li');
      $('#filter').keyup(function() {
      var re = new RegExp($(this).val(), "i"); // "i" means it's case-insensitive
      $following.show().filter(function() {
        return !re.test($(this).text());
            }).hide();
      });


      var updateArticles = function() {
        $.ajax({
          type: "get",
          url: "/users/1",
          data: $('#activity-stream').data()       
        }).done(upDateArticlePage)
      }

      var upDateArticlePage = function(articles) {
        // console.log("hi");
        // console.log(articles.length);
        for(var i = 0; i < articles.length; i++) {
            // console.log(articles[i]);  
            var htmlText = "<div class='wide-display' ><b>" + articles[i]["first_name"] + " " + articles[i]["last_name"] + "</b> has <b>added</b> an article to their <b>timeline</b>"
             + "<a href='/articles/"+articles[i]["id"]+"'>"+articles[i]["title"]+"</a></div>"
      
           el = $(htmlText).insertAfter("#activity-stream");
            // if (i === 0){
              $('#activity-stream').data('since', articles[i]["created"]);
             
               // }         
          
    setTimeout(function () { 
        $(el).addClass('article_flash');
      }, 100);
    setTimeout(function () { 
        $(el).removeClass('article_flash');
      }, 1000);

        }

      }
      
      setInterval(function() {

        updateArticles();
      }, 5000); 

      
      $(".delete_icon").on("click", function(e) {
        $(e.target).closest("li").remove();
        $("#feeds-menu").addClass("show");
      });

      $(".followed-users").hide() 
      $(".followed-count").on("click", function() {
          $(".followers-users").slideUp()
          $(".followed-users").slideToggle()
          
      })

      $(".followers-users").hide() 
      $(".follower-count").on("click", function() {
          $(".followed-users").slideUp()
          $(".followers-users").slideToggle()
          
      })


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

