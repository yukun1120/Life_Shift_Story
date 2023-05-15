document.addEventListener('DOMContentLoaded', function () {
  const savedDiaryDate = localStorage.getItem("diaryDate");
  const currentDate = new Date().toISOString().slice(0, 10);

  if (savedDiaryDate !== currentDate) {
    localStorage.removeItem("diaryTitle");
    localStorage.removeItem("diaryContent");
    localStorage.setItem("diaryDate", currentDate);
  }

  const titleInput = document.getElementById("diary_title");
  const contentInput = document.getElementById("diary_content");
  const charCounter = document.createElement("span");
  charCounter.className = "char-counter";

  titleInput.parentNode.insertBefore(charCounter, titleInput.nextSibling);

  titleInput.value = localStorage.getItem("diaryTitle") || "";
  contentInput.value = localStorage.getItem("diaryContent") || "";

  function updateCharCounter() {
    const currentLength = contentInput.value.length;
    charCounter.textContent = `${currentLength} 文字`;
  }

  updateCharCounter();

  titleInput.addEventListener("input", function () {
    localStorage.setItem("diaryTitle", titleInput.value);
    updateCharCounter();
  });

  contentInput.addEventListener("input", function () {
    localStorage.setItem("diaryContent", contentInput.value);
    updateCharCounter();
  });
});
