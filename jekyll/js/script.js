window.onload = function() {
  var tocHeader = document.getElementById("toc-header")
  var tocBody = document.getElementById("markdown-toc")
  var tocArrow = document.getElementById("toc-arrow")

  if (tocBody){
    var classList = tocHeader.classList
    classList.add("active")
    tocHeader.onclick = function(element){
      if (classList.contains("active")){
        classList.remove("active")
        Velocity(tocBody, "slideUp", { duration: 400 });
        Velocity(tocArrow, {rotateZ: "0deg"} , { duration: 0 });
        Velocity(tocArrow, {rotateZ: "180deg"} , { duration: 400 });
      } else {
        classList.add("active")
        Velocity(tocBody, "slideDown", { duration: 400 });
        Velocity(tocArrow, {rotateZ: "360deg"} , { duration: 400 });
      }
    }
  }

  // velocity href scrolling
  var hrefs = document.querySelectorAll('a[href*="#"]')
  for(i = 0; i < hrefs.length;i++) {
    hrefs[i].addEventListener('click', function(event){
      event.preventDefault();
      event.stopPropagation();

      // set target to anchor's "href" attribute
      var targetID = event.target.getAttribute('href');
      var target = document.getElementById(targetID.substring(1))
      // scroll to each target
      Velocity(target, "scroll" , { duration: 400, offset: -20, easing: 'ease-in-out' });
    })
  }
}
