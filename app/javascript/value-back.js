function value() {
  const articles = document.querySelectorAll(".value-main");
  articles.forEach(function(values) {
    values.addEventListener('mouseover', function() {
      this.setAttribute("style", "box-shadow: 0 10px 25px 0 rgba(0, 0, 0, 0.5);");
    });
    values.addEventListener('mouseout', function() {
      this.removeAttribute("style", "box-shadow: 0 10px 25px 0 rgba(0, 0, 0, 0.5);");
    });
  });
}

window.addEventListener("load", value);