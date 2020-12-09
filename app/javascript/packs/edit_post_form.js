const editButtons = document.querySelectorAll('.edit-post-button');
const editForms = document.querySelectorAll('.edit-post-form');
const postBodies = document.querySelectorAll('.post-body');

let numOfPairs = editButtons.length;
console.log(editButtons);
console.log(editForms);

for (let i = 0; i < numOfPairs; i++) {
    editButtons[i].addEventListener('click', () => {
        editForms[i].classList.toggle('invisible');
        postBodies[i].classList.toggle('invisible');
    })
}