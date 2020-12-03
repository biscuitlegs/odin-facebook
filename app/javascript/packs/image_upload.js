const fileInput = document.querySelector('.file-input');
const filenameDisplay = document.querySelector('.file-name');

fileInput.addEventListener('change', () => {
    let uploadedFilename = fileInput.files[0].name;
    filenameDisplay.textContent = uploadedFilename;
})
