$(document).ready(function () {
  const savedDiaryDate = localStorage.getItem("diaryDate");
  const currentDate = new Date().toISOString().slice(0, 10);

  if (savedDiaryDate !== currentDate) {
    localStorage.removeItem("diaryTitle");
    localStorage.removeItem("diaryContent");
    localStorage.setItem("diaryDate", currentDate);
  }

  const titleInput = $("#diary_title");
  const contentInput = $("#diary_content");
  const charCounter = $("<span>").addClass("char-counter");

  titleInput.after(charCounter);

  titleInput.val(localStorage.getItem("diaryTitle"));
  contentInput.val(localStorage.getItem("diaryContent"));

  function updateCharCounter() {
    const currentLength = titleInput.val().length + contentInput.val().length;
    charCounter.text(`${currentLength} 文字`);
  }

  updateCharCounter();

  titleInput.on("input", function () {
    localStorage.setItem("diaryTitle", titleInput.val());
    updateCharCounter();
  });

  contentInput.on("input", function () {
    localStorage.setItem("diaryContent", contentInput.val());
    updateCharCounter();
  });
});
