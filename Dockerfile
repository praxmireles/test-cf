# Use the barebones version of Ruby 2.5.1
FROM 051455035623.dkr.ecr.us-east-2.amazonaws.com/ruby-dev:latest

# Copy current gems
COPY Gemfile Gemfile
COPY Gemfile.lock  Gemfile.lock

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