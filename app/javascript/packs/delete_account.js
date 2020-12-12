const modal = document.querySelector('#delete-account-modal');
const modalOpenButton = document.querySelector('#delete-account-modal-open-button');
const modalBackground = document.querySelector('#delete-account-modal-background');
const modalCloseButton = document.querySelector('#delete-account-modal-close');

modalOpenButton.addEventListener('click', () => {
    modal.classList.toggle('is-active');
})

modalBackground.addEventListener('click', () => {
    modal.classList.toggle('is-active');
})

modalCloseButton.addEventListener('click', () => {
    modal.classList.toggle('is-active');
})