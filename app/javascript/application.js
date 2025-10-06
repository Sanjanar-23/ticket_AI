// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "@fortawesome/fontawesome-free";

import "bootstrap"
//= require chartkick
//= require Chart.bundle
import "chartkick"
import "Chart.bundle" // or "Chart.min"


// Chart.js
import Chart from "chart.js/auto"
import { Application } from "@hotwired/stimulus"
import ToggleController from "controllers/toggle_controller"

const application = Application.start()
application.register("toggle", ToggleController)
