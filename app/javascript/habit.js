function pullDown() {

  const habitsElement = document.querySelector('.habits-main');

  // habitsElement が存在しない場合、関数を抜ける
  if (!habitsElement) {
    return;
  }
  
  function saveCheckStateToLocalStorage(habits) {
    localStorage.setItem('habitsCheckState', JSON.stringify(habits));
  }

  function getCheckStateFromLocalStorage() {
    const savedState = localStorage.getItem('habitsCheckState');
    return savedState ? JSON.parse(savedState) : null;
  }

  const savedHabitsCheckState = getCheckStateFromLocalStorage();
  const habits = JSON.parse(habitsElement.dataset.habits).map(habit => {
    const savedHabit = savedHabitsCheckState ? savedHabitsCheckState.find(saved => saved.id === habit.id) : null;
    return { ...habit, check: savedHabit ? savedHabit.check : habit.check === 'true' };
  });

  function updateAchievementRate() {
    const checkedHabits = habits.filter(habit => habit.check);
    const achievementRate = (checkedHabits.length / habits.length) * 100;
    document.getElementById('achievement-rate').textContent = achievementRate.toFixed(0);
  }

  function onHabitCheckboxChange(e, habitId) {
    const habit = habits.find(habit => habit.id === habitId);
    habit.check = e.target.checked;

    // データベースにチェックの変更を保存する処理
    updateHabitCheck(habitId, habit.check);

    // ここでlocalStorageにチェック状態を保存
    saveCheckStateToLocalStorage(habits);

    updateAchievementRate();
  }

  function updateHabitCheck(habitId, isChecked) {
    fetch(`/habits/${habitId}/update_check`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ check: isChecked })
    });
  }

  function saveHabitAchievement(habitId, achieved) {
    fetch(`/habits/${habitId}/save_achievement`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ achieved: achieved })
    });
  }

  function resetChecksAtMidnight() {
    const now = new Date();
    const tomorrow = new Date(now.getFullYear(), now.getMonth(), now.getDate() + 1);
    const timeUntilMidnight = tomorrow - now;

    setTimeout(() => {
      habits.forEach(habit => {
        // 達成率をデータベースに保存
        saveHabitAchievement(habit.id, habit.achieved);

        // チェックと達成率をリセット
        habit.check = false;
        habit.achieved = 0;

        // データベースのチェックをリセットする処理
        updateHabitCheck(habit.id, habit.check);
      });

      // 達成率をリセット
      updateAchievementRate();

      // 画面のチェックボックスをリセット
      renderHabits();

      // 再度タイマーを設定
      resetChecksAtMidnight();
    }, timeUntilMidnight);
  }

  function addArrowEventListeners() {
    const habitsList = document.getElementById('habits-list');
    const pullDownButtons = habitsList.getElementsByClassName("v-arrow");
    const pullDownButtonLists = habitsList.getElementsByClassName("arrow-pull-down");

    Array.from(pullDownButtons).forEach((pullDownButton, index) => {
      pullDownButton.addEventListener("click", function () {
        const pullDownButtonList = pullDownButtonLists[index];
        if (pullDownButtonList.getAttribute("style") == "display:block;") {
          pullDownButtonList.removeAttribute("style");
        } else {
          pullDownButtonList.setAttribute("style", "display:block;");
        }
      });
    });
  }


  function renderHabits() {
    const habitsList = document.getElementById('habits-list');
    habitsList.innerHTML = '';
  
    habits.forEach(habit => {
      const habitDiv = document.createElement('div');
      habitDiv.className = 'habit';
  
      // arrow-boxを追加
      const arrowBox = document.createElement('div');
      arrowBox.className = 'arrow-box';
  
      const arrowImg = document.createElement('img');
      arrowImg.className = 'v-arrow';
      arrowImg.src = '/assets/arrow.png'; // 画像ファイルのURLを適切に設定してください。
      arrowBox.appendChild(arrowImg);
  
      const arrowPullDown = document.createElement('div');
      arrowPullDown.className = 'arrow-pull-down';
  
      const editLink = document.createElement('div');
      editLink.className = 'content-post-link-p';
      editLink.innerHTML = `<a href="/habits/${habit.id}/edit" data-method="get">編集</a>`;
      arrowPullDown.appendChild(editLink);
  
      const deleteLink = document.createElement('div');
      deleteLink.className = 'content-post-link-p';
      deleteLink.innerHTML = `<a href="/habits/${habit.id}" data-method="delete">削除</a>`;
      arrowPullDown.appendChild(deleteLink);
  
      arrowBox.appendChild(arrowPullDown);
      habitDiv.appendChild(arrowBox);
  
      // ここまで arrow-boxの追加
  
      const habitCheckbox = document.createElement('input');
      habitCheckbox.type = 'checkbox';
      habitCheckbox.className = 'habit-checkbox';
      habitCheckbox.checked = habit.check;
      habitCheckbox.addEventListener('change', (e) => onHabitCheckboxChange(e, habit.id));
      habitDiv.appendChild(habitCheckbox);
  
      const habitItem = document.createElement('div');
      habitItem.className = 'habit-item';
      habitItem.textContent = habit.item;
      habitDiv.appendChild(habitItem);
  
      habitsList.appendChild(habitDiv);
    });
  
    // 描画後にarrowイベントリスナーを追加
    addArrowEventListeners();
  }
  

  // 初期化処理
  function init() {
    // 習慣リストを描画
    renderHabits();

    // 達成率を更新
    updateAchievementRate();

    // 真夜中にチェックボックスをリセット
    resetChecksAtMidnight();
  }

  // 初期化処理を実行
  init();

}
document.addEventListener('DOMContentLoaded', pullDown);

