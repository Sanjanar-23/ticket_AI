document.addEventListener("DOMContentLoaded", function() {
  var el = document.querySelector('.popup-message');
  if (el) {
    setTimeout(function() { el.style.display = 'none'; }, 3000);
  }
});
