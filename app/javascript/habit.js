document.addEventListener("DOMContentLoaded", () => {
  const checkboxes = document.querySelectorAll(".habit-checkbox");
  const achievementRateElement = document.querySelector(".achievement-rate");

  checkboxes.forEach((checkbox) => {
    checkbox.addEventListener("change", (event) => {
      // Ajax call to update the achieved status in the database
      const habitId = event.target.dataset.habitId;
      const achieved = event.target.checked;

      // calculate the achievement rate
      const totalHabits = checkboxes.length;
      const achievedHabits = Array.from(checkboxes).filter((checkbox) => checkbox.checked).length;
      const achievementRate = (achievedHabits / totalHabits) * 100;
      achievementRateElement.textContent = achievementRate.toFixed(1);

      // Add effect
      if (achieved) {
        event.target.parentElement.classList.add("habit--achieved");
      } else {
        event.target.parentElement.classList.remove("habit--achieved");
      }

      // Update the achieved status in the database
      const csrfToken = document.querySelector("meta[name=csrf-token]").content;
      fetch(`/habits/${habitId}`, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken
        },
        body: JSON.stringify({ habit: { achieved: achieved } })
      })
        .then((response) => response.json())
        .catch((error) => console.error("Error:", error));
    });
  });

  // Initialize achievement rate on page load
  const totalHabits = checkboxes.length;
  const achievedHabits = Array.from(checkboxes).filter((checkbox) => checkbox.checked).length;
  const achievementRate = (achievedHabits / totalHabits) * 100;
  achievementRateElement.textContent = achievementRate.toFixed(1);
});

