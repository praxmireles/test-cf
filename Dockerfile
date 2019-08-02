# Use the barebones version of Ruby 2.5.1
FROM ruby:2.5.1

# Install dependencies:
# - build-essential: To ensure certain gems can be compiled
# - nodejs: Compile assets
# - libpq-dev: Communicate with postgres through the postgres gem
# - postgresql-client-9.4: In case you want to talk directly to postgres
#RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev postgresql-client-9.4.4 --fix-missing --no-install-recommends

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

RUN apt-get update
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils

ENV DEBIAN_FRONTEND teletype
RUN apt-get install dialog apt-utils -y

# Set an environment variable to store where the app is installed to inside of the Docker image.
ENV INSTALL_PATH /app
RUN mkdir -p $INSTALL_PATH

# This sets the context of where commands will be ran in and is documented on Docker's website extensively.
WORKDIR $INSTALL_PATH

# Copy current gems
COPY Gemfile Gemfile
COPY Gemfile.lock  Gemfile.lock

# For capybara-webkit
RUN apt-get install -y libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x xvfb libqtwebkit4 libqt4-dev
RUN apt-get install build-essential libgl1-mesa-dev libqtwebkit-dev -y
RUN apt-get install qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x qt4-qmake -y

RUN gem install bundler

# Finish establishing our Ruby enviornment
RUN bundle install

# Copy in the application code from your work station at the current directory over to the working directory.
COPY . .

# Symlink nodejs (source: https://github.com/nodejs/node-v0.x-archive/issues/3911)
RUN ln -s /usr/bin/nodejs /usr/bin/node

# Precompile assets
RUN bundle exec rake RAILS_ENV=$RAILS_ENV assets:clean assets:precompile

# Expose the PostgreSQL port
EXPOSE 5432

# Expose port 3000 and 80 to the Docker host, so we can access it from the outside.
EXPOSE 3000
EXPOSE 80

# Expose a volume so that nginx will be able to read in assets in production.
VOLUME ["$INSTALL_PATH/public"]

# Configure an entry point, so we don't need to specify "bundle exec" for each of our commands.
ENTRYPOINT ["bundle", "exec"]

# The default command that gets ran will be to start the Unicorn server.
CMD bundle exec unicorn -c config/unicorn.rb
