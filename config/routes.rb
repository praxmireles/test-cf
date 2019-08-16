# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  %w[404 422 500].each do |http_code|
    get http_code, to: 'errors_http#show', http_code: http_code
  end

  get  'experts/terms' => 'pages#terms', as: 'expert_terms'
  get  'clients/terms' => 'pages#terms', as: 'client_terms'
  get  'privacy' => 'pages#privacy', as: 'privacy'
  get 'pdf/expert_invoice'
  get 'pdf/client_invoice'
  get 'admin/login' => 'admin_sessions#new', as: 'admin_login'
  post 'admin/login' => 'admin_sessions#create', as: 'admin_session'
  get 'admin/logout' => 'admin_sessions#destroy', as: 'admin_logout'
  get 'auth/stripe_connect/callback',
      to: 'authentications#stripe_callback'

  post 'stripe/webhook' => 'stripe#webhook', as: 'stripe_webhook'

  namespace :admin do
    # resources :access_tokens
    resources :admin_users
    resources :customer_services
    resources :finances
    resources :interviewers

    resources :pending_applicants
    resources :configurations
    # resources :appointments
    # resources :appointment_packs
    # resources :availabilities
    # resources :billings
    # resources :cards
    # resources :career_highlights
    resources :contact_informations
    # resources :education_histories
    # resources :industries
    # resources :industry_experiences
    # resources :introductions
    resources :invoices
    # resources :job_functions
    resources :languages
    # resources :notifications
    # resources :payments
    # resources :profiles
    resources :profile_industries
    resources :profile_job_functions
    resources :profile_languages
    resources :profile_seniority_levels
    resources :profile_skills
    resources :ratings
    # resources :receipts
    # resources :requests
    resources :search_histories
    # resources :seniority_levels
    resources :services
    resources :skills
    resources :timezones
    resources :users
    # resources :work_histories
    # resources :customer_services
    # resources :finances
    # resources :interviewers
    resources :cancelled_appointments
    resources :closed_appointments
    resources :completed_appointments
    resources :in_progress_appointments
    resources :open_appointments
    resources :scheduled_appointments
    resources :cancelled_appointment_packs
    resources :completed_appointment_packs
    resources :in_progress_appointment_packs
    resources :open_appointment_packs
    resources :scheduled_appointment_packs
    # resources :new_notifications
    # resources :read_notifications
    resources :accepted_requests
    resources :cancelled_requests
    resources :pending_requests
    resources :rejected_requests
    resources :coachings
    resources :express_advices
    resources :mentorings
    resources :project_in_minds
    resources :clients
    resources :experts

    root to: 'pending_applicants#index'
  end

  # TODO: protect thee endpoints with basic auth
  mount Sidekiq::Web => '/sidekiq'
  mount PgHero::Engine, at: 'pghero'

  get 'auth/:provider/callback' => 'authentications#create'
  get 'auth/failure' => redirect('/')
  get 'login' => 'sessions#new'
  get 'experts/login' => 'sessions#new_expert'
  get 'experts/terms_services' => 'sessions#terms_services_experts'
  get 'clients/terms_services' => 'sessions#terms_services_clients'
  get 'clients/login' => 'sessions#new_client'
  get 'logout' => 'sessions#destroy'

  scope :sessions, controller: :sessions do
    delete 'destroy'
    get 'new'
  end

  scope :authentication, controller: :authentications do
    get 'login' => 'sessions#new', as: 'clients'
    post 'login'
  end

  # TODO: remove this path and controller. We only need Client and Expert edit
  scope :users, controller: :users do
    get 'edit'
    get 'edit_profile', as: 'edit_profile'
    post 'add_files', as: 'user_add_files'
  end

  scope :clients, controller: :clients do
    get 'dashboard', as: 'client_dashboard'
    get 'reload_dashboard', as: 'render_client_dashboard'
    get 'profile', as: 'client'
    get 'edit', as: 'client_settings'
    get 'experts_search', as: 'clients_experts_search'
    get 'modal/:appointment_id', action: 'modal', as: 'modal'
    get 'billing', as: 'client_billings'
    get 'invoices', as: 'client_invoices'
    put '/', action: :onboarding_update, as: 'onboarding_update'
    put '/', action: :update, as: 'update_clients'
    get 'welcome', as: 'client_welcome'
    get 'experts_match', as: 'client_experts_match'
    get 'notification', as: 'client_notifications'

    scope :payments, controller: :payments do
      post '/', action: :create, as: 'pre_authorize_payment'
      post 'pay_package', action: :pay_package, as: 'pay_package'
    end

    scope :onboarding, controller: :clients_onboarding do
      get 'booking'
      get 'confirmation'
      get 'services'
      get 'industries'
      get 'skills'
      get 'descriptions'
      get 'what_changes'
      get 'achieve_experiences'
      get 'seniority_levels'
      get 'coaching_type'
    end

    get '/:id/apointments/new', action: :new,
                                controller: :appointments,
                                as: 'new_client_open_appointments'
    post '/:id/apointments/new', action: :create,
                                 controller: :appointments,
                                 as: 'create_client_open_appointments'

    get 'payment/billing', action: :billing,
                           controller: :clients_information,
                           as: 'client_payment_billing'
    get 'payment/checkout', action: :payment,
                            controller: :clients_information,
                            as: 'client_payment_card'
    get 'payment/contacts', action: :contacts,
                            controller: :clients_information,
                            as: 'client_payment_contact_information'

    get 'package_payments/checkout', action: :checkout,
                                     controller: :package_payments,
                                     as: 'appointment_pack_checkout'
  end

  scope :cards, controller: :cards do
    get '/', action: :index
    post '/', action: :create
    delete '/:card_id', action: :destroy
  end

  scope :billings, controller: :billings do
    get '/new', action: :new, as: 'new_client_billings'
    post '/', action: :create
    put '/', action: :update
    delete '/:billing_id', action: :destroy
  end

  scope :search, controller: :search_histories do
    post 'create'
    get 'index'
  end

  scope :experts, controller: :experts do
    get 'dashboard', as: 'expert_dashboard'
    get 'reload_dashboard', as: 'render_expert_dashboard'
    get 'confirmation'
    get 'profile/:id', action: 'profile', as: 'expert'
    put '/', action: :update
    get 'modal/:appointment_id', action: 'modal', as: 'modal_expert'
    get 'balance', as: 'balance_expert'
    get 'notification', as: 'expert_notifications'

    scope 'onboarding', controller: :experts_onboarding do
      get 'welcome', as: 'expert_onboarding'
      get 'general_information'
      get 'resume'
      get 'services', as: 'experts_onboarding_services'
      get 'education_history'
      get 'languages'
      get 'seniority_level'
      get 'work_industries'
      get 'positions'
      get 'career_highlights'
      get 'skills', as: 'job_function'
      get 'about'
      get 'calendar'
      get 'confirmation'
      get 'top_level_seniority'
      get 'schedule'
      get 'degrees'
      get 'summary'
    end

    scope 'edit', controller: :experts_onboarding do
      get 'general_information'
      get 'resume'
      get 'services'
      get 'education_history'
      get 'languages'
      get 'seniority_level'
      get 'work_industries'
      get 'positions'
      get 'career_highlights'
      get 'skills'
      get 'about'
      get 'calendar'
      get 'confirmation'
      get 'top_level_seniority'
      get 'schedule'
      get 'degrees'
      get 'summary'
    end

    get '/:id/appointments/by_month', action: :list_available_date_by_month,
                                      controller: :experts,
                                      as: 'expert_availabilities_by_month'
    get '/:id/appointments/availabilities_booking_for_list', action: :availabilities_booking_for_list,
                                                             controller: :experts,
                                                             as: 'availabilities_booking_for_list'

    get '/:id/availabilities', action: 'availabilities',
                               as: 'expert_availabilities'

    scope :availabilities, controller: :availabilities do
      get 'new'
      post '/', action: :create, as: 'create_availabilities'
    end

    scope :profile, controller: :profiles do
      put '/', action: :update, as: 'update_profile'
      delete '/:id', action: :destroy, as: 'destroy_profile'
    end

    scope :profile_industries, controller: :profile_industries do
      post '/', action: :create, as: 'create_profile_industry'
      get '/:profile_industry_id/edit', action: :edit,
                                        as: 'edit_profile_industry'
      put '/:profile_industry_id', action: :update,
                                   as: 'update_profile_industry'
      delete '/:profile_industry_id', action: :destroy,
                                      as: 'destroy_profile_industry'
    end

    scope :profile_job_functions, controller: :profile_job_functions do
      post '/', action: :create, as: 'create_job_function'
      delete '/:profile_job_function_id', action: :destroy,
                                          as: 'destroy_job_function'
    end

    scope :profile_languages, controller: :profile_languages do
      post '/', action: :create, as: 'create_profile_languages'
      delete '/:profile_language_id', action: :destroy,
                                      as: 'destroy_profile_language'
    end

    scope :profile_seniority_levels, controller: :profile_seniority_levels do
      post '/', action: :create, as: 'create_seniroity_levels'
      delete '/:profile_seniority_level_id', action: :destroy,
                                             as: 'destroy_seniroity_levels'
    end

    scope :profile_skills, controller: :profile_skills do
      post '/', action: :create
      delete '/:profile_skill_id', action: :destroy
    end

    scope :work_histories, controller: :work_histories do
      post '/', action: :create
      get '/:work_history_id/edit', action: :edit,
                                    as: 'edit_work_history'
      put '/:work_history_id', action: :update, as: 'update_work_history'
      delete '/:work_history_id', action: :destroy, as: 'destroy_work_history'
    end

    scope :education_histories, controller: :education_histories do
      post '/', action: :create
      get '/:education_history_id/edit', action: :edit,
                                         as: 'edit_education_history'
      put '/:education_history_id', action: :update,
                                    as: 'update_education_history'
      delete '/:education_history_id', action: :destroy,
                                       as: 'destroy_education_history'
    end

    scope :career_highlights, controller: :career_highlights do
      post '/', action: :create
      get '/:career_highlight_id/edit', action: :edit,
                                        as: 'edit_career_highlight'
      put '/:career_highlight_id', action: :update,
                                   as: 'update_career_highlight'
      delete '/:career_highlight_id', action: :destroy,
                                      as: 'destroy_career_highlight'
    end

    scope :expert_services, controller: :expert_services do
      post '/', action: :create, as: 'create_expert_services'
      delete '/:expert_service_id', action: :delete,
                                    as: 'destroy_expert_service'
    end

    scope :contact_informations, controller: :contact_informations do
      post '/', action: :create
      put '/:contact_information_id', action: :update
      delete '/:contact_information_id', action: :destroy
    end
  end

  scope :appointments, controller: :appointments do
    get '/new', action: :new, as: 'new_apppointment'
    get '/:appointment_id', action: :show, as: 'appointment'
    get '/:appointment_id/edit', action: :edit, as: 'edit_appointment'
    put '/:appointment_id', action: :update, as: 'update_appointment'
    delete '/:appointment_id', action: :destroy, as: 'destroy_appointment'
    get '/:appointment_id/checkout',
        action: :checkout,
        as: 'checkout_appointment'
    get '/:id/rate/show', controller: :ratings, action: :show
  end

  get '/appointment/suggests_diferent_time_save', action: :appointment_suggests_save,
                                                  controller: :appointments,
                                                  as: 'appointment_suggests_save'

  get '/appointment/suggests_diferent_time_acept', action: :appointment_suggests_accept,
                                                   controller: :appointments,
                                                   as: 'appointment_suggests_accept'

  get 'appointment_packs/add', action: :add,
                               controller: :appointment_packs,
                               as: 'appointment_packs_add'

  scope :appointment_packs, controller: :appointment_packs do
    get '/new', action: :new, as: 'new_client_appointment_packs'
    post '/', action: :create, as: 'create_client_appointment_packs'
    delete '/:appointment_pack_id', action: :destroy, as: 'destroy_client_appointment_packs'
    get '/:appointment_pack_id', action: :show, as: 'client_appointment_packs'
    get '/calendar/next_week', action: :next_week, as: 'calendar_next_week'
    get '/calendar/previous_week', action: :previous_week, as: 'calendar_previous_week'
    get '/calendar/summary', action: :summary, as: 'calendar_summary'
  end

  scope :requests, controller: :requests do
    get '/:request_id/edit', action: :edit, as: 'edit_request'
    post '/', action: :create, as: 'create_request'
    put '/:request_id', action: :update, as: 'update_request'
    delete '/:request_id', action: :destroy, as: 'destroy_request'
  end

  scope :video_conferences, controller: :video_conferences do
    get '/:appointment_id', action: :show, as: 'video_conference'
    delete '/:appointment_id', action: :destroy, as: 'end_video_conference'
  end

  scope :notifications, controller: :notifications do
    get '/', action: :index
    post '/', action: :create
    get 'read_one/:notification_id', action: :read_one, as: 'read_one'
    delete '/:notification_id', action: :destroy
    get :check_notification
  end

  scope :invoices, controller: :invoices do
    get '/:invoice_id', action: :show
    get '/', action: :index
  end

  scope :search_histories, controller: :search_histories do
    get 'previous'
    get '/', action: :index, as: 'search_histories'
    get '/:search_history_id', action: :show, as: 'search_history'
    put '/:search_history_id', action: :update, as: 'update_search_history'
    post '/', action: :create, as: 'create_search_history'
  end

  scope :pending_applicants, controller: :pending_applicants do
    get '/:id', action: :update, as: 'update_pending_applicant'
  end

  scope :payouts, controller: :payouts do
    get 'disconnect_stripe', action: :destroy, as: 'disconnect_stripe'
    post '/', action: :create, as: 'withdraw_fund'
  end

  scope :ratings, controller: :ratings do
    get '/rate/save', action: :save
  end

  resources :locales, only: :update

  root 'sessions#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
