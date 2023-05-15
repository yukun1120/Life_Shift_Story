function habit() {
  const articles = document.querySelectorAll(".habit");
  articles.forEach(function(habits) {
    habits.addEventListener('mouseover', function() {
      this.setAttribute("style", "box-shadow: 0 10px 25px 0 rgba(0, 0, 0, 0.5);");
    });
    habits.addEventListener('mouseout', function() {
      this.removeAttribute("style", "box-shadow: 0 10px 25px 0 rgba(0, 0, 0, 0.5);");
    });
  });
}

window.addEventListener("load", habit);