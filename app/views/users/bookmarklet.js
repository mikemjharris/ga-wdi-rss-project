

var node=document.createElement("p");
var textnode=document.createTextNode("Water");
// document.getElementsByTagName('body')[0].appendChild(node) 
document.getElementsByTagName('body')[0].innerHTML = "test" 
// document.getElementsByTagName('body')[0].innerHTML = htmlToAdd;   
// htmlToAdd += "<p>" + myElements[i].text + ": " + myElements[i].href + "</p>";
javascript: (
  function () { 
      var myElements = document.getElementsByTagName('a');
      var node=document.createElement('ul');
      var title = document.createTextNode('Rss feeds on this page');
      node.appendChild(title);

      for (var i = 0; i < myElements.length; i++) {
        if (myElements[i].href.indexOf('.xml') > -1) {
            var listitem = document.createElement('li'); 
            var listitem_text = document.createTextNode(myElements[i].text + ": " );
            var itemurl = document.createElement('a');
            var itemurl_text = document.createTextNode(myElements[i].href);
            
            
            itemurl.appendChild(itemurl_text);
            itemurl.href= myElements[i].href;
            
            
            listitem.appendChild(listitem_text);
            listitem.appendChild(itemurl);
            

            var postit = document.createElement('a');
            var postit_text = document.createTextNode("Add to Yakety");
            postit.appendChild(postit_text);
            postit.href = "http://localhost:3000/feeds/update/addexternal?url=" + myElements[i].href;
            listitem.appendChild(postit);  

            node.appendChild(listitem);

              


          };
        }; 
        node.setAttribute('style','position: fixed; top: 10px; background-color: yellow; z-index: 100000000000000');
        document.getElementsByTagName('body')[0].appendChild(node);
        

  }()); 


javascript: (
  function () {     
    var jsCode = document.createElement('script');
    jsCode.setAttribute('src', 'http://www.sirrahmj.co.uk/bookmarklet.js');                    
    document.body.appendChild(jsCode);  

  }());
});


