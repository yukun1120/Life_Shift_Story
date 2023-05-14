// document.addEventListener("DOMContentLoaded", init);

  function init() {
      const checkboxes = document.querySelectorAll(".habit-checkbox");
      const roundedNumberElement = document.getElementById("achievement-rate");
      const userIdElement = document.querySelector(".user_name");
      const userId = userIdElement ? userIdElement.dataset.user_id : null;

      checkboxes.forEach((checkbox) => {
        const habitId = checkbox.dataset.habitId;
        checkbox.checked = checkbox.dataset.check === "true";
        checkbox.addEventListener("change", (event) => {
          updateCheckboxState(habitId, checkbox.checked);
          updateAchievementRate();
        });
      });


    function updateCheckboxState(habitId, checked) {
      if (userId) {
        console.log("Sending PATCH request for habitId:", habitId, "checked:", checked);
        fetch(`/habits/update_checkbox_state`, {
          method: "PATCH",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
          },
          body: JSON.stringify({ habit_id: habitId, check: checked, user_id: userId }),
        })
        .then(response => {
          if (response.ok) {
            console.log("Request successful:", response);
          } else {
            console.log("Request failed:", response);
          }
          return response.json();
        })
        .then(data => {
          console.log("Response data:", data);
        })
        .catch(error => {
          console.log("Error during fetch:", error);
        });
      }
    }
    
    

    function updateAchievementRate() {
      const totalHabits = checkboxes.length;
      const achievedHabits = Array.from(checkboxes).filter((checkbox) => checkbox.checked).length;
      const achievementRate = (achievedHabits / totalHabits) * 100;
      const roundedNumber = Math.round(achievementRate);
      roundedNumberElement.textContent = roundedNumber;
      localStorage.setItem("achievement_rate", roundedNumber);
    }

    updateAchievementRate();

    function resetHabitsAtMidnight() {
      const now = new Date();
      const tomorrow = new Date(now.getFullYear(), now.getMonth(), now.getDate() + 1);
      const timeUntilMidnight = tomorrow - now;

      setTimeout(() => {
        // Save achievement rate to the server
        if (userId) {
          const achievementRate = localStorage.getItem("achievement_rate");
          fetch("/habits/update_achievement_rate", {
            method: "PATCH",
            headers: {
              "Content-Type": "application/json",
              "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
            },
            body: JSON.stringify({ achievement_rate: achievementRate, user_id: userId }),
          });
        }

        // Reset checkboxes
        checkboxes.forEach((checkbox) => {
          const habitId = checkbox.dataset.habit_id;
          checkbox.checked = false;
          updateCheckboxState(habitId, false);
        });

        updateAchievementRate();
        resetHabitsAtMidnight();
      }, timeUntilMidnight);
    }

    resetHabitsAtMidnight();

  };

window.addEventListener('load', init);