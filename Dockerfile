# Use the official Ruby image as the base image
FROM ruby:3.1.2-alpine

# Install dependencies for Postgres
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile* ./

# Install dependencies
RUN bundle install

# Copy the rest of your application's code into the container
COPY . .

# Expose the port your app runs on
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
