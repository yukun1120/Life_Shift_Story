document.addEventListener('DOMContentLoaded', () => {
  const checkboxes = document.querySelectorAll('.habit-checkbox');
  if (checkboxes.length > 0) { // Check if '.habit-checkbox' elements exist
    checkboxes.forEach((checkbox) => {
      checkbox.addEventListener('change', (event) => {
        const habit_id = event.target.dataset.habitId; 
        const checked = event.target.checked;
        fetch('/habits/' + habit_id, {
          method: 'PATCH',
          headers: {
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({ habit: { check: checked } })
        })
        .then(() => {
          // API呼び出し後に達成率を更新
          updateAchievementRate();
        });
      });
    });
  }

  function updateAchievementRate() {
    const checkboxes = document.querySelectorAll('.habit-checkbox');
    const total = checkboxes.length;
    const completed = Array.from(checkboxes).filter(checkbox => checkbox.checked).length;
    
    const achievementRate = (completed / total) * 100;
    const roundedAchievementRate = Math.round(achievementRate * 100) / 100;
    const achievementRateElement = document.getElementById('achievement-rate');
    if (achievementRateElement !== null) { // Check if '#achievement-rate' element exists
      achievementRateElement.textContent = ` ${roundedAchievementRate}`;
    }
  }

  if (document.querySelector('.habit-checkbox')) { // Run updateAchievementRate only if '.habit-checkbox' elements exist
    updateAchievementRate();
  }
});
