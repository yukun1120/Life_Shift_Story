document.addEventListener("DOMContentLoaded", function() {
  const imageInput = document.getElementById('diary_images');
  if (imageInput) {
    imageInput.addEventListener('change', function(e){
      var imageContent = document.querySelector('#image-list');
      imageContent.innerHTML = "";
  
      var fileLength = this.files.length;
  
      for (let i = 0; i < fileLength; i++) {  // 'var'を'let'に変更
        let fileReader = new FileReader();  // 'var'を'let'に変更

        fileReader.onload = (function(file) {  // 関数を自己実行関数に変更
          return function(event) {
            var imgElement = document.createElement('img');
            imgElement.setAttribute('src', event.target.result);
            imgElement.setAttribute('class', 'image-element');
            imgElement.style.width = "270px";
            imgElement.style.height = "270px";
            imageContent.appendChild(imgElement);

            var targetElement = document.querySelector('.diary-content-index');
            if (targetElement) {
              targetElement.style.width = 'calc(100% - 280px)';
            }
          };
        })(e.target.files[i]);

        fileReader.readAsDataURL(e.target.files[i]);
      }
    });
  }
});
