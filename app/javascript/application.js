// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "@fortawesome/fontawesome-free";

import "bootstrap"

import "chartkick";
import "chart.js/bundle";
import "chartkick/chart.js"

import { Application } from "@hotwired/stimulus"
import ToggleController from "controllers/toggle_controller"


const application = Application.start()
application.register("toggle", ToggleController)
