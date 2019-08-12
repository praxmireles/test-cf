[![Build Status](https://codebuild.us-east-2.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoieGMvWWJxcmk1OGVEdXJNZnhnMU1GNHcwU1lOK0RKZDQrYlFxNi8wbGtEYm1WYkxXcG95RnJBUldHRHZMbzFpOWlLTGZIbjJtNm05VC80bWlOZUx2bVRvPSIsIml2UGFyYW1ldGVyU3BlYyI6IjdzblR0aG9zOUx3OHd6QWwiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=master)]


Minds With Purpose App
======================

# Readme

This README would normally document whatever steps are necessary to get the
application up and running.

## Prerequisites

This application is running on
* Rails 5.2.1
* Ruby 2.5.1
* Postgresql
* Docker

# Setup

## ENV

Details for the ENV variables are in the file. You can duplicate this file without the .sample
to be setup in development

* /.env.yml.sample

## Database

The database we're using for this project is postgresql

Create database.yml from database.yml.sample

* /config/database.yml.sample

You'll need the default values of
DATABASE_ADAPTER
DATABASE_HOST
DATABASE_PORT
DATABASE_USERNAME
DATABASE_PASSWORD

to start docker in development.

## Background processing

# Sidekiq
Sidekiq uses threads to handle many jobs at the same time in the same process. It does not require Rails but will integrate tightly with Rails to make background processing dead simple.

Run Sidekiq

`bundle exec sidekiq`

# Redis

In-memory data structure store, used as a database, cache and message broker.

Run Redis

`redis-server`

Both are necessary if you want to run the workers.


## Docker

This project is set with Docker. Check the `Dockerfile` and `docker-compose.yml`
for more config information.

We're using Docker because its not environment specific. It doesn't matter
if you're on a Windows machine or a Mac. We will all have the same environment.

To get started install Docker.
https://www.docker.com/community-edition#/download

** then create the container from the Dockerfile-Compose file**

`$ docker-compose build`

** Create the database **

`$ docker-compose run web rake db:create db:migrate db:seed RAILS_ENV=development`

** Seed **

To create a bunch of fake data (Appointment, Appointments Packs)

`rake db:seed:fake_data`

Seed with Fake Appointments. It will create:
- express_advice appointment (InProgress, Scheduled, Completed, Past)
- coaching introduction appointments (InProgress, Scheduled, Completed, Past)
- mentoring introduction appointments (InProgress, Scheduled, Completed, Past)

`rake db:seed:fake_appointments`

Or you can just create an appointment pack which wil create a bunch of
appointments (but no introduction session)

Seed with Fake appointmentsPack: It will create:
- mentoring appointment pack  (InProgress, Scheduled, Completed, Past)
- coaching appointment pack  (InProgress, Scheduled, Completed, Past)

`rake db:seed:fake_appointment_packs`

** then start the container **

`$ docker-compose up web`

The app will be exposed at

`localhost:3000`

**To stop the container:**

`$ docker-compose stop`

To check the containter processes:

`$ docker-compose ps`

# Run Tests

We're using Rubocop for checking the lint. To run the lint check.

`$ rubocop`

To run all the Unit Tests (and Integration Tests)

`$ rake test`

# Test Coverage

The test coverage threshold for a PR is 80%. Simplecove generate the test
coverage details in the _coverage_ folder.

> coverage/index.html

# Bug Tracking

We're tracking bugs with rollbar:

https://rollbar.com/richardsondx/MindWithPurpose

# Continuous Integration

https://semaphoreci.com/praxedismireles/mindswithpurpose

# Pull Request Checklist

* Chek that rubocop test pass
* Check that the Unit Test pass

# COMMIT ( CHANGELOG )

### Type of changes to use in your commits

`ADDED` for new features.

`CHANGED` for changes in existing functionality.

`DEPRECATED` for soon-to-be removed features.

`REMOVED` for now removed features.

`FIXED` for any bug fixes.

`SECURITY` in case of vulnerabilities.

Example of a commit message:
> e.g: FIXED issue with authenticaton, CHANGED login feature to use facebook, etc..

# VERSIONING

We are versioning the app by sprint. Tags are created at the end of each Sprint.
This will allow to track the state of an app at different stages of the development.
If a major issue is introduced, or there's major feature changes,
it'll make it easier to fix it or have a tag of reference.

To view all the existing tags from previous sprint type:

> $ git tag

To create a tag type:

> $ git tag -a v1 -m "SPRINT 1"

# Tasks

This project is managed on ClickUps. To view the project click here [https://app.clickup.com/69311](https://app.clickup.com/69311)

# COMMON ISSUES

### ENV variables not uploading

If your env variable stop updating as you change them. Try to stop the spring processes

`$ spring stop`

### Missing Seed data

Sometimes you may forget to run the seed

The seed data for:
- availabilities
- industies
- job_functions
- languages
- seniority_levels
- skills
- timezone

is located in the `db/seeds/` folders

by running `rake db:seed` it will automatically run all the seeds to populate the database with this information.

For getting time zones working correctly on clients and experts profiles please run `rake db:seed:populate_tznames`

### App Documentatin & RDOC

To generate the documentation for the app run

`rdoc --main README.md  app/**/*.rb app/**/**/*.rb lib/**/*.rb`

the documentation will be located in the /doc folder.


### Notifications

The Notificable concern contains the main logic of the notifications.

The only method you'll need to call to trigger an app notification and email notification is:


```
notify_user(category, options)
```

Available Categories and their available Actions:

 - :expert_enrollment (user_id)
 --- :expert_unfinished_enrollment
 --- :expert_finished_enrollment
 --- :admin_approve_expert
 --- :admin_reject_expert
 - :client_enrollment (user_id)
 --- :client_unfinished_enrollment
 --- :client_finished_enrollment
 --- :client_didnt_hire_expert
 - :appointment (appointment_id)
 --- :new_appointment_request
 --- :approved_appointment
 --- :appointment_is_rejected
 --- :appointment_is_cancelled
 --- :appointment_is_scheduled
 --- :appointment_will_start
 --- :appointment_started
 --- :appointment_completed
 --- :received_client_feedback
 --- :unanswered_request
 - :payment (payment_id)
 --- :paid_appointment
 --- :sent_payout

 Each category expects a combination of action and options:
 exampe of options are:
 - action
 - user_id
 - appointment_id
- payment_id

 ```
 notify_user(:expert_enrollment, {
  action: :expert_finished_enrollment,
  user_id: user.id
 })
 ```


Each notification is associated to a mailer.
notification_mailer.yml

To figure out or update what mailer is trigger bat what notification checkout the notification_mailer.yml file

To modify the text of a notification you'll have to edit the location file `en.yml`.
To add additional languages you'll have to create additional local file that follow the pattern of the english location file.

# DEPLOYMENT ( Staging )

We deploy to heroku using GIT

Make sure that Heroku was added to your git remote by doing

```
git remote -v
```

The remote for staging environemnt is 

```
staging	https://git.heroku.com/staging-mindswithpurpose.git
```

to deploy to [staging] type

```
git push staging master
```

and it will deploy the master branch to staging.

