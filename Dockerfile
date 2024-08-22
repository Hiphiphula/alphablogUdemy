FROM dockerhub.nutrifood.co.id/igeeks-developer/base-image-ruby:2.6.6

# Set argument.
ARG port=1301

# Set app name.
ENV APP_HOME /rd_storage/

# Set port.
ENV PORT=$port

# Set timezone.
ENV TZ="Asia/Jakarta"

# Set rails environment.
ENV RAILS_ENV=staging

# Build app dependencies from the Gemfile.
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME
RUN gem install bundler
RUN bundle install --without development test
COPY . $APP_HOME

# Check the version of the database via migrate.
RUN bundle exec rake db:migrate

# Precompile assets (JS, CSS).
RUN bundle exec rake assets:precompile

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
RUN chmod +x ./entrypoint.sh
ENTRYPOINT ["./entrypoint.sh", "$PORT"]
EXPOSE $PORT

# Start the main process.
CMD bundle exec rails server -b '0.0.0.0' -p 1301