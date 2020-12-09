const commentButtons = document.querySelectorAll('.comment-button');
const commentForms = document.querySelectorAll('.comment-form');

let numOfPairs = commentButtons.length;


for (let i = 0; i < numOfPairs; i++) {
    commentButtons[i].addEventListener('click', () => {
        commentForms[i].classList.toggle('invisible');
    })
}