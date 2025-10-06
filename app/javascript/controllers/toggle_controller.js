import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["hideable"]

  call(event) {
    event.preventDefault();
    const sidebar = this.hideableTarget;
    const openBtn = document.getElementById('open-sidebar');
    const closeBtn = document.getElementById('close-sidebar');

    if (sidebar.classList.contains("d-none")) {
      sidebar.classList.remove("d-none");
      openBtn.classList.add("d-none");
      closeBtn.classList.remove("d-none");
    } else {
      sidebar.classList.add("d-none");
      openBtn.classList.remove("d-none");
      closeBtn.classList.add("d-none");
    }
  }
}
