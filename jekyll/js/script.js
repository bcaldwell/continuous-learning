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
      Velocity(tocArrow, {rotateZ: "0deg"} , { duration: 400 });
    } else {
      classList.add("active")
      Velocity(tocBody, "slideDown", { duration: 400 });
      Velocity(tocArrow, {rotateZ: "180deg"} , { duration: 400 });
    }
  }
}
