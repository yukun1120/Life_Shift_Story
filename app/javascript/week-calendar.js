function setupEventListeners() {
  const thArray = Array.from(document.querySelectorAll('.table-striped th'));
  thArray.forEach(function(th) {
    th.addEventListener('click', function(event) {
      const clickedDate = th.dataset.day;
      console.log(clickedDate);
      fetchSchedule(clickedDate); 
    });
  });
}

document.addEventListener('DOMContentLoaded', setupEventListeners);


function fetchSchedule(date) {
  fetch(`/fetch_schedule?date=${date}`)
    .then(response => response.json())
    .then(data => {
      let essentialBottom = document.querySelector('.essential-bottom');
      let essentialSchedules = document.querySelector('.essential-schedules');
      essentialSchedules.innerHTML = '';  // Clear the existing schedules

      // Create new schedule entries for the fetched data
      data.forEach(item => {
        let flexSchedule = document.createElement('div');
        flexSchedule.className = 'flex-schedule';

        let li = document.createElement('li');

        let timeBox = document.createElement('div');
        timeBox.className = 'time-box';
        let startTime = document.createElement('span');
        startTime.className = 'start_time';
        startTime.textContent = new Date(item.start_time).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
        let endTime = document.createElement('span');
        endTime.className = 'end_time';
        endTime.textContent = new Date(item.end_time).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
        timeBox.appendChild(startTime);
        timeBox.appendChild(endTime);

        let area = document.createElement('div');
        area.className = 'area';

        let schBox = document.createElement('div');
        schBox.className = 'sch_box';
        let schTitle = document.createElement('p');
        schTitle.className = 'sch_title';
        schTitle.textContent = item.title;
        let schTx = document.createElement('p');
        schTx.className = 'sch_tx';
        schTx.textContent = item.content;
        schBox.appendChild(schTitle);
        schBox.appendChild(schTx);

        let endPoint = document.createElement('div');
        endPoint.className = 'end_point';

        area.appendChild(schBox);
        area.appendChild(endPoint);

        li.appendChild(timeBox);
        li.appendChild(area);

        flexSchedule.appendChild(li);

        essentialSchedules.appendChild(flexSchedule);
      });

      essentialBottom.appendChild(essentialSchedules);
    });
}
