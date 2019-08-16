# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# CSS
Rails.application.config.assets.precompile += %w[
  css_dashboard/bootstrap.css fonts/font-awesome.css
  css_dashboard/animate.css css_dashboard/prettify.css css_dashboard/toastr.min.css
  css_dashboard/magnific-popup.css css_dashboard/style.css css_dashboard/calendar.css
  custom.css jsCalendar.css intlTelInput.css toggle.scss
]

# JS
Rails.application.config.assets.precompile += %w[
  calendar.min.js template-script.js template-script.min.js
  template-init.js template-init.min.js underscore.js moments.js
  peity.min.js jquery/jquery-1.12.3.min.js pace/pace.min.js jquery/jquery-1.12.3.min.js
  bootstrap/js/bootstrap.min.js nano-scroller/nano-scroller.js google-code-prettify/prettify.js custom/custom.js
  toastr/toastr.min.js chart-js/chart.min.js magnific-popup/jquery.magnific-popup.min.js
  template-script.min.js template-init.min.js jquery_ujs.js jsCalendar.js bootstrap/tab.js
  utils.js intlTelInput.js libphonenumber/utils.js profile/resume_size.js bootstrap-notify.js
  mwp_app/index.js
]
