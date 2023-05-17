document.addEventListener('DOMContentLoaded', () => {
  const urlParams = new URLSearchParams(window.location.search);
  const completedValueId = urlParams.get('completion');
  if (completedValueId) {
    const completedElement = document.querySelector(`#completion_${completedValueId}`);
    if (completedElement) {
      completedElement.style.display = 'block';
    } else {
      console.error(`Could not find element with id: #completion_${completedValueId}`);
    }
  }
});
