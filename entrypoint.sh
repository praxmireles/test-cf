RAILS_ENV=$RAILS_ENV bundle exec rake db:schema:load db:seed db:migrate
RAILS_ENV=$RAILS_ENV bundle exec rails server