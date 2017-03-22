
var navbarBody = document.getElementById("navbar-body")

document.getElementById("navbar-header").onclick = function(element){
  var classList = element.target.classList
  if (classList.contains("active")){
    classList.remove("active")
    Velocity(navbarBody, "slideUp", { duration: 400 });
  } else {
    classList.add("active")
    Velocity(navbarBody, "slideDown", { duration: 400 });
  }
}

window.onresize = function(event) {

};

var tocBody = document.getElementById("toc-body")
var tocArrow = document.getElementById("toc-arrow")
if (tocBody){
  document.getElementById("toc-header").onclick = function(element){
    var classList = element.target.classList
    if (classList.contains("active")){
      classList.remove("active")
      Velocity(tocBody, "slideUp", { duration: 400 });
      Velocity(tocArrow, {rotateZ: "0deg"} , { duration: 400 });
    } else {
      classList.add("active")
      Velocity(tocBody, "slideDown", { duration: 400 });
      Velocity(tocArrow, {rotateZ: "180deg"} , { duration: 400 });
    }
  }
  tocBodyStyle = tocBody.style;
}

navbarBodyStyle = navbarBody.style || null;

window.onresize = function(event) {
    if (navbarBodyStyle && window.innerWidth > 768){
      navbarBodyStyle.display = null;
    }
    if (navbarBodyStyle && tocBodyStyle.display == "none" && window.innerWidth > 768){
      tocBodyStyle.display = null;
    }
};