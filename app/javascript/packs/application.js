// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// Bootstrap をインクルード
import "bootstrap/dist/js/bootstrap"
// FontAwesome をインクルード
import "@fortawesome/fontawesome-free/js/all"
// jscroll をインクルード
import "jscroll/dist/jquery.jscroll.min"
import "./preview"
import "./photos_preview"
import "./post_edit"
import "./jquery.validate"
import "./jquery.validate.min"
import "./validate_rules"
import "./jscroll"
import "./search"
// import "chartkick/chart.js"
import "chartkick/highcharts"
import "./collapse"
import "./post-show"
import "./comment"

Rails.start()
Turbolinks.start()
ActiveStorage.start()
