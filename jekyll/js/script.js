
var tocBody = document.getElementById("markdown-toc")
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
