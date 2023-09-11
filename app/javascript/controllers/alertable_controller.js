import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alertable"
export default class extends Controller {
  static targets = [ "link" ]

  close() {
    // this.linkTarget.closest("div.removeableAlert").remove();
    this.linkTarget.closest('div.removeAlertable').remove();
  }
}
