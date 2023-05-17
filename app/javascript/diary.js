document.addEventListener('DOMContentLoaded', function () {
  const titleInput = document.getElementById("diary_title");
  const contentInput = document.getElementById("diary_content");

  // Check if elements exist
  if (!titleInput || !contentInput) {
    return;
  }

  const charCounter = document.createElement("span");
  charCounter.className = "char-counter";

  titleInput.parentNode.insertBefore(charCounter, titleInput.nextSibling);

  function updateCharCounter() {
    const currentLength = contentInput.value.length;
    charCounter.textContent = `${currentLength} 文字`;
  }

  updateCharCounter();

  titleInput.addEventListener("input", function () {
    updateCharCounter();
  });

  contentInput.addEventListener("input", function () {
    updateCharCounter();
  });
});