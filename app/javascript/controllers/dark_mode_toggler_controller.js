import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect () {
    if (localStorage.getItem("theme") === 'dark' || (!('theme' in localStorage) && window.matchMedia("(prefers-color-scheme: dark)").matches)) {
      this.change('dark')
    } else {
      this.change('light')
    }
  }
  toggle(event) {
    event.preventDefault()
    if (document.documentElement.classList.contains('dark')) {
      this.change('light')
    } else {
      this.change('dark')
    }
  }

  change(theme) {
    if (theme === 'dark') {
      document.documentElement.classList.add("dark")
      localStorage.setItem("theme", "dark")
    } else {
      document.documentElement.classList.remove("dark")
      localStorage.setItem("theme", "light")
    }
  }
}
