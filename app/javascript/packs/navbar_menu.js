const navbarMenu = document.querySelector('.navbar-menu');
const navbarBurger = document.querySelector('.navbar-burger');

navbarBurger.addEventListener('click', () => {
    navbarMenu.classList.toggle('is-active');
    navbarBurger.classList.toggle('is-active');
})
