# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "chartkick" # @5.0.1
pin "Chart.bundle", to: "Chart.bundle.min.js", preload: true
pin "chart.js" # @4.5.0
pin "@kurkle/color", to: "@kurkle--color.js" # @0.3.4
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@fortawesome/fontawesome-free", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.1.1/js/all.js"


pin "chartkick", to: "chartkick.js"
pin "chart.js", to: "chart.js"
pin "Chart.bundle", to: "Chart.bundle.js" # or "Chart.min.js" depending on your preference
pin "@fortawesome/fontawesome-free", to: "@fortawesome--fontawesome-free.js" # @7.0.1
