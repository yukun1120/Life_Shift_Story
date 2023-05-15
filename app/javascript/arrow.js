function arrow() {
  const pullDownButtons = document.getElementsByClassName("v-arrow");
  const pullDownButtonLists = document.getElementsByClassName("arrow-pull-down");

  Array.from(pullDownButtons).forEach((pullDownButton, index) => {
    pullDownButton.addEventListener("click", function() {
      console.log("ok")
      const pullDownButtonList = pullDownButtonLists[index];
      if (pullDownButtonList.getAttribute("style") == "display:block;") {
        pullDownButtonList.removeAttribute("style");
      } else {
        pullDownButtonList.setAttribute("style", "display:block;");
      }
    });
  });
}

document.addEventListener('DOMContentLoaded', arrow);
