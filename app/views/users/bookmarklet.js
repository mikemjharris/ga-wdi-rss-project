var myApp = myApp || {}

def myApp.bookmarklet( function() { 
var myElements = document.getElementsByTagName("a")

for (var i = 0; i < myElements.length; i++) {
  if (myElements[i].href.indexOf(".xml") > -1) {
    console.log (myElements[i].text + ": " + myElements[i].href );

  }

}


var node=document.createElement("p");
var textnode=document.createTextNode("Water");
// document.getElementsByTagName('body')[0].appendChild(node) 
document.getElementsByTagName('body')[0].innerHTML = "test" 
// document.getElementsByTagName('body')[0].innerHTML = htmlToAdd;   
// htmlToAdd += "<p>" + myElements[i].text + ": " + myElements[i].href + "</p>";
javascript: (
  function () { 
      var myElements = document.getElementsByTagName("a");
      var node=document.createElement("ul");
      var title = document.createTextNode("Rss feeds on this page");
      node.appendChild(title);

      for (var i = 0; i < myElements.length; i++) {
        if (myElements[i].href.indexOf(".xml") > -1) {
            var listitem = document.createElement("li"); 
            var itemtext = document.createTextNode(myElements[i].text + myElements[i].href );
            listitem.appendChild(itemtext)
            node.appendChild(listitem);
          };

        }; 
        node.setAttribute("style","position: fixed; top: 10px; background-color: yellow; z-index: 100000000000000");
        document.getElementsByTagName('body')[0].appendChild(node);
        

  }()); 


javascript: (
  function () {     
    var jsCode = document.createElement('script');
    jsCode.setAttribute('src', 'http://www.sirrahmj.co.uk/bookmarklet.js');                    
    document.body.appendChild(jsCode);  

  }());
});


