const fileInput = document.querySelectorAll('.file-input');
const filenameDisplay = document.querySelectorAll('.file-name');

for (let i = 0; i < fileInput.length; i++) {
    fileInput[i].addEventListener('change', () => {
        let uploadedFilename = fileInput[i].files[0].name;
        filenameDisplay[i].textContent = uploadedFilename;
    })
}
